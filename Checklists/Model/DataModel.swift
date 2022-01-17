//
//  DataModel.swift
//  Checklists
//
//  Created by Егор Кожемин on 12.01.2022.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    init(){
        loadCheckList()
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
}
