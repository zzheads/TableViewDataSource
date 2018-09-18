//
//  StringCell.swift
//  Aquatic Saver
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class StringCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var fieldValue: UITextField!
    var item        : Setting<String>?
    var completion  : ((Setting<String>) -> Void)?
    
    func configure(_ item: Setting<String>, completion: ((Setting<String>) -> Void)?) {
        self.item = item
        self.completion = completion
        self.labelKey.text = item.key
        self.fieldValue.text = item.value
        self.fieldValue.addTarget(self, action: #selector(self.textFieldPressed(_:)), for: .allEditingEvents)
    }
    
    @objc func textFieldPressed(_ sender: UITextField) {
        self.item?.value = sender.text
        guard let item = self.item, let completion = self.completion else { return }
        completion(item)
    }
}
