//
//  OnBoarding.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 12/12/23.
//

import SwiftUI
import UIKit

struct OnBoarding: View {
    @AppStorage ("isOnboarding") var isOnboarding : Bool?
    
    @StateObject var userData = UserData()
    
    @FocusState var isTextFieldFocused: FocusField?
    enum FocusField {
        case cig, pack, currency
    }
    
    let currencies = ["$", "€", "£", "¥"]
    var selectedCurrencySymbol: String {
        return currencies[userData.selectedCurrencyIndex]
    }
    
    @State private var currentQuestion = 1
    @State private var isAnswerProvided = false
    @State private var currentProgress : Double = 0.25
    
    var formattedQuitDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: userData.quitDate)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ProgressView(value: currentProgress, total: 1.0)
                .accentColor(.indigo)
            
            switch currentQuestion {
                
            case 1:
                VStack(alignment:.center){
                    Spacer()
                    
                    
                    Text("What is your quit date?")
                        .font(.system(size: 25))
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    //                            .padding()
                        .accessibilityLabel("What is your quit date?")
                    Text("If you haven't quit yet, let's choose a day")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.mint)
                        .accessibilityHidden(true)
                    Spacer()
                    DatePicker("Select Date", selection: $userData.quitDate,
                               in: ...Date(timeIntervalSince1970: TimeInterval(2050 * 365 * 24 * 60 * 60)),
                               displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    Spacer()
                        .onChange(of: userData.quitDate) { _ in
                            isAnswerProvided = true
                        }
                        .colorMultiply(Color.mint)
                }
                .padding()
            case 2:
                //è necessaria una vstack? si
                VStack{
                    Spacer()
                    Spacer()
                    Text("How many cigarettes did you smoke per day?🚬")
                        .font(.system(size: 25))
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                    Image(systemName: "wind.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.mint)
                        .accessibilityHidden(true)
                    Spacer()
                    
                    TextField("0", value: $userData.cigarettesPerDay, formatter: NumberFormatter()).focused($isTextFieldFocused, equals: .cig)
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Spacer()
                            }
                            ToolbarItem(placement: .keyboard) {
                                Button(action: {
                                    isTextFieldFocused = nil
                                }) {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                    
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.mint)
                                        .fontWeight(.regular)
                                }
                            }
                        }
                        .padding()
                        .onChange(of: userData.cigarettesPerDay) { _ in
                            isAnswerProvided = true
                        }
                        .bold()
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Spacer()
                }
                
                
            case 3:
                
                VStack {
                    Spacer()
                    Spacer()
                    Text("How many cigarettes were in the pack?")
                        .bold()
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .bold()
                    Spacer()
                    Image(systemName: "12.lane").resizable()
                        .frame(width: 40, height: 35)
                        .foregroundStyle(.mint)
                        .accessibilityHidden(true)
                    Spacer()
                    
                    TextField("0", value: $userData.cigarettesInPack, formatter: NumberFormatter())
                        .keyboardType(.numberPad).focused($isTextFieldFocused, equals: .pack)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Spacer()
                            }
                            ToolbarItem(placement: .keyboard) {
                                Button(action: {
                                    isTextFieldFocused = nil
                                }) {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.mint)
                                        .fontWeight(.regular)
                                }
                            }
                        }
                        .padding()
                        .onChange(of: userData.cigarettesInPack) { _ in
                            isAnswerProvided = true
                        }
                        .bold()
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Spacer()
                }
                
            case 4:
                VStack {
                    Spacer()
                    Spacer()
                    Text("What's the price of the pack?")
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .bold()
                    Spacer()
                    Image(systemName: "dollarsign.circle").resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.mint)
                        .accessibilityHidden(true)
                    Spacer()
                    VStack() {
                        HStack(spacing: 20){
                            Text(selectedCurrencySymbol)
                                .bold()
                                .font(.system(size: 50))
                            Spacer()
                            Spacer()
                            TextField("0", value: $userData.packPrice, formatter: NumberFormatter()).focused($isTextFieldFocused, equals: .pack)
                                .keyboardType(.decimalPad)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Spacer()
                                    }
                                    ToolbarItem(placement: .keyboard) {
                                        Button(action: {
                                            isTextFieldFocused = nil
                                        }) {
                                            Image(systemName: "keyboard.chevron.compact.down")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundStyle(.mint)
                                                .fontWeight(.regular)
                                        }
                                    }
                                }
                                .onChange(of: userData.packPrice) { _ in
                                    isAnswerProvided = true
                                }
                                .bold()
                                .font(.system(size: 50))
                                .accessibilityLabel("Price of the pack")
                                .padding(.trailing, 10)
                            Spacer()
                            Picker("Change currency", selection: $userData.selectedCurrencyIndex) {
                                ForEach(0..<currencies.count) {
                                    Text(self.currencies[$0])
                                }
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.mint)
                        .bold()
                        .accessibilityLabel("select currency")
                        .font(.system(size: 20))
                        
                    }
                    .multilineTextAlignment(.center)
                    Spacer()
                    Spacer()
                }
                
            default:
                EmptyView()
            }
            
            Button(action: {
                if isAnswerProvided {
                    if currentQuestion < 4 {
                        currentQuestion += 1
                        currentProgress += 0.25
                        resetAnswerStatus()
                    } else if currentQuestion == 4 {
                        print("Quit Date: \(userData.quitDate)")
                        print("Cigarettes per Day: \(userData.cigarettesPerDay)")
                        print("Cigarettes in Pack: \(userData.cigarettesInPack)")
                        print("Pack Price: \(userData.packPrice)")
                        resetAnswerStatus()
                        withAnimation {
                            isOnboarding = false
                            isTextFieldFocused = nil
                        }
                    }
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10 )
                        .frame(height: 50)
                        .foregroundStyle(isAnswerProvided ? Color.indigo : Color.gray)
                    NavigationLink(destination:  ContentView(), label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                }
            }
            .disabled(!isAnswerProvided)
        }
        .padding()
    }
    
    func resetAnswerStatus() {
        isAnswerProvided = false
    }
}




