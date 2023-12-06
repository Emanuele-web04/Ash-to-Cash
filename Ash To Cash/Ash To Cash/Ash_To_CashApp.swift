//
//  Ash_To_CashApp.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 05/12/23.
//

import SwiftUI
import SwiftData

@main
struct Ash_To_CashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CigaretteStore.self)
    }
}
