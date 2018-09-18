//
//  Settings.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

class Setting<T> {
    let id      : UUID
    let key     : String
    var value   : T?
    
    init(key: String, value: T?) {
        self.id = UUID()
        self.key = key
        self.value = value
    }
}


