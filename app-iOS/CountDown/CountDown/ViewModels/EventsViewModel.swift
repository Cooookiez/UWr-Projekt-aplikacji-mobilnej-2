//
//  EventItemViewModel.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var eventItems: [EventsModel] = []
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName) {
            loadEventItems()
        }
    }
    
    func addEventItem(_ eventItemModel: EventsModel) {
        eventItems.append(eventItemModel)
        saveEventItems()
    }
    
    func updateEventItem(_ event: EventsModel) {
        guard let index = eventItems.firstIndex(where: { $0.id == event.id }) else { return }
        eventItems[index] = event
        saveEventItems()
    }
    
    func deleteEventItem(at indexSet: IndexSet) {
        eventItems.remove(atOffsets: indexSet)
        saveEventItems()
    }
    
    func loadEventItems() {
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
    }
    
    func saveEventItems() {
        print("Saving events to file system eventually")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(eventItems)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
