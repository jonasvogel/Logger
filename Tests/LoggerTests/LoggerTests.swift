import XCTest
@testable import Logger

final class LoggerTests: XCTestCase {
    
    private static let logger = TestLogHandler()
    
    override class func setUp() {
        Logger.sharedInstance.logHandler = logger
    }
    
    
    func testDebug() {
        
        let message = "Hello Debug."
        
        Logger.d(message)
        
        XCTAssertEqual(Self.logger.lastLoggedMessage, message)
        XCTAssertEqual(Self.logger.lastLoggedLevel, .debug)
        XCTAssertNil(Self.logger.lastLoggedData)
    }
    
    
    func testDebugWithData() throws {
        
        let message = "Hello Debug."
        let dataLabel = "world"
        let dataContent = [1, 2, 3, 4]
        
        Logger.d(message, data: [dataLabel: dataContent])
        
        XCTAssertEqual(Self.logger.lastLoggedMessage, message)
        XCTAssertEqual(Self.logger.lastLoggedLevel, .debug)
        
        let data = try XCTUnwrap(Self.logger.lastLoggedData)
        let firstKey = try XCTUnwrap(data.keys.first)
        let firstValueAny = try XCTUnwrap(data.values.first)
        
        guard let firstValue = firstValueAny as? [Int] else {
            XCTFail("Expected logged data value to be of same type as input data value.")
            return
        }
        
        XCTAssertEqual(firstKey, dataLabel)
        XCTAssertEqual(firstValue, dataContent)
        
    }

    static var allTests = [
        ("testDebug", testDebug),
        ("testDebugWithData", testDebugWithData),
    ]
}

/// This is a LogHandler used for testing the internal logging mechanisms.
///
/// It saves the last logged message, level and data so that they can be checked after calling one of the logging functions.
class TestLogHandler: LogHandler {
    
    public var lastLoggedMessage = ""
    public var lastLoggedLevel: Logger.Level = .debug
    public var lastLoggedData: [String : Any]? = [:]
    
    func log(message: String, level: Logger.Level, data: [String : Any]?) {
        lastLoggedMessage = message
        lastLoggedLevel = level
        lastLoggedData = data
    }
    
    
}
