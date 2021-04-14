//
//  UIResponder.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIResponder {
    @objc func router(_ event: String, paramaters: Any? = nil) {
        next?.router(event, paramaters: paramaters)
    }
}
