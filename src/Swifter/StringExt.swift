//
//  StringExt.swift
//  COTFDemo
//
//  Created by Jesse Rosalia on 7/23/14.
//  Copyright (c) 2014 Jesse Rosalia. All rights reserved.
//

import Foundation

extension String {
    
    func length() -> Int {
        return self.characters.count
    }

    //copied from http://stackoverflow.com/a/24045523/1050693
    subscript (r: Range<Int>) -> String {
        get {
            let subStart = self.startIndex.advancedBy(r.startIndex, limit: self.endIndex)
            let subEnd = subStart.advancedBy(r.endIndex - r.startIndex, limit: self.endIndex)
            return self.substringWithRange(subStart..<subEnd)
        }
    }
    func substring(from: Int) -> String {
        let end = self.length()
        return self[from..<end]
    }
    func substring(from: Int, length: Int) -> String {
        let end = from + length
        return self[from..<end]
    }
    
    func grouped(n: Int) -> Array<String> {
        let length = self.length()
        let groupCount = Int(ceil(Double(length) / Double(n)))
        var groups = Array<String>()
        for i in 0..<groupCount {
//            advance()
//            let rng:Range<String.Index> = Range(start: n * i, end: min(n * (i + 1), length - 1))
            let rng = (n * i)..<min(n * (i + 1), length)
            groups.append(self[rng])
        }
        return groups
    }
    
    /**
     * Map a function over the string.  This function is useful for applying tests/changing values in the middle of a method chain
     */
    func map(f: (String -> String?)) -> String? {
        return f(self)
    }
    
    /**
     * Generic trim function assumes we want to trim white space and new line characters
     */
    func trim() -> String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}