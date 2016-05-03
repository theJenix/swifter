//
//  ObjectExt.swift
//  RecipeBuilderCli
//
//  Created by Jesse Rosalia on 6/19/15.
//  Copyright (c) 2015 Jesse Rosalia. All rights reserved.
//

import Foundation

//TODO: pull out into library for GSON like object serialization (build on top of Alamofire and OCMapper?)
public func toDictionary<T:NSObject>(foo:T) -> Dictionary<String,AnyObject> {
    let aClass : AnyClass? = foo.dynamicType
    return toDictionaryA(foo, aClass: aClass!)
}

func toDictionaryA<T:NSObject>(foo:T, aClass:AnyClass) -> Dictionary<String,AnyObject> {
    var propertiesCount : CUnsignedInt = 0
    
    var propertiesDictionary:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
    
    let propertiesInAClass : UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &propertiesCount)
    for i in 0 ..< Int(propertiesCount) {
        let strKey : String? = NSString(CString: property_getName(propertiesInAClass[i]), encoding: NSUTF8StringEncoding) as String?
        if let sk = strKey {
            // Note: we can assume that this will return something valid
            //...because otherwise it will throw a NSUndefinedKeyException
            let vfk: AnyObject? = foo.valueForKey(sk)
            if let val: AnyObject = vfk {
                //TODO: support sets and dictionaries
                //HACK
                if let array = val as? Array<String> {
                    propertiesDictionary[sk] = array
                } else if let array = val as? Array<NSObject> {
                    propertiesDictionary[sk] = array.map(toDictionary)
                } else if let obj = val as? NSObject {
                    //NOTE: need to check property count before checking objects...lots of simple objects (String, Int) with simple values
                    // extend NSObject, and we'll end up generating bizarre results in that case
                    var attrPropertiesCount : CUnsignedInt = 0
                    class_copyPropertyList(val.dynamicType, &attrPropertiesCount)
                    if attrPropertiesCount != 0 {
                        propertiesDictionary[sk] = toDictionary(obj)
                    } else {
                        propertiesDictionary[sk] = val
                    }
                } else {
                    //TODO: should warn that this object has properties but does not support
                    // NSObject KVC
                    propertiesDictionary[sk] = nil
                }
                //TODO: decide if we want to set nil or skip these values altogether
                //            } else {
                //                propertiesDictionary.setValue(nil, forKey: sk)
            }
        }
    }
//FIXME: must solve this soon....restricts what model objects we can use
//    let superclassProperties = toDictionaryA(foo, aClass.superclass)
//    for (k,v) in superclassProperties {
//        propertiesDictionary[k] = v
//    }
    return propertiesDictionary
}

