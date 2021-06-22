//
//  Encodable+Extensions.swift
//  Socket
//
//  Created by MacBook on 22.06.21.
//

import Foundation


extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
    
    
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    func toJsonString() -> String {
        let dict = try! self.toDictionary()
        if JSONSerialization.isValidJSONObject(dict) {
            var jsonData = NSData()
            jsonData =  try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
            if let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
        }
        return ""
    }
}
