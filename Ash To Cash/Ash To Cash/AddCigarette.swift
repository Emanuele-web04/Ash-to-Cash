//
//  AddCigarette.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 06/12/23.
//

import SwiftUI
import SwiftData

struct AddCigarette: View {
    
    @State private var selectedEmotion: Emotion = .neutral  // Default emotion
    
    @State var cigarette = CigaretteStore()
    @Environment (\.modelContext) var context
    @Environment (\.dismiss) var dismiss
   

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Ouch! Next time fight more!")
                        .multilineTextAlignment(.center).bold().font(.system(size: 30)).foregroundStyle(.white).padding()
                    Text("You got this!").foregroundStyle(.white).opacity(0.6).bold()
                    Spacer()
                    VStack(spacing: 20) {
                        Text("How are you feeling right now?").foregroundStyle(.white).bold().padding()
                        
                        CustomPicker(selectedEmotion: $selectedEmotion)
                        .frame(height: 100)
                        .scaledToFit()
                        .padding()
                    }
                    Spacer()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10 )
                            .frame(height: 50)
                            .foregroundStyle(.white)
                        Button(action: {
                            withAnimation {
                                addCigarette()
                                context.insert(cigarette)
                                
                            }
                            dismiss()
                        }, label: {
                            Text("Add")
                                .bold()
                                .foregroundStyle(.black)
                                .font(.system(size: 18))
                        })
                    }
                    
                    .padding()
                    
                }
            }
        }
    }
    private func addCigarette() {
            // Convert the selected emotion to the format needed for CigaretteStore
        cigarette.emotion = selectedEmotion
            // Further code to handle the new cigarette data
        }
}

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

struct CustomPicker: View {
    let emotions: [Emotion] = Emotion.allCases
    @Binding var selectedEmotion: Emotion
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ForEach(emotions, id: \.self) { emotion in
                    Text(emotion.emoji)
                        .font(.system(size: 30))
                        .padding(5)
                        .background(self.selectedEmotion == emotion ? Color.gray : Color.clear)
                        .cornerRadius(30)
                        .onTapGesture {
                            self.selectedEmotion = emotion
                            print(selectedEmotion)
                        }
                }
                Spacer()
            }
            Text(selectedEmotion.rawValue == 1 ? "Angry" : (selectedEmotion.rawValue == 2) ? "Sad" : (selectedEmotion.rawValue == 4) ? "Happy" : (selectedEmotion.rawValue == 5) ? "Excited" : "Normal")
                .foregroundStyle(.white).opacity(0.8)
            
        }
        .animation(.easeInOut(duration: 0.7))
    }
}

