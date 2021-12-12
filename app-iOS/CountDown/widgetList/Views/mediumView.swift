//
//  mediumView.swift
//  widgetListExtension
//
//  Created by Krzysztof Kukiz on 29/11/2021.
//

import SwiftUI

struct mediumView: View {
    private var events: [EventsModel]
    init(events: [EventsModel]) {
        self.events = events
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct mediumView_Previews: PreviewProvider {
    static var previews: some View {
        mediumView(events: [EventsModel(name: "Test")])
    }
}
