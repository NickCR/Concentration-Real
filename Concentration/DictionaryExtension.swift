//
//  DictionaryExtension.swift
//  Concentration
//
//  Created by Jelly Slather on 2/10/18.
//  Copyright © 2018 Rudinski. All rights reserved.
//

import Foundation

extension Dictionary{
    public mutating func dictRandomSelection(dictOriginal: Dictionary<Int, Array<String>>) -> [String]{
        let randomVal = Int(arc4random_uniform(UInt32(dictOriginal.count)))
        let dictSelection = Array(dictOriginal.values)[randomVal]
        return dictSelection
    }
}
