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
                
                ForEach(eventsViewModel.eventItems) { eventItems in
                    
                    Button {
                        modalType = .update(eventItems)
                    } label: {
                        VStack {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text(eventItems.name)
                                        .font(.title2)
                                        .foregroundColor(Color(UIColor.label))
                                        .lineLimit(1)
    //                                    .background(.red)
                                    Text(eventItems.dateString)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .foregroundColor(Color(UIColor.secondaryLabel))
    //                                    .background(.blue)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(eventItems.dateDaysLeft)")
                                        .font(.largeTitle)
                                        .fontWeight(.medium)
                                        .foregroundColor(
                                            eventItems.dateDaysLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
                                        )
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(1)
                                        .fixedSize(
                                            horizontal: true,
                                            vertical: false
                                        )
    //                                    .background(.green)
                                    Text("Days")
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(1)
                                        .foregroundColor(
                                            eventItems.dateDaysLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
                                        )
    //                                    .background(.pink)
                                }
                            }
                            .padding()
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity
                            )
//                            Text("\(eventItems.date)")
                        }
                    }
                    .padding(.vertical, 10.0)
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
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(EventsViewModel())
    }
}
