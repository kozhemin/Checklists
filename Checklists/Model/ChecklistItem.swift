//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Егор Кожемин on 03.11.2021.
//
import Foundation

class ChecklistItem: NSObject, Codable  {
    var text = ""
    var checked = false
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
}
