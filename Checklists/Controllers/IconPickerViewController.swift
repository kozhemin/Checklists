//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Егор Кожемин on 18.02.2022.
//

import UIKit

protocol IconPickerViewControllerDelegate: AnyObject {
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

let icons: [String] = [
    "folder", "doc", "calendar", "bookmark", "graduationcap", "paperclip", "briefcase",
]

class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        icons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)

        let iconName = icons[indexPath.row]
        cell.textLabel?.text = iconName
        cell.imageView?.image = UIImage(systemName: iconName)
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
