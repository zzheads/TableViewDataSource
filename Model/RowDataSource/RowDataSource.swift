//
//  RowBuilder.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

protocol RowBuilder {
    var cellIdentifier: String { get }
    var cellNib: UINib { get }
    var itemsCount: Int { get }
    var cellType: AnyClass { get }
    
    func configure(_ cell: UITableViewCell, at row: Int)
    
    func insert<T>(_ item: T, at row: Int)
    func delete(at row: Int)
    func modify<T>(_ item: T, at row: Int)
}

class RowDataSource<Type, Cell: UITableViewCell>: RowBuilder where Cell: ConfigurableCell, Cell.ItemType == Type {
    var items           : [Type]
    var completion      : ((Type) -> Void)?
    
    init(_ items: [Type] = [], completion: ((Type) -> Void)? = nil) {
        self.items = items
        self.completion = completion
    }
    
    var cellIdentifier: String {
        return "\(Cell.self)"
    }
    
    var cellNib: UINib {
        return UINib(nibName: self.cellIdentifier, bundle: nil)
    }
    
    var itemsCount: Int {
        return self.items.count
    }

    var cellType: AnyClass {
        return Cell.self
    }
    
    func configure(_ cell: UITableViewCell, at row: Int) {
        guard let cell = cell as? Cell else {
            return
        }
        cell.configure(self.items[row], completion: self.completion)
    }
}

// MARK: Updates

extension RowDataSource {
    func insert<T>(_ item: T, at row: Int) {
        guard let item = item as? Type else { return }
        self.items.insert(item, at: row)
    }

    func delete(at row: Int) {
        self.items.remove(at: row)
    }
    
    func modify<T>(_ item: T, at row: Int) {
        guard let item = item as? Type else { return }
        self.items[row] = item
    }
}
