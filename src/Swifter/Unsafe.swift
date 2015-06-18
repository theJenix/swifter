//
//  Unsafe.swift
//  COTFDemo
//
//  Created by Jesse Rosalia on 7/16/14.
//  Copyright (c) 2014 Jesse Rosalia. All rights reserved.
//

import Foundation

func unsafePointerToArray<T>(ptr: UnsafePointer<T>, length: Int) -> Array<T> {
    return [T](UnsafeBufferPointer(start: ptr, count: length))
}

//FIXME: probably not the most efficient...
func unsafePointerToNSData<T>(ptr: UnsafePointer<T>, length: Int) -> NSData {
    return NSData(bytes: ptr, length: length)
}