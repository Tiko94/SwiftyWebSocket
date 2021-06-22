//
//  WebSocket.swift
//  Socket
//
//  Created by MacBook on 22.06.21.
//

import Combine
import UIKit

public class WebSocket: NSObject {
    
    // MARK: - Variables
    private var webSocketTask: URLSessionWebSocketTask!
    private var delegateQueue = OperationQueue()
    private var cancellables: Set<AnyCancellable> = []
    private var url: URL!
    public var connectSubject = PassthroughSubject<Void, Never>()
    public var disconnectSubject = PassthroughSubject<Void, Never>()
    
    // MARk: - Init
    public init(url: URL) {
        super.init()
        self.url = url
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification, object: nil)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.connect()
            }.store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification, object: nil)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.disconnect()
            }.store(in: &cancellables)
    }
    
    // MARK: - Change Statement
    public func connect() {
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: delegateQueue)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask.resume()
    }
    
    public func disconnect() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    // MARK: - Ping pong
    public func ping() -> Future<Error?, Never> {
        Future { [weak self] promise in
            guard let self = self else { return }
            self.webSocketTask.sendPing { (error) in
                promise(.success(error))
            }
        }
    }
    
    // MARK: - Working with Data
    public func sendStringMessage(_ object: Codable) -> Future<Error?, Never> {
        Future { [weak self] promise in
            guard let self = self else { return }
            self.webSocketTask.send(.string(object.toJsonString())) { error in
                promise(.success(error))
            }
        }
    }
    
    public func sendDataMessage(_ object: Codable) -> Future<Error?, Never> {
        Future { [weak self] promise in
            guard let self = self else { return }
            if let data = object.toJSONData() {
                self.webSocketTask.send(.data(data)) { error in
                    promise(.success(error))
                }
            }
        }
    }
    
    @discardableResult
    public func receiveData() -> Future<URLSessionWebSocketTask.Message, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            self.webSocketTask.receive { result in
                self.receiveData()
                promise(result)
            }
        }
    }
}

extension WebSocket: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        self.connectSubject.send()
    }
       
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.disconnectSubject.send()
    }
}
