import XCTest
@testable import LYHUD

final class LYHUDTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LYHUD().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
