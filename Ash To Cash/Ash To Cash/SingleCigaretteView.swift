//
//  SingleCigaretteView.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 06/12/23.
//

import SwiftUI

struct SingleCigaretteView: View {
    
    @Bindable var cigarette: CigaretteStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cigarette.cigaretteName)
                Text(String(format: "%.2f", cigarette.priceCigarette))
                    .font(.caption)
            }
            Spacer()
            Text(cigarette.emotion.emoji)
        }
    }
}


