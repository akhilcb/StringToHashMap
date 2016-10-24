//
//  StringToHashMapTests.swift
//  StringToHashMapTests
//
//  Created by Akhil Balan on 10/24/16.
//  Copyright © 2016 akhil. All rights reserved.
//

import XCTest
@testable import StringToHashMap

class StringToHashMapTests: XCTestCase {
    
    var fileNameParser = FileNameParser ()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: Test validateFileName method
    
    func testValidateValidFileName() {
        let fileNameWithExt = "polar_cat_plane_swift.txt"
        let (didValidate, _, _) = fileNameParser.validateFileName(fileNameWithExt)
        XCTAssert(didValidate)
    }
    
    func testPerformanceValidateFileName() {
        let fileNameWithExt = "polar_cat_plane_swift.txt"
        self.measure {
            let (didValidate, _, _) = self.fileNameParser.validateFileName(fileNameWithExt)
            XCTAssert(didValidate)
        }
    }
    
    func testValidateInvalidFileName () {
        let fileNameWithExt = ""
        let (didValidate, fileName, errorText) = fileNameParser.validateFileName(fileNameWithExt)
        
        XCTAssertFalse(didValidate)
        XCTAssertNil(fileName)
        XCTAssertEqual(errorText, FileNameParserError.InvalidFileName.description)
    }
    
    func testValidateFileExtensionNotFound () {
        let fileNameWithExt = "test"
        let (didValidate, fileName, errorText) = fileNameParser.validateFileName(fileNameWithExt)
        
        XCTAssertFalse(didValidate)
        XCTAssertNil(fileName)
        XCTAssertEqual(errorText, FileNameParserError.FileExtensionNotFound.description)
    }
    
    func testValidateMultipleFileExtensionFound () {
        let fileNameWithExt = "test.txt.dat"
        let (didValidate, fileName, errorText) = fileNameParser.validateFileName(fileNameWithExt)
        
        XCTAssertFalse(didValidate)
        XCTAssertNil(fileName)
        XCTAssertEqual(errorText, FileNameParserError.MultipleFileExtensionFound.description)
    }
    
    func testValidateInvalidFileExtension () {
        let fileNameWithExt = "test."
        let (didValidate, fileName, errorText) = fileNameParser.validateFileName(fileNameWithExt)
        
        XCTAssertFalse(didValidate)
        XCTAssertNil(fileName)
        XCTAssertEqual(errorText, FileNameParserError.InvalidFileExtension.description)
    }
    
    
    // MARK: Test parseFileNameTextToHashMap method
    
    func testValidateParseFileName () {
        
        //valid case
        var fileName = "polar_cat_plane_swift"
        var hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 4)
        var val = hashMap["NAME"]
        XCTAssertTrue(val == "polar")
        
        //multiple underscore chars
        fileName = "polar____cat_plane_swift"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 4)
        
        //key repeated - c
        fileName = "polar_cat_ccccc_swift"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 3)
        val = hashMap["c"]
        XCTAssertTrue(val == "cccc")
        
        //key repeated multiple times with empty value
        fileName = "polar_c_c_c_c_c_c_c_swift"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 3)
        val = hashMap["c"]
        XCTAssertTrue(val == "")
        
        //2 keys
        fileName = "polar___swift"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 2)
        
        //1 key with no underscore char
        fileName = "polar"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 1)
        
        
        //1 char key
        fileName = "c"
        hashMap = fileNameParser.parseFileNameTextToHashMap(fileName)
        XCTAssertNotNil(hashMap)
        XCTAssertTrue(hashMap.keys.count == 1)
        val = hashMap["NAME"]
        XCTAssertTrue(val == "c")
    }
    
    
    // MARK: Test removeInvalidCharacters method
    
    func testRemoveInvalidCharacters () {
        var fileName = "polar_cat_plane_swift.txt"
        XCTAssertEqual(fileNameParser.removeInvalidCharacters(fileName), "polar_cat_plane_swift.txt")
        
        fileName = "polar_cat_plane/_swif:t.txt"
        XCTAssertEqual(fileNameParser.removeInvalidCharacters(fileName), "polar_cat_plane_swift.txt")
        
        fileName = "  a\n:   "
        XCTAssertEqual(fileNameParser.removeInvalidCharacters(fileName), "a")
    }
}
