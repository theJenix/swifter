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
        return countElements(self)
    }

    //copied from http://stackoverflow.com/a/24045523/1050693
    subscript (r: Range<Int>) -> String {
        get {
            let subStart = advance(self.startIndex, r.startIndex, self.endIndex)
            let subEnd = advance(subStart, r.endIndex - r.startIndex, self.endIndex)
            return self.substringWithRange(Range(start: subStart, end: subEnd))
        }
    }
    func substring(from: Int) -> String {
        let end = countElements(self)
        return self[from..<end]
    }
    func substring(from: Int, length: Int) -> String {
        let end = from + length
        return self[from..<end]
    }
    
    func grouped(n: Int) -> Array<String> {
        var length = self.length()
        var groupCount = Int(ceil(Double(length) / Double(n)))
        var groups = Array<String>()
        for i in 0..<groupCount {
//            advance()
//            let rng:Range<String.Index> = Range(start: n * i, end: min(n * (i + 1), length - 1))
            let rng = (n * i)..<min(n * (i + 1), length)
            groups.append(self[rng])
        }
        return groups
    }
}