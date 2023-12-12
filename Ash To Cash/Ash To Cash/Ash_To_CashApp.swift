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
    @AppStorage ("isOnboarding") var isOnboarding = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnBoarding()
                    .onDisappear {
                        isOnboarding = false
                    }
            } else {
                ContentView()
            }
        }
        .modelContainer(for: CigaretteStore.self)
    }
}
