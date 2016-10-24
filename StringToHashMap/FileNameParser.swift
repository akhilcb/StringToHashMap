//
//  FileNameParser.swift
//  StringToHashMap
//
//  Created by Akhil Balan on 10/24/16.
//  Copyright © 2016 akhil. All rights reserved.
//

import Foundation

// MARK: FileNameParserError enum implementation

enum FileNameParserError : String {
    case InvalidFileName = "Invalid file name. Please enter a valid file name."
    case FileExtensionNotFound = "Could not find any file extension."
    case MultipleFileExtensionFound = "Found more than one file extension."
    case InvalidFileExtension = "Invalid file extension."
    case WritingFailed = "Error in writing to file."
    
    var description : String {
        get {
            return self.rawValue
        }
    }
}

// MARK: FileNameParser implementation

class FileNameParser {
    
    init() {
    }
    
    //process file name text entered in text field by validating, writing to file and return output text for displaying in output view
    func processFileNameText(_ fileNameText: String) -> String {
        
        var displayText : String
        let fileNameWithExt = removeInvalidCharacters(fileNameText)
        let (didValidate, fileName, errorText) = validateFileName(fileNameWithExt)
        
        if didValidate {
            
            let hashMap = parseFileNameTextToHashMap(fileName!)
            let (didWrite, path, writeErrorText) = writeHashMapToFile(hashMap, withName: fileNameWithExt)
            
            if didWrite {
                displayText = finalOutputText(fileNameWithExt, withHashMap: hashMap, path: path!)
            } else {
                displayText = writeErrorText!
            }
        } else {
            displayText = errorText!
        }
        
        return displayText
    }
    
    //parse filename and return ordered dictionary
    func parseFileNameTextToHashMap(_ fileName : String) -> OrderedDictionary <String, String> {
        
        var nameArray = fileName.components(separatedBy: "_")
        var fileDict = OrderedDictionary <String, String> ()
        fileDict["NAME"] = nameArray.first
        
        for i in 1..<nameArray.count {
            let content = nameArray[i]
            
            if content.characters.count > 0 {
                let index = content.index(after: content.startIndex)
                let key = content.substring(to: index)
                let val = content.substring(from: index)
                fileDict[key] = val
            }
        }
        
        return fileDict
    }
    
    //write to a file in document directory and return success/failture, path to file, error text
    func writeHashMapToFile(_ hashMap : OrderedDictionary <String, String>, withName name : String) -> (Bool, URL?, String?) {
        
        let fileText = "\(hashMap)"
        var path : URL?
        var didWrite = true
        var errorText : String?
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            path = dir.appendingPathComponent(name)
            
            do {
                try fileText.write(to: path!, atomically: false, encoding: String.Encoding.utf8)
            } catch {
                didWrite = false
                errorText = FileNameParserError.WritingFailed.description
            }
        }
        
        return (didWrite, path, errorText)
    }
    
    //validate file name and extension and return validFileName flag, file name and error text
    func validateFileName(_ fileNameWithExt: String) -> (Bool, String?, String?) {
        
        let fileNameWithExtArray = fileNameWithExt.components(separatedBy: ".")
        var fileName : String?
        var validFileName = false
        var displayErrorText : String?
        
        switch (fileNameWithExt, fileNameWithExtArray.count, fileNameWithExtArray.first, fileNameWithExtArray.last) {
            
        case let (fileNameWithExt, count, fileName, _) where ((fileNameWithExt == "") || (count == 2 && fileName == "")) :
            displayErrorText = FileNameParserError.InvalidFileName.description
            break
        case (_, 1, _, _) :
            displayErrorText = FileNameParserError.FileExtensionNotFound.description
            break
        case let (_, count, _, _) where count > 2 :
            displayErrorText = FileNameParserError.MultipleFileExtensionFound.description
            break
        case let (_, count, _, ext) where count == 2 && ext == "" :
            displayErrorText = FileNameParserError.InvalidFileExtension.description
            break
        default:
            fileName = fileNameWithExtArray.first
            validFileName = true
        }
        
        return (validFileName, fileName, displayErrorText)
    }
    
    //remove invalid characters from file name
    func removeInvalidCharacters(_ text : String) -> String {
        
        var invalidCharacters = CharacterSet(charactersIn: ":/")
        invalidCharacters.formUnion(CharacterSet.newlines)
        invalidCharacters.formUnion(CharacterSet.illegalCharacters)
        invalidCharacters.formUnion(CharacterSet.controlCharacters)
        
        var validText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        validText = validText.components(separatedBy: invalidCharacters).joined(separator: "")
        
        return validText
    }
    
    //create final output text based on hashmap, file name and path
    func finalOutputText(_ fileNameWithExt : String, withHashMap hashmap : OrderedDictionary <String, String>, path : URL) -> String {
        let displayText = "Filename " + fileNameWithExt + " saved with contents:\n\n" + "\(hashmap)" + "\nAt path: " + "\(path)"
        return displayText
    }
}
