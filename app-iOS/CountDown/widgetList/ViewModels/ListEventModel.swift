//
//  ListEventModel.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 05/12/2021.
//

import Foundation

class ListEventModel: ObservableObject {
    var eventItems: [EventsModel] = []
    
    init() {
        print("initStart")
        print(FileManager.docDirURL.path)
        print(FileManager().docExist(named: fileName))
        if FileManager().docExist(named: fileName) {
            loadEventItems()
        }
        print("initEnd")
    }
    
    func loadEventItems() {
        print("loadStart")
//        eventItems = EventsModel.sampleData
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    eventItems = try decoder.decode([EventsModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        sortList()
        print("loadEND")
    }
    
    func sortList() {
        // images.sorted(by: { $0.fileID > $1.fileID })
        print("sortStart")
        self.eventItems =  self.eventItems.sorted(by: { $0.date < $1.date })
        print("sortEnd")
    }
}
