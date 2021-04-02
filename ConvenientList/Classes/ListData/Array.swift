//
//  Array.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Element? {
        if index >= count {
            assertionFailure("Index out of bounds!Index: \(index), Count: \(count)")
            return nil
        }
        return self[index]
    }
}
