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
    private let paddingSize: CGFloat = 10
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Start typing . . .", text: $eventViewModel.eventItem.name)
                        .padding(.top, paddingSize/2)
                        .padding(.bottom, paddingSize/2)
                }
                Section(header: Text("Date")) {
                    VStack(alignment: .leading) {
                        DatePicker(
                            selection: $eventViewModel.eventItem.date,
                            displayedComponents: .date,
                            label: { Text("") }
                        )
                            .padding(.top, paddingSize/2)
                            .padding(.bottom, paddingSize/2)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                    }
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
