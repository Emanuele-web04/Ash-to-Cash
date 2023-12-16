//
//  ChartsView.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 15/12/23.
//

import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {

    @Query var cigarettes: [CigaretteStore]
    
    @EnvironmentObject var userData: UserData
    
    @State private var today = Date()

    
    func dateDiff(from: Date, to: Date) -> DateComponents {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: from, to: to)
        return components
    }

    // Nell'uso della funzione:
    // Usa diffComponents per ottenere i giorni, i mesi o gli anni di differenza


    @State private var moneySaved = 0.0
    
    func calculateMoneySaved(money: Double) -> Double {
        let cigarettesPerDay = Double(userData.cigarettesPerDay)
        let cigarettesInPack = Double(userData.cigarettesInPack)
        let packPrice = userData.packPrice
        
        return Double(((cigarettesPerDay*365)/cigarettesInPack)*packPrice)
    }
    
    @State private var textDisplayed = ""
    
    func comparisonCigarette(text: String) -> String {
        let cigarettesPerDay = userData.cigarettesPerDay
        if cigarettes.count < cigarettesPerDay {
            return "Good, you are belowe your daily average!"
        } else if cigarettes.count == cigarettesPerDay {
            return "You reached your daily average! Don't smoke anymore!"
        } else {
            return "You went over your daily average, stop!"
        }
    }
    
    func currencies(currency: Int) -> String {
        if userData.selectedCurrencyIndex == 0 {
            return "$"
        } else if userData.selectedCurrencyIndex == 1 {
            return "€"
        } else if userData.selectedCurrencyIndex == 2 {
            return "£"
        } else {
            return "¥"
        }
    }
    
    @State private var currency = 0
    
    @State private var showInfoSheet = false
    
    func formatMonthsAndDays(from components: DateComponents) -> String {
        let months = components.month ?? 0
        let days = components.day ?? 0
        return "\(months) months and \(days) days"
    }
    
    var body: some View {

        let quitDate = userData.quitDate
        let diffComponents = dateDiff(from: today, to: quitDate)
        let monthsDaysString = formatMonthsAndDays(from: diffComponents)


            // Aggiorna 'today' per ottenere sempre la data corrent
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                 
                    Text(comparisonCigarette(text: textDisplayed)).font(.system(size: 18))
                        .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                        .padding()
                    VStack (alignment: .leading) {
                        Text("Time til your quitting day")
                        Spacer()
                        Text(monthsDaysString).bold()
                    }.foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                        .padding()
                    
                    Chart {
                        RuleMark(y: .value("Avarage", 3))
                            .foregroundStyle(.mint)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        ForEach(cigarettes.indices, id: \.self) { index in
                            LineMark(
                                x: .value("Cigarette Count", index + 1),
                                y: .value("Emotion", cigarettes[index].emotion.rawValue)
                            )
                            .symbol(by: .value("Emotion", cigarettes.indices))
                        }
                    }
                    .frame(height: 200)
                    .foregroundStyle(.indigo.gradient)
                    .chartYScale(domain: 1...5).padding()
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .font(.system(size: 20))
                            .foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                        Text("Money you will save in a year")
                        Spacer()
                        Text(currencies(currency: currency)+" "+String(format: "%.2f",calculateMoneySaved(money: moneySaved))).bold()
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                            .frame(height: 70)
                    )
                    .padding()
                    
                    HStack {
                        Text("Yours: ")
                        Text("\(cigarettes.count)")
                            .font(.system(size: 20))
                            .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                        Spacer()
                        Text("VS").font(.system(size: 20))
                            .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                        Spacer()
                        Text("Average: ")
                        Text(String(userData.cigarettesPerDay)).font(.system(size: 20))
                            .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                            .frame(height: 70)
                    )
                    .padding()
                    Spacer()
                }
            }
            .navigationTitle("Progress")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showInfoSheet = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(LinearGradient(colors: [.mint, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }

                }
            }
        }
        .sheet(isPresented: $showInfoSheet) {
            QuittingSmokingView()
        }
    }
   
}

#Preview {
    ChartsView()
}
