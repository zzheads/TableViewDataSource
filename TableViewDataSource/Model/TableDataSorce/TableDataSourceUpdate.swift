//
//  DataProviderUpdate.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

enum TableDataSourceUpdate<T> {
    case insert(IndexPath, T)
    case modify(IndexPath, T)
    case delete(IndexPath)
}
