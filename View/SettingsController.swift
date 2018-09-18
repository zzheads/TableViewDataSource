//
//  ViewController.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    lazy var dataSource: TableDataSource = {
        let dataSource = TableDataSource(self.tableView)
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row1 = RowDataSource<Setting<String>, StringCell>([ApplicationSettings.baseUrl]) { self.label1.text = $0.value }
        let row2 = RowDataSource<Setting<ArrayChoice>, SegmentCell>([ApplicationSettings.language]) { self.label2.text = $0.value?.selection }
        let row3 = RowDataSource<Setting<Bool>, BoolCell>([ApplicationSettings.darkTheme]) { self.label3.text = "\($0.value ?? false)" }
        
        self.dataSource.register([row1, row2, row3] as [RowBuilder])
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.label1.text = ApplicationSettings.baseUrl.value
        self.label2.text = ApplicationSettings.language.value?.selection
        self.label3.text = ApplicationSettings.darkTheme.value?.description
    }
}

