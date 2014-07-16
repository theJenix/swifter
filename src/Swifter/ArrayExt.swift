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

extension Array {
    
    func findFirst(pred: (T -> Bool)) -> T? {
        return findFirstInArray(self, pred)
    }
}