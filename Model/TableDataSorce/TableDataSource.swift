//
//  TableDataSource.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

typealias BuilderIndex = (builder: RowBuilder, row: Int)

class TableDataSource: NSObject {
    let tableView: UITableView
    var builders: [RowBuilder]
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        self.builders = []
        super.init()
        self.tableView.dataSource = self
    }
    
    var rowsCount: Int {
        return self.builders.compactMap{$0.itemsCount}.reduce(0, +)
    }
    
    func builderIndex(for indexPath: IndexPath) -> BuilderIndex? {
        var rows = 0
        for builder in self.builders {
            rows += builder.itemsCount
            if indexPath.row < rows {
                return BuilderIndex(builder: builder, row: rows - indexPath.row - 1)
            }
        }
        return nil
    }
    
    func register(_ builder: RowBuilder) {
        self.builders.append(builder)
        self.tableView.register(builder.cellNib, forCellReuseIdentifier: builder.cellIdentifier)
    }
    
    func register(_ builders: [RowBuilder]) {
        builders.forEach { self.register($0) }
    }
}

extension TableDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let builderIndex = self.builderIndex(for: indexPath)!
        let cell = tableView.dequeueReusableCell(withIdentifier: builderIndex.builder.cellIdentifier, for: indexPath)
        builderIndex.builder.configure(cell, at: builderIndex.row)
        return cell
    }
}

extension TableDataSource {
    func process<T>(_ updates: [TableDataSourceUpdate<T>], with animation: UITableView.RowAnimation = .automatic) {
        self.tableView.beginUpdates()
        
        for update in updates {
            switch update {
            case .delete(let indexPath) :
                guard let builderIndex = self.builderIndex(for: indexPath) else {
                    return
                }
                builderIndex.builder.delete(at: builderIndex.row)
                self.tableView.deleteRows(at: [indexPath], with: animation)
                
            case .insert(let indexPath, let item)   :
                guard let builderIndex = self.builderIndex(for: indexPath) else {
                    return
                }
                builderIndex.builder.insert(item, at: builderIndex.row)
                self.tableView.insertRows(at: [indexPath], with: animation)

            case .modify(let indexPath, let item)   :
                guard let builderIndex = self.builderIndex(for: indexPath) else {
                    return
                }
                builderIndex.builder.modify(item, at: builderIndex.row)
                self.tableView.reloadRows(at: [indexPath], with: animation)
            }
        }
        
        self.tableView.endUpdates()
    }
}

