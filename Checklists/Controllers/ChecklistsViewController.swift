//
//  ChecklistsViewController.swift
//  Checklists
//
//  Created by Егор Кожемин on 02.11.2021.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.fillItems()
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
    
    // MARK: delete rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .left)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemTableViewController
            controller.delegate = self
        }
    }
    
    private func fillItems() {
        for item in 1...5 {
            items.append(ChecklistItem(text: "\(item) item", checked: false))
        }
    }
    
//    @IBAction func addItem() {
//        let newIndexRow = items.count
//        items.append(ChecklistItem(text: "NEW item", checked: false))
//
//        let indexPath = IndexPath(row: newIndexRow, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .left)
//    }
    
    
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

