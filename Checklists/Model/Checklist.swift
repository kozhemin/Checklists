//
//  Checklist.swift
//  Checklists
//
//  Created by Егор Кожемин on 27.11.2021.
//

import UIKit

class Checklist: NSObject, Codable {
    var name: String
    var iconName: String
    var items = [ChecklistItem]()

    init(name: String, iconName: String = "folder") {
        self.name = name
        self.iconName = iconName
        super.init()
    }

    func countUncheckedItems() -> Int {
        items.reduce(0) { cnt, item in
            cnt + (item.checked ? 0 : 1)
        }
    }
}
