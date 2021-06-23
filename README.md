# SwiftyWebSocket

<a href="https://img.shields.io/badge/Swift-5.1_5.2_5.3_5.4-Orange?style=flat-square" rel="nofollow"><img src="https://camo.githubusercontent.com/ce094fe03ae4b4590f88de1ecd344ec1be3cc3c9ccd37c6431d062ab308c9fe3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d352e315f352e325f352e335f352e342d6f72616e67653f7374796c653d666c61742d737175617265" alt="Swift" data-canonical-src="https://img.shields.io/badge/Swift-5.1_5.2_5.3_5.4-orange?style=flat-square" style="max-width:100%;"></a>
<a target="_blank" rel="noopener noreferrer" href="https://camo.githubusercontent.com/8dfb74eaa3d024d50e6a76b555774892ac0687f1afd1471b00cfca975cffeed9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6f732d694f532d677265656e2e7376673f7374796c653d666c6174"><img src="https://camo.githubusercontent.com/8dfb74eaa3d024d50e6a76b555774892ac0687f1afd1471b00cfca975cffeed9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6f732d694f532d677265656e2e7376673f7374796c653d666c6174" alt="iOS" data-canonical-src="https://img.shields.io/badge/os-iOS-green.svg?style=flat" style="max-width:100%;"></a>

Using this library you can easily integrate websockets in your project. It supports ios 13 and above.

# Installation
Cocoapods
Add this to your Podfile:

```
pod 'SwiftyWebSocket'
```
And run then ```pod install```

# Code examples
Import this code on the top of your file
```swift
import SwiftyWebSocket
```
Then initialize WebSocket class and call connet function

```
let webSocket = WebSocket(url: URL(string: "your socket url")!)
webSocket.connect()
```
# Connect and Disconnect Socket
You shouldn't call this methods after application either willEnterForeground or didEnterBackground in this methods because library handles this cases by himself.

```swift
webSocket.connect()

```

```swift
webSocket.disconnect()

```
after either connect or disconnect you can listen 2 subject 

```swift
webSocket.connectSubject.sink {
    print("conneted")
}.store(in: &cancellables)

```

```swift
webSocket.disconnectSubject.sink {
    print("disconnect")
}.store(in: &cancellables)

```


# Send data
You can send Message via 2 types, String and Data.
```swift
webSocket.sendDataMessage(form)
  .sink { error in
     print(error)
  }.store(in: &cancellables)
  
   webSocket.sendStringMessage(form)
  .sink { error in
     print(error)
  }.store(in: &cancellables)
  
  ```
  
# Receive Data
```swift
webSocket.receiveData().flatMap { (result) -> AnyPublisher<URLSessionWebSocketTask.Message, Error> in
   return Just(result).setFailureType(to: Error.self).eraseToAnyPublisher()
 }.sink { [weak self] (completion) in
   print(completion)
 } receiveValue: { [weak self] (message) in
    // your code is here
 }.store(in: &cancellables)
 ```


  
