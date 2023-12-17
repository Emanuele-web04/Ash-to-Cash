//
//  SmokingModal.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 14/12/23.
//

import SwiftUI

struct SmokingModal: View {
    
    @State private var showCigarette = false
    @State private var showQuitView = false
    @State var isAdded: Bool = false
    @ObservedObject var timerHandling: TimerHandling
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                Section {
                    Button (action: {
                        showQuitView = true
                    }, label: {
                        HStack(spacing: 30) {
                            Image(systemName: "shield.lefthalf.filled")
                                .resizable()
                                .frame(width: 50, height: 55)
                                .foregroundStyle(LinearGradient(colors: [.white, .white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("I'm about to smoke")
                                .font(.system(size: 20))
                                .foregroundStyle(.white).opacity(0.8)
                                .bold()
                        }
                    })
                    .padding()
                }
                .frame(height: 120)
                .listRowBackground(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                Section {
                    Button(action: {
                        showCigarette = true
                    }, label: {
                        HStack(spacing: 30) {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(LinearGradient(colors: [.white, .white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("I already smoked...")
                                .font(.system(size: 20))
                                .foregroundStyle(.white).opacity(0.8)
                                .bold()
                        }
                        .padding()
                    })
                }
                .frame(height: 120)
                .listRowBackground( LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing)
                )
            }
            .sheet(isPresented: $showCigarette, content: {
                    AddCigaretteView(isAdded: $isAdded, showCigarette: $showCigarette, timerHandling: timerHandling)
                    .presentationDetents([.large])
                })
            .onChange(of: showCigarette) { newValue in
                if !newValue {
                    dismiss()
                }
            }
            .sheet(isPresented: $showQuitView, content: {
                    QuitView(isAdded: $isAdded)
                    .presentationDetents([.large])
                })
            .onChange(of: showQuitView) { newValue in
                if !newValue {
                    dismiss()
                }
            }
        }
    }
    private func close() {
        if !showCigarette {
            dismiss()
        }
    }
}

