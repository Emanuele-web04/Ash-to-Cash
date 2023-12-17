//
//  UserData.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 15/12/23.
//
import Foundation

class UserData: ObservableObject {
    
    @Published var quitDate: Date {
        didSet {
            UserDefaults.standard.set(quitDate, forKey: "quitDate")
        }
    }
    
    @Published var selectedCurrencyIndex: Int {
        didSet {
            UserDefaults.standard.set(selectedCurrencyIndex, forKey: "selectedCurrencyIndex")
        }
    }

    @Published var cigarettesPerDay: Int {
        didSet {
            UserDefaults.standard.set(cigarettesPerDay, forKey: "cigarettesPerDay")
        }
    }

    @Published var cigarettesInPack: Int {
        didSet {
            UserDefaults.standard.set(cigarettesInPack, forKey: "cigarettesInPack")
        }
    }

    @Published var packPrice: Double {
        didSet {
            UserDefaults.standard.set(packPrice, forKey: "packPrice")
        }
    }

    init() {
        self.selectedCurrencyIndex = UserDefaults.standard.integer(forKey: "selectedCurrencyIndex") 
        self.cigarettesPerDay = UserDefaults.standard.integer(forKey: "cigarettesPerDay")
        self.cigarettesInPack = UserDefaults.standard.integer(forKey: "cigarettesInPack")
        self.packPrice = UserDefaults.standard.double(forKey: "packPrice")
        self.quitDate = UserDefaults.standard.object(forKey: "quitDate") as? Date ?? Date()
    }
}

