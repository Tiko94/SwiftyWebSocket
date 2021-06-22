# SwiftyWebSocket


SwiftyWebSocket library provides you to use websockets with easy way. It supports ios 13 and above, and you should use Combine.

# Installation
Cocoapods
Add this to your Podfile:

```
pod 'SwiftyWebSocket'
```
And run then ```pod install```

# Code examples
Import this code on the top of your file
```
import SwiftyWebSocket
```
Then initialize WebSocket class and call connet function

```
let webSocket = WebSocket(url: URL(string: "your socket url")!)
webSocket.connect()
```
# Connect and Disconnect Socket
You shouldn't call this methods after application either willEnterForeground or didEnterBackground in this methods because library handles this cases by himself.

```
webSocket.connect()

```

```
webSocket.disconnect()

```
after either connect or disconnect you can listen 2 subject 

```
webSocket.connectSubject.sink {
    print("conneted")
}.store(in: &cancellables)

```

```
webSocket.disconnectSubject.sink {
    print("disconnect")
}.store(in: &cancellables)

```


# Send data
You can send Message via 2 types, String and Data.
```
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
```
webSocket.receiveData().flatMap { (result) -> AnyPublisher<URLSessionWebSocketTask.Message, Error> in
   return Just(result).setFailureType(to: Error.self).eraseToAnyPublisher()
 }.sink { [weak self] (completion) in
   print(completion)
 } receiveValue: { [weak self] (message) in
    // your code is here
 }.store(in: &cancellables)
 ```


  
