//
//  ChecklistsViewController.swift
//  Checklists
//
//  Created by Егор Кожемин on 02.11.2021.
//

import UIKit

class ChecklistsViewController: UITableViewController {
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillItems()
    }
    
    private func fillItems() {

        for item in 1...50 {
            items.append(ChecklistItem(text: "\(item) item", checked: false))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    // MARK: -
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        
        
        let dataRow = items[indexPath.row]
        configureText(for: cell, with: dataRow)
        configureCheckmark(for: cell, with: dataRow)
        return cell
    }
    
    // MARK: select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let cell = tableView.cellForRow(at: indexPath) {
            let dataRow = items[indexPath.row]
            dataRow.checked.toggle()
            configureCheckmark(for: cell, with: dataRow)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    private func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

