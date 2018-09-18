//
//  ApplicationSettings.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

struct ArrayChoice: Codable {
    var array   : [String]
    var selected: Int
    
    var selection: String {
        return self.array[self.selected]
    }
}

class ApplicationSettings {
    static let language = Setting<ArrayChoice>(key: "Language", value: ArrayChoice(array: ["Russian", "English", "French"], selected: 0))
    static let baseUrl = Setting(key: "Server address", value: "https://182.67.72.13:8080")
    static let darkTheme = Setting(key: "Dark theme", value: true)
}
