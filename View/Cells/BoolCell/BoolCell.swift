//
//  BoolCell.swift
//  DataProvider
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class BoolCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var switchValue: UISwitch!
    
    var item        : Setting<Bool>?
    var completion  : ((Setting<Bool>) -> Void)?
    
    func configure(_ item: Setting<Bool>, completion: ((Setting<Bool>) -> Void)?) {
        self.item = item
        self.completion = completion
        self.labelKey.text = item.key
        self.switchValue.isOn = item.value ?? false
        self.switchValue.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        self.item?.value = sender.isOn
        guard let item = self.item, let completion = self.completion else { return }
        completion(item)
    }
}
