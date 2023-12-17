//
//  QuoteView.swift
//  Ash To Cash
//
//  Created by Francesca Pia Sasso on 14/12/23.
//

import SwiftUI
struct QuitView: View {
    
    @State private var selectedEmotion: Emotion = .neutral
    
    @Environment(\.presentationMode) private var presentationMode

    @Binding var isAdded: Bool
    let quotes : [String] = [
        "Quitting smoking is not a sacrifice; it's an investment in a brighter future.", // [1]
        "The smoke you inhale today may suffocate your dreams tomorrow. Break free and let your dreams breathe.", // [2]
        "Quitting smoking is a battle worth fighting, and every day you stay smoke-free is a victory.", // [3]
        "Your lungs were designed to inhale fresh air, not smoke. Honour your lungs by quitting smoking.", // [4]
        "Only I can change my life. No one can do it for me.", // [5]
        "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time." // [6]
    ]
    
    var randomQuote: String {
        return quotes.randomElement() ?? "You are stronger than your craving"
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    Text(randomQuote)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 320)
                        .bold()
                        .foregroundStyle(.white)
                    Text("How are you feeling right now?").foregroundStyle(.white).bold().padding()
                    
                    CustomPicker(selectedEmotion: $selectedEmotion)
                        .frame(height: 100)
                        .scaledToFit()
                        .padding()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10 )
                            .frame(height: 50)
                            .foregroundStyle(.white)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            isAdded = true
                        }, label: {
                            Text("Ok, I won't smoke")
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
            .animation(.easeInOut, value: 0.7)
        }
    }
}

