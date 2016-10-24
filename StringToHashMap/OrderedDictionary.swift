//
//  OrderedDictionary.swift
//  StringToHashMap
//
//  Created by Akhil Balan on 10/24/16.
//  Copyright © 2016 akhil. All rights reserved.
//

import Foundation

struct OrderedDictionary<Tkey : Hashable, Tvalue> : CustomStringConvertible {
    var keys : [Tkey] = []
    var values : [Tkey : Tvalue] = [:]
    
    init() {
    }
    
    public subscript (key : Tkey) -> Tvalue? {
        get {
            return self.values[key]
        }
        
        set (newValue) {
            if newValue == nil {
                self.values.removeValue(forKey: key)
                if let index = self.keys.index(of: key) {
                    self.keys.remove(at: index)
                }
            } else {
                let prevValue = self.values.updateValue(newValue!, forKey: key)
                if prevValue == nil {
                    self.keys.append(key)
                }
            }
        }
    }
    
    var description : String {
        var desc = "{\n"
        for i in 0..<self.keys.count {
            let key = self.keys[i]
            desc += "  \"\(key)\"" + " : " + "\"\(self.values[key]!)\"" + "\n"
        }
        desc += "};\n"
        return desc
    }
}
