//
//  Person.swift
//  rxswiftdemo2
//
//  Created by Alex on 10/03/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation
import UIKit

protocol UICellReuseIdentifer {
    
}

extension UICellReuseIdentifer {
    static var identifier: String {
        get {
            return "\(Self.self)_identifier"
        }
    }
}

struct Person {
    
    var name: String
    var gender: String
    var age: Int
    init(name: String, gender: String, age: Int) {
        self.name = name
        self.gender = gender
        self.age = age
    }
}
