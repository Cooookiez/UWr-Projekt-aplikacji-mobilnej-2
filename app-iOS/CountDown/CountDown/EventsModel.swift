//
//  EventItemModel.swift.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import Foundation

struct EventsModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var date: Date = Date()
    
    static var sampleData: [EventsModel] {
        [
            EventsModel(name: "Etap 0"),
            EventsModel(name: "Etap 1"),
            EventsModel(name: "Etap 2"),
            EventsModel(name: "Etap 3"),
        ]
    }
}
