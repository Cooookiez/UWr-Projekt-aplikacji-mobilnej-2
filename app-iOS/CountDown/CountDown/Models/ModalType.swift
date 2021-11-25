//
//  ModalType.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 11/11/2021.
//

import SwiftUI

enum ModalType: Identifiable, View {
    case add
    case update(EventsModel)
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .add:
            return EventView(eventViewModel: EventViewModel())
        case .update(let event):
            return EventView(eventViewModel: EventViewModel(event))
        }
    }
}
