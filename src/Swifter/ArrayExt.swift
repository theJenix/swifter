//
//  ArrayExt.swift
//
//  This file defines functions that perform useful operations on arrays, and declares them
//  both as stand alone functions and as extension on the Array type.  The stand alone
//  functions can also be used to operate on NSArray and NSMutableArray objects.
//
//  Created by Jesse Rosalia on 7/16/14.
//  Copyright (c) 2014 Jesse Rosalia. All rights reserved.
//

import Foundation

func mapArray<T,U>(array: Array<T>, f: (T -> U)) -> Array<U> {
    return array.map(f)
}

func findFirstInArray<T>(array: Array<T>, pred: (T -> Bool)) -> T? {
    let found = array.filter(pred)
    if (found.isEmpty) {
        return nil
    } else {
        return found[0] as T
    }
}


func forEachInArray<T>(array: Array<T>, f: (T -> ())) {
    for elem in array {
        f(elem)
    }
}

//FIXME: adding these extensions, or any functions that take a function argument, will cause the swift compiler to crash
// (see my answer to https://stackoverflow.com/questions/24154163/xcode-swift-failed-with-exit-code-254/24793423) -- JR, 07/16/14
extension NSArray {
//    
//    func findFirst(pred: (AnyObject -> Bool)) -> AnyObject? {
//        return findFirstInArray(self, pred)
//    }
//
//    func foreach(f: (AnyObject -> ())) {
//        for elem in self {
//            f(elem)
//        }
//    }
}

extension Array {
    
    func findFirst(pred: (T -> Bool)) -> T? {
        return findFirstInArray(self, pred)
    }

    func foreach(f: (T -> ())) {
        forEachInArray(self, f)
    }
 
    func grouped(n: Int) -> Array<Array<T>> {
        var length = self.count
        var groupCount = Int(ceil(Double(length) / Double(n)))
        var groups = Array<Array<T>>()
        for i in 0..<groupCount {
            //            advance()
            //            let rng:Range<String.Index> = Range(start: n * i, end: min(n * (i + 1), length - 1))
            let rng = (n * i)..<min(n * (i + 1), length)
            let slice = self[rng]
            groups.append(Array(slice))
        }
        return groups
    }
}
