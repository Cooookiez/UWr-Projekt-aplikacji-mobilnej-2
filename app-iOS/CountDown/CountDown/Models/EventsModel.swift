//
//  EventItemModel.swift.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import Foundation

struct EventsModel: Identifiable, Codable {
    var name: String
    var date: Date
    var id: String
    
    init (name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.date = Date()
    }
    
    init (name: String, date: Date) {
        self.id = UUID().uuidString
        self.name = name
        self.date = date
    }
    
    init (id: String, name: String) {
        self.id = id
        self.name = name
        self.date = Date()
    }
    
    init (id: String, name: String, date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }
    
    func sorterForFileIDASC(this: EventsModel, that: EventsModel) -> Bool {
        return this.date < that.date
    }
    
    static var sampleData: [EventsModel] {
        [
            EventsModel(name: "Etap 0"),
            EventsModel(name: "Etap 1"),
            EventsModel(name: "Etap 2"),
            EventsModel(name: "Etap 3"),
        ]
    }
    
}
