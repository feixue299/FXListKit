import XCTest
@testable import FXListKit

final class FXListKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FXListKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
