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
                    
                    let sTargetDay: String = targetDay > 9 ? String(targetDay) : "0" + String(targetDay)
                    let sTargetMonth: String = targetMonth > 9 ? String(targetMonth) : "0" + String(targetMonth)
                    let sTargetYear: String = String(targetYear).leftPadding(toLength: 4, withPad: "0")
                    
                    let date1 = calendar.startOfDay(for: currentDate)
                    let date2 = calendar.startOfDay(for: eventItems.date)
                    let leftComponents = calendar.dateComponents([.day], from: date1, to: date2)
                    
                    let dayLeft = leftComponents.day ?? -1
                    
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
                                    Text("\(sTargetDay).\(sTargetMonth).\(String(sTargetYear))")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .foregroundColor(Color(UIColor.secondaryLabel))
    //                                    .background(.blue)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(dayLeft)")
                                        .font(.largeTitle)
                                        .fontWeight(.medium)
                                        .foregroundColor(
                                            dayLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
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
                                            dayLeft >= 0 ? Color(UIColor.label) : Color(UIColor.tertiaryLabel)
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

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
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
