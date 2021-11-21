//
//  CountDownApp.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 03/11/2021.
//

import SwiftUI

@main
struct CountDownApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(EventsViewModel())
        }
    }
}
