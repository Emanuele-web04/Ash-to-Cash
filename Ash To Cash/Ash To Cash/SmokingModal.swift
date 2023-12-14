//
//  SmokingModal.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 14/12/23.
//

import SwiftUI

struct SmokingModal: View {
    
    @State private var showCigarette = false
    var body: some View {
        VStack {
            List {
                Section {
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
                    .padding()
                }
                .frame(height: 150)
                .listRowBackground( LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing)
                )
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
                .frame(height: 150)
                .listRowBackground( LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing)
                )
            }
            .sheet(isPresented: $showCigarette, content: {
                AddCigarette()
                    .presentationDetents([.fraction(1.0)])
            })
        }
    }
}

#Preview {
    SmokingModal()
}