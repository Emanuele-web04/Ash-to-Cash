//
//  TabView.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 15/12/23.
//

//
//  mainView.swift
//  Ash To Cash
//
//  Created by Francesca Pia Sasso on 13/12/23.
//


import SwiftUI

struct TabViews: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack(spacing:0) {
                        Button(action: {}) {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .accessibilityHidden(true)
                        }
                        Text("Today")
                            .font(.caption)
                    }
                }
            ChartsView()
                .environmentObject(UserData())
                .tabItem {
                    VStack(spacing:0) {
                        Button(action: {}) {
                            Image(systemName: "chart.xyaxis.line")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .accessibilityHidden(true)
                        }
                        Text("Progress")
                            .font(.caption)
                    }
                }
        }
        
        .tint(.indigo)
        
    }
}


//#Preview {
//    ciaoview()
//}
