//
//  EventViewModel.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 10/11/2021.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var eventItem: EventsModel
    var isNewItem: Bool
    
    var isDisabled: Bool {
        eventItem.name.isEmpty
    }
    
    init() {
        self.eventItem = EventsModel(name: "")
        isNewItem = true
    }
    
    init(_ currentEvent: EventsModel) {
        self.eventItem = currentEvent
        isNewItem = false
    }
}
