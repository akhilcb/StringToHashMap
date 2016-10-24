//
//  StringToHashMapUITests.swift
//  StringToHashMapUITests
//
//  Created by Akhil Balan on 10/24/16.
//  Copyright © 2016 akhil. All rights reserved.
//

import XCTest

class StringToHashMapUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFileNameParserViewController () {
        
        XCUIApplication().buttons["Done"].tap()
        
        let app = XCUIApplication()
        let pleaseEnterTheFileNameTextField = app.textFields["Please enter the file name"]
        let textView = app.otherElements.containing(.textField, identifier:"Please enter the file name").children(matching: .textView).element
        
        pleaseEnterTheFileNameTextField.tap()
        
        let clearTextButton = app.buttons["Clear text"]
        clearTextButton.tap()
        pleaseEnterTheFileNameTextField.typeText("polar_cat.txt")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        pleaseEnterTheFileNameTextField.tap()
        clearTextButton.tap()
        
        pleaseEnterTheFileNameTextField.typeText(".txt")
        doneButton.tap()
        clearTextButton.tap()
        
        var text = textView.value as! String
        XCTAssertEqual(text, "Invalid file name. Please enter a valid file name.")
        
        pleaseEnterTheFileNameTextField.typeText("polar")
        doneButton.tap()
        
        text = textView.value as! String
        XCTAssertEqual(text, "Could not find any file extension.")
        
        pleaseEnterTheFileNameTextField.tap()
        pleaseEnterTheFileNameTextField.typeText(".txt.dat")
        doneButton.tap()
        
        text = textView.value as! String
        XCTAssertEqual(text, "Found more than one file extension.")
        
        clearTextButton.tap()
        
        pleaseEnterTheFileNameTextField.typeText("______")
        doneButton.tap()
        
        pleaseEnterTheFileNameTextField.tap()
        pleaseEnterTheFileNameTextField.typeText(".txt")
        doneButton.tap()
    }
}
