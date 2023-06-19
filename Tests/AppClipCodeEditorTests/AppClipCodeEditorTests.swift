import XCTest
@testable import AppClipCodeEditor

final class AppClipCodeEditorTests: XCTestCase {

    func testIndex0() throws {
        let originalFileString = try getStringForFile("test1")
        let resultFileString = try getStringForFile("test0")
        let test = AppClipCodeTheme.index0
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex1() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test1")
        let test = AppClipCodeTheme.index1
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex2() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test2")
        let test = AppClipCodeTheme.index2
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }


    func testIndex3() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test3")
        let test = AppClipCodeTheme.index3
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex4() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test4")
        let test = AppClipCodeTheme.index4
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex5() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test5")
        let test = AppClipCodeTheme.index5
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex6() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test6")
        let test = AppClipCodeTheme.index6
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex7() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test7")
        let test = AppClipCodeTheme.index7
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex8() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test8")
        let test = AppClipCodeTheme.index8
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex9() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test9")
        let test = AppClipCodeTheme.index9
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex10() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test10")
        let test = AppClipCodeTheme.index10
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex11() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test11")
        let test = AppClipCodeTheme.index11
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex12() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test12")
        let test = AppClipCodeTheme.index12
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex13() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test13")
        let test = AppClipCodeTheme.index13
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex14() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test14")
        let test = AppClipCodeTheme.index14
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex15() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test15")
        let test = AppClipCodeTheme.index15
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex16() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test16")
        let test = AppClipCodeTheme.index16
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndex17() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test17")
        let test = AppClipCodeTheme.index17
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertEqual(resultFileString, modifiedFileString)
    }

    func testIndexFail() throws {
        let originalFileString = try getStringForFile("test0")
        let resultFileString = try getStringForFile("test17")
        let test = AppClipCodeTheme.index13
        let modifiedFileString = test.replace(svg: originalFileString)
        XCTAssertNotEqual(resultFileString, modifiedFileString)
    }

    func getStringForFile(_ fileName: String) throws -> String {
        let sourceFileURL = URL(fileURLWithPath: #file)
        let sourceFileDirectoryURL = sourceFileURL.deletingLastPathComponent()
        let resourceURL = sourceFileDirectoryURL.appendingPathComponent("\(fileName).svg")
        let data = try Data(contentsOf: resourceURL)
        return try XCTUnwrap(String(data: data, encoding: .utf8))
    }

}
