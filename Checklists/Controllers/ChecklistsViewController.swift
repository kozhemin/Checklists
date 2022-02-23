//
//  ChecklistsViewController.swift
//  Checklists
//
//  Created by Егор Кожемин on 02.11.2021.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {
    var checklist: Checklist!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = checklist.name
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        checklist.items.count
    }

    // MARK: -

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath
        )

        let dataRow = checklist.items[indexPath.row]
        configureText(for: cell, with: dataRow)
        configureCheckmark(for: cell, with: dataRow)
        return cell
    }

    // MARK: select row

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let dataRow = checklist.items[indexPath.row]
            dataRow.checked.toggle()
            configureCheckmark(for: cell, with: dataRow)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        45.0
    }

    // MARK: delete rows

    override func tableView(_ tableView: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }

    func addItemViewControllerDidCancel(_: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }

    func addItemViewController(_: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .left)

        navigationController?.popViewController(animated: true)
    }

    func addItemViewController(_: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self

            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
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
        let label = cell.viewWithTag(1001) as! UILabel

        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }

    private func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}
