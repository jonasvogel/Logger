# Logger

A very simple, but extensible logger for Swift projects.

## Installation

### Swift Package Manager

- Just select _File / Swift Packages / Add Package Dependency_ in Xcode and add `https://github.com/jonasvogel/logger.git` to your project.

### CocoaPods

Add the following line to your `Podfile`:
```
pod 'Logger', :git => 'https://github.com/jonasvogel/logger.git'
```

## Usage

There are two different logging levels: `.debug` and `.error`. The logger provides two very short helper functions to access the corresponding logging functions and can also be called with some data to provide more context:

```
Logger.d("This is a debug statement.")
Logger.e("An error occurred.", data: ["error": 404])
```
The default logger is intended for development environments and logs the messages the standard console via `NSLog(_ format: String, _ args: CVarArg...)`. The above lines would result in the following output:
```
🔵 Debug: This is a debug statement.
🛑 Error: An error occurred. -- Data: ["error": 404]
```

## Extending for Release Builds

For release builds, it is recommended to create an own `LogHandler` that can, for example, forward errors to your favourite reporting tool. There is only one method that has to be implemented and where you can handle error logging for production environments:
```
class ProductionLogHandler: LogHandler {
    func log(message: String, level: Logger.Level, data: [String: Any]?) {
        
        // Only sent error logs
        if case .error = level {
            
            // Your custom production logger here…
        }
    }
}

#if RELEASE
Logger.sharedInstance.logHandler = ProductionLogHandler()
#endif
```

**Note:** Do not log any sensitive user information, even during development.




