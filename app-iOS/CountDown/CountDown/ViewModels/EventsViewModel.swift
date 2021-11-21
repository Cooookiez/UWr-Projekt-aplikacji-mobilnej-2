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
        loadEventItems()
    }
    
    func addEventItem(_ eventItemModel: EventsModel) {
        eventItems.append(eventItemModel)
    }
    
    func updateEventItem(_ event: EventsModel) {
        guard let index = eventItems.firstIndex(where: { $0.id == event.id }) else { return }
        eventItems[index] = event
    }
    
    func deleteEventItem(at indexSet: IndexSet) {
        
    }
    
    func loadEventItems() {
        eventItems = EventsModel.sampleData
    }
    
    func saveEventItems() {
        print("Saving events to file system eventually")
    }
}
