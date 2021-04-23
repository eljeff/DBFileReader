import Foundation
import XCTest
@testable import DBFileReader

final class DBFileReaderTests: XCTestCase {
    func testTSV() {
        let reader = DBFileReader(localURL: Bundle.module.url(forResource: "Sample Data/sampledata.tsv", withExtension: nil)!)
        let data = reader.dbFileData!
        XCTAssertEqual(data[0][0], "first name")
        XCTAssertEqual(data[1][0], "helen")
        XCTAssertEqual(data[0][5], "zip")
        XCTAssertEqual(data[1][5], "78745")
    }

    static var allTests = [
        ("testTSV", testTSV),
    ]
}
