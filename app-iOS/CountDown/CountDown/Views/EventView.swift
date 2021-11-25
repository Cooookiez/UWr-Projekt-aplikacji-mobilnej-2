//
//  EventView.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 05/11/2021.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @ObservedObject var eventViewModel: EventViewModel
    @Environment(\.presentationMode) var presenationMode
    @State var selectedDate = Date()
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("Name", text: $eventViewModel.eventItem.name)
                    DatePicker("Date:", selection: $eventViewModel.eventItem.date, displayedComponents: .date)
                }
            }
            .navigationTitle("Event")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: addUpdateButton)
        }
    }
}

extension EventView {
    func updateEvent() {
        let event = EventsModel(
            id: eventViewModel.eventItem.id,
            name: eventViewModel.eventItem.name,
            date: eventViewModel.eventItem.date
        )
        eventsViewModel.updateEventItem(event)
        presenationMode.wrappedValue.dismiss()
    }
    
    func addEvent() {
        let event = EventsModel(
            name: eventViewModel.eventItem.name,
            date: eventViewModel.eventItem.date
        )
        eventsViewModel.addEventItem(event)
        presenationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presenationMode.wrappedValue.dismiss()
        }
    }
    
    var addUpdateButton: some View {
        Button(
            eventViewModel.isNewItem ? "Add" : "Update",
            action: eventViewModel.isNewItem ? addEvent : updateEvent
        ).disabled(eventViewModel.isDisabled)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(eventViewModel: EventViewModel())
            .environmentObject(EventsViewModel())
    }
}
