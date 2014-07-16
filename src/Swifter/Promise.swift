//
//  Promise.swift
//
//  This file implements a Promise and Future class, used for asynchronous calls that return a value.
//
//  Created by Jesse Rosalia on 7/16/14.
//  Copyright (c) 2014 Jesse Rosalia. All rights reserved.
//

import Foundation

//
//protocol Future {
//    
//    typealias ValueType
//    
//    var value: ValueType? { get }
//    
//    func isValid() -> Bool
//    
//    //TODO wait, wait_for, wait_until
//}

class Future<T> {
    
    var value: T?
    
    func isValid() -> Bool {
        if let v = value {
            return true
        } else {
            return false
        }
    }
}


class Promise<T> {
    
    var pending: [((T) -> ())] = []
    
    var fail: (() -> ())?
    
    var rejected: Bool = false

    class func defer() -> Promise {
        return Promise()
    }
    
    func future() -> Future<T> {
        let f = Future<T>()
        then({ f.value = $0 })
        return f
    }
    
    func then(f: (T) -> ()) -> Promise {
        pending.append(f)
        return self
    }
    
    func fail(f: () -> ()) -> Promise {
        fail = f
        return self
    }
    
    func resolve(value: T?) -> () {
        if let v = value {
            for f in self.pending {
                if self.rejected {
                    fail?()
                    return
                }
                f(v)
            }
        } else {
            reject()
        }
        if self.rejected {
            fail?()
        }
    }
    
    func reject() -> () {
        self.rejected = true
    }
}