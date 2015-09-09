//
//  Promise.swift
//
//  This file implements Promise and Future classes, used for asynchronous calls that return a value.
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

public class Future<T> {
    
    var succeed: (T -> ())?
    
    var fail: (() -> ())?
    
    var value: T?
    
    var failed: Bool = false

    public init(value: T? = nil) {
        self.value = value
    }

    func isValid() -> Bool {
        if let v = value {
            return true
        } else {
            return false
        }
    }

    func failure() {
        self.failed = true
        self.fail?()
    }

    func success(value: T) {
        self.value = value
        succeed?(value)
    }

    public func onSuccess(f: (T -> ())) -> Self {
        self.succeed = f
        if let v = value {
            self.succeed?(v)
        }
        return self
    }
    
    public func onFailure(f: (() -> ())) -> Self {
        self.fail = f
        if self.failed {
            self.fail?()
        }
        return self
    }
}


public class Promise<T> {
    
    var pending: [((T) -> ())] = []
    
    var fail: (() -> ())?
    
    var rejected: Bool = false

    public class func defer() -> Promise {
        return Promise()
    }
    
    public func future() -> Future<T> {
        let f = Future<T>()
        then(f.success)
        fail(f.failure)
        return f
    }
    
    func then(f: (T) -> ()) -> Self {
        pending.append(f)
        return self
    }
    
    func fail(f: () -> ()) -> Self {
        //TODO: multiple failure handlers
        fail = f
        return self
    }
    
    public func resolve(value: T?) -> () {
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
    public func resolveWith(future: Future<T>) {
        future.onSuccess({ self.resolve($0) })
              .onFailure({ self.resolve(nil) })
    }

    func reject() -> () {
        self.rejected = true
    }
}