//
//  DataModel.swift
//  Checklists
//
//  Created by Егор Кожемин on 12.01.2022.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(
                forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(
                newValue,
                forKey: "ChecklistIndex")
        }
    }
    
    init(){
        loadCheckList()
        registerDefaults()
        handleFirstTime()
    }
    
    class func nextChecklistItemID() -> Int {
        let key = "ChecklistItemID"
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: key)
        userDefaults.set(itemID + 1, forKey: key)
        return itemID
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists-v1.plist")
    }
    
    func saveCheckList(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoder \(error.localizedDescription)")
        }
    }
    
    func loadCheckList() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding \(error.localizedDescription)")
            }
        }
    }
    
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1, "FirstTime": true ] as [String: Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
}
