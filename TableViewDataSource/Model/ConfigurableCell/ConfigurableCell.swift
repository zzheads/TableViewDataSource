//
//  ConfigurableCell.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype ItemType
    func configure(_ item: ItemType, completion: ((ItemType) -> Void)?)
}
