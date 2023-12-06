//
//  ContentView.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 05/12/23.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @State private var showModalsheet = false
    @State private var counter: Int = 0
    
    @Query var cigarettes: [CigaretteStore]
    @Environment (\.modelContext) var context
//    @StateObject var viewModel = AverageEmotion()
//    lazy var averageEmotion: Emotion = viewModel.calculateAverageEmotion()
//    lazy var averageEmoji = averageEmotion.emoji
//  
    func calculateAverageEmotion() -> Emotion {
           let totalEmotionValue = cigarettes.reduce(0) { $0 + $1.emotion.rawValue }
           let averageValue = Float(totalEmotionValue) / Float(max(cigarettes.count, 1))
           let roundedAverage = Int(round(averageValue))

           print("Average emotion raw value: \(roundedAverage)") // Aggiungi questo per il debug

           return Emotion(rawValue: roundedAverage) ?? .neutral
       }
    
    var body: some View {
            let averageEmotion = calculateAverageEmotion()
            let averageEmoji = averageEmotion.emoji
            NavigationStack{
                VStack{
                    List{
                        Section{
                            ForEach(cigarettes) { cigarette in
                                SingleCigaretteView(cigarette: cigarette)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            withAnimation {
                                                context.delete(cigarette)
                                            }
                                        } label: {
                                            Image(systemName: "bin")
                                        }
                                        
                                    }
                            }
                            
                        } header: {
                            
                            HStack(alignment: .center) {
                                Text("\(cigarettes.count)")
                                    .font(.system(size: 96))
                                    .foregroundStyle(.black)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Average Mood")
                                    withAnimation {
                                        Text(averageEmoji)
                                            .font(.largeTitle)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Cigarette")
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button(action: {
                            showModalsheet = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .sheet(isPresented: $showModalsheet, content: {
                    AddCigarette()
                })
            }
        }
    }



#Preview {
    ContentView()
}
