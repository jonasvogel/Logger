# Logger

A very simple, but extensible Logger for Swift projects.

## Installation

### Swift Package Manager

- Just add this repository's URL to your project by selecting _File / Swift Packages / Add Package Dependency_ in Xcode.

## Usage

There are two different logging levels: `.debug` and `.error`. The logger provides to very short helper functions to access the corresponding logging functions and can also be provided with some data to provide some context:

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




