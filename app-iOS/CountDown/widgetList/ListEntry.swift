//
//  ListEntry.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 29/11/2021.
//

import WidgetKit

struct ListEntry: TimelineEntry {
    let date: Date
    let events: [EventsModel]
    
    static func mockListEntry() -> ListEntry {
        return ListEntry(
            date: Date(),
            events: EventsModel.sampleData
        )
    }
}
