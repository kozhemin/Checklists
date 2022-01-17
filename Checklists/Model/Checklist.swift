//
//  Checklist.swift
//  Checklists
//
//  Created by Егор Кожемин on 27.11.2021.
//

import UIKit

class Checklist: NSObject, Codable {
    var name: String
    var items = [ChecklistItem]()
    
    init(name: String) {
       self.name = name
       super.init()
   }
}
