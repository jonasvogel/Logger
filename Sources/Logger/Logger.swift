//
//  Logger.swift
//
//  Created by Jonas Vogel on 30.10.20.
//

import Foundation

/// Provides the ability to log custom debug or error messages.
///
/// Use `Logger.sharedInstance` to access its functions (singleton pattern).
public class Logger {
    
    /// The singleton shared instance of the logger that can be used accross the project.
    public static let sharedInstance = Logger()
    
    /// The importance of a log message. For example, messages of the error level can be handled differently by the `LogHandler`.
    public enum Level {
        case error
        case debug
        
        var emoji: String {
            switch self {
            case .debug:
                return "🔵"
            case .error:
                return "🛑"
            }
        }
        
        /// A (non-localized) description of the log level.
        var description: String {
            switch self {
            case .debug:
                return "Debug"
            case .error:
                return "Error"
            }
        }
    }
    
    /// Handles incoming log messages. Defaults to `DebugLogHandler`.
    public var logHandler: LogHandler = DebugLogHandler()
    
    
    /// Logs a message which is handled by a `LogHandler`.
    /// - Parameters:
    ///   - message: A short description of the error.  **Make sure the string is the same for all errors of the same type. Do not include any variable in it!** Use the data array instead.
    ///   - level: The log level determines how important the log entry is.
    ///   - data: Some data that is useful to reproduce an error. **Do not include any private user data!**
    public func log(_ message: String, level: Level, data: [String: Any]? = nil) {
        logHandler.log(message: message, level: level, data: data)
    }
    
    /// Shorthand function to log a debug statement.
    /// - Parameters:
    ///   - message: A short description of the error.  **Make sure the string is the same for all errors of the same type. Do not include any variable in it!** Use the data array instead.
    ///   - data: Some data that is useful to reproduce an error. **Do not include any private user data!**
    public static func d(_ message: String, data: [String: Any]? = nil) {
        sharedInstance.log(message, level: .debug, data: data)
    }
    
    /// Shorthand function to log an error.
    /// - Parameters:
    ///   - message: A short description of the error.  **Make sure the string is the same for all errors of the same type. Do not include any variable in it!** Use the data array instead.
    ///   - data: Some data that is useful to reproduce an error. **Do not include any private user data!**
    public static func e(_ message: String, data: [String: Any]? = nil) {
        sharedInstance.log(message, level: .error, data: data)
    }
    
}


/// Handle incoming log messages, e.g. print it to the console during development or send errors to an external service.
public protocol LogHandler {
    
    /// Handle a log message.
    /// - Parameters:
    ///   - message: A short description of the error.  **Make sure the string is the same for all errors of the same type. Do not include any variable in it!** Use the data array instead.
    ///   - level: The log level determines how important the log entry is.
    ///   - data: Some data that is useful to reproduce an error. **Do not include any private user data!**
    
    func log(message: String, level: Logger.Level, data: [String: Any]?)
}


/// The default log handler. Prints the content using `NSLog()`.
public class DebugLogHandler: LogHandler {
    public func log(message: String, level: Logger.Level, data: [String: Any]? = nil) {
        
        NSLog("%@ %@: %@ -- Data: %@", level.emoji, level.description , message, String(describing: data))
    }
}
