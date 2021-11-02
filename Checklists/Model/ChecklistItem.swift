//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Егор Кожемин on 03.11.2021.
//

class ChecklistItem {
    var text = ""
    var checked = false
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
}
