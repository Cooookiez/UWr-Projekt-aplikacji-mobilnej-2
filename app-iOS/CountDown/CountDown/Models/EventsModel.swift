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
        // make date
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
            EventsModel(name: "Testy 1"),
            EventsModel(name: "Testy 2"),
            EventsModel(name: "Testy 3"),
            EventsModel(name: "Testy 4"),
            EventsModel(name: "Testy 5"),
            EventsModel(name: "Testy 6"),
//            EventsModel(name: "Testy 7"),
//            EventsModel(name: "Testy 8"),
//            EventsModel(name: "Testy 9"),
//            EventsModel(name: "Testy 10"),
//            EventsModel(name: "Testy 11"),
//            EventsModel(name: "Testy 12"),
//            EventsModel(name: "Testy 13"),
//            EventsModel(name: "Testy 14"),
//            EventsModel(name: "Testy 15"),
//            EventsModel(name: "Testy 16"),
        ]
    }
    
}
