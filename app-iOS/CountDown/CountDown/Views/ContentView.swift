//
//  ContentView.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import SwiftUI

let dateFormatter = DateFormatter()

struct ContentView: View {
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @State private var modalType: ModalType? = nil
    var body: some View {
        NavigationView {
            List() {
                let calendar = Calendar.current
                let currentDate = Date()
                
                ForEach(eventsViewModel.eventItems) { eventItems in
                    
                    let targetComponents = calendar.dateComponents([.day, .month, .year], from: eventItems.date)
                    let targetDay: Int = targetComponents.day ?? 0
                    let targetMonth: Int = targetComponents.month ?? 0
                    let targetYear: Int = targetComponents.year ?? 0
                    
                    let date1 = calendar.startOfDay(for: currentDate)
                    let date2 = calendar.startOfDay(for: eventItems.date)
                    let leftComponents = calendar.dateComponents([.day], from: date1, to: date2)
                    
                    let dayLeft = leftComponents.day ?? -1
                    
                    Button {
                        modalType = .update(eventItems)
                    } label: {
                        HStack {
                            VStack {
                                Text(eventItems.name)
                                    .font(.title2)
                                    .foregroundColor(Color(UIColor.label))
                                    .lineLimit(1)
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Text("\(targetDay) / \(targetMonth) / \(String(targetYear))")
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .foregroundColor(Color(UIColor.secondaryLabel))
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                            }
                            Text("\(dayLeft) days")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor.label))
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete(perform: eventsViewModel.deleteEventItem)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("My Events")
                        .font(.title2)
                        .foregroundColor(Color("Text"))
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        modalType = .add
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(item: $modalType) { $0 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventsViewModel())
    }
}
