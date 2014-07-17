//
//  Unsafe.swift
//  COTFDemo
//
//  Created by Jesse Rosalia on 7/16/14.
//  Copyright (c) 2014 Jesse Rosalia. All rights reserved.
//

import Foundation

func unsafePointerToArray<T>(ptr: UnsafePointer<T>, length: Int) -> Array<T> {
    return [T](UnsafeArray(start: ptr, length: length))
}

//FIXME: probably not the most efficient...
func unsafePointerToNSData<T>(ptr: UnsafePointer<T>, length: Int) -> NSData {
    let array = [T](UnsafeArray(start: ptr, length: length))
    return NSData(bytes: array, length: array.count)
}