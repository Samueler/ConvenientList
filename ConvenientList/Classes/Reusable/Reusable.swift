//
//  Reusable.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import UIKit

public protocol Reusable {
    static var identifier: String { get }
}

public extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
