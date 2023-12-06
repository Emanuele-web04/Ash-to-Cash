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
            List {
                Section {
                    TextField("Cigarette Name", text: $cigarette.cigaretteName)
                }
                Section {
                    TextField("Money Spent", value: $cigarette.priceCigarette, formatter: NumberFormatter.currency)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section {
                    Picker("Emotion", selection: $selectedEmotion) {
                        ForEach(Emotion.allCases, id: \.self) { emotion in
                            Text(emotion.emoji).tag(emotion)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            Button(action: {
                withAnimation {
                    addCigarette()
                    context.insert(cigarette)
                }
                dismiss()
            }, label: {
                Text("Button")
            })
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
