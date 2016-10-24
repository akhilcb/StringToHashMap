//
//  ViewController.swift
//  StringToHashMap
//
//  Created by Akhil Balan on 10/24/16.
//  Copyright © 2016 akhil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fileNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    
    //initialize parser business class
    var fileNameParser = FileNameParser ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set default text in text field
        fileNameTextField.text = "polar_cat_plane_swift.txt"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //done button tapped event
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let enteredFileNameWithExt = fileNameTextField.text {
            let displayText = fileNameParser.processFileNameText(enteredFileNameWithExt)
            displayTextInOutputView(displayText)
            print(displayText) //print in console
        }
    }
    
    //display output text or error text in output text view
    func displayTextInOutputView(_ text : String?) {
        outputTextView.text = text
    }
}

