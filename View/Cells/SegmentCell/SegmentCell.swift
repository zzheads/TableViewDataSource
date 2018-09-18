//
//  SegmentCell.swift
//  Aquatic Saver
//
//  Created by Алексей Папин on 18.09.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class SegmentCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var segmentValue: UISegmentedControl!
    
    var item        : Setting<ArrayChoice>?
    var completion  : ((Setting<ArrayChoice>) -> Void)?
    
    func configure(_ item: Setting<ArrayChoice>, completion: ((Setting<ArrayChoice>) -> Void)?) {
        self.item = item
        self.completion = completion
        self.labelKey.text = item.key
        self.segmentValue.removeAllSegments()
        guard let array = item.value?.array, let selected = item.value?.selected else { return }
        for i in 0..<array.count {
            self.segmentValue.insertSegment(withTitle: array[i], at: i, animated: true)
        }
        self.segmentValue.selectedSegmentIndex = selected
        self.segmentValue.addTarget(self, action: #selector(self.segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        self.item?.value?.selected = sender.selectedSegmentIndex
        guard let item = self.item, let completion = self.completion else { return }
        completion(item)
    }
}
