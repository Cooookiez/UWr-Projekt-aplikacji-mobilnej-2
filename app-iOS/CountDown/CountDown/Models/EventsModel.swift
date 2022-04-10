//
//  EventItemModel.swift.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import Foundation

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

struct EventsModel: Identifiable, Codable {
    var name: String
    var date: Date
    var dateString: String = "00.00.0000"
    var dateDaysLeft: Int = 0
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
    
    mutating func updateDays2Date() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let targetComponents = calendar.dateComponents([.day, .month, .year], from: self.date)
        let targetDay: Int = targetComponents.day ?? 0
        let targetMonth: Int = targetComponents.month ?? 0
        let targetYear: Int = targetComponents.year ?? 0
        
        let sTargetDay: String = targetDay > 9 ? String(targetDay) : "0" + String(targetDay)
        let sTargetMonth: String = targetMonth > 9 ? String(targetMonth) : "0" + String(targetMonth)
        let sTargetYear: String = String(targetYear).leftPadding(toLength: 4, withPad: "0")
        
        let date1 = calendar.startOfDay(for: currentDate)
        let date2 = calendar.startOfDay(for: self.date)
        let leftComponents = calendar.dateComponents([.day], from: date1, to: date2)
        
        self.dateString = "\(sTargetDay).\(sTargetMonth).\(sTargetYear)"
//        self.dateDaysLeft = self.dateDaysLeft + 1
        self.dateDaysLeft = leftComponents.day ?? -1
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
            EventsModel(name: "Testy 7"),
            EventsModel(name: "Testy 8"),
            EventsModel(name: "Testy 9"),
            EventsModel(name: "Testy 10"),
            EventsModel(name: "Testy 11"),
            EventsModel(name: "Testy 12"),
            EventsModel(name: "Testy 13"),
            EventsModel(name: "Testy 14"),
            EventsModel(name: "Testy 15"),
            EventsModel(name: "Testy 16"),
            EventsModel(name: "Testy 17"),
            EventsModel(name: "Testy 18"),
            EventsModel(name: "Testy 19"),
            EventsModel(name: "Testy 20"),
            EventsModel(name: "Testy 21")
        ]
    }
    
}
