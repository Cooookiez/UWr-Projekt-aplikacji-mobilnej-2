//
//  EventItemViewModel.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import Foundation
import SwiftUI
import WidgetKit

class EventsViewModel: ObservableObject {
    @Published var eventItems: [EventsModel] = []
    
    init() {
        print("docDirURL.path: \(FileManager.docDirURL.path)")
        print("docExist: \(FileManager().docExist(named: fileName))")
        if FileManager().docExist(named: fileName) {
            loadEventItems()
        }
    }
    
    func addEventItem(_ eventItemModel: EventsModel) {
        var newEvent = eventItemModel
        newEvent.date = makeHoureAndMinuteEtcTo0(date: newEvent.date)
        eventItems.append(newEvent)
        sortList()
        saveEventItems()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func updateEventItem(_ event: EventsModel) {
        guard let index = eventItems.firstIndex(where: { $0.id == event.id }) else { return }
        var newEvent = event
        newEvent.date = makeHoureAndMinuteEtcTo0(date: newEvent.date)
        eventItems[index] = newEvent
        sortList()
        saveEventItems()
        WidgetCenter.shared.reloadAllTimelines()
    }
    // make hopur and minute 0
    func makeHoureAndMinuteEtcTo0(date: Date) -> Date {
        let calendar = Calendar.current
        let targetComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let dateComponents = DateComponents(
            calendar: calendar,
            year: targetComponents.year,
            month: targetComponents.month,
            day: targetComponents.day,
            hour: 0,
            minute: 0,
            second: 0,
            nanosecond: 0
        )
        let newDade: Date = calendar.date(from: dateComponents) ?? date
        return newDade
    }
    
    func deleteEventItem(at indexSet: IndexSet) {
        eventItems.remove(atOffsets: indexSet)
        sortList()
        saveEventItems()
        WidgetCenter.shared.reloadAllTimelines()
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
//        ForEach (self.eventItems) { item in
        print("df")
//        }
        sortList()
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
    
    func sortList() {
        // images.sorted(by: { $0.fileID > $1.fileID })
        self.eventItems =  self.eventItems.sorted(by: { $0.date < $1.date })
    }
}
