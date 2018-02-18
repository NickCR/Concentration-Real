//
//  ArrayExtenstions.swift
//  Concentration
//
//  Created by Jelly Slather on 2/10/18.
//  Copyright © 2018 Rudinski. All rights reserved.
//

import Foundation

extension Array {
    public mutating func shuffle() {
        var tempArray = [Element]()
        while !isEmpty {
            let i = arc4random_uniform(UInt32(count))
            let obj = remove(at: Int(i))
            tempArray.append(obj)
        }
        self = tempArray
    //new array take random numbers and insert at next index
    }
}
