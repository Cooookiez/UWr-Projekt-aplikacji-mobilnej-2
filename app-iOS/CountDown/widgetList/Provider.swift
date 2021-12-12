//
//  Provider.swift
//  widgetListExtension
//
//  Created by Krzysztof Kukiz on 29/11/2021.
//

import WidgetKit
//import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ListEntry {
        ListEntry.mockListEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (ListEntry) -> ()) {
        let entry = ListEntry.mockListEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ListEntry>) -> ()) {
        var entries: [ListEntry] = []
        let listEventModel = ListEventModel()
//        @EnvironmentObject var eventsViewModel: EventsViewModel
        print("Provider")
        print("Ile: \(listEventModel.eventItems.count)")

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ListEntry(date: entryDate, events: listEventModel.eventItems)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
