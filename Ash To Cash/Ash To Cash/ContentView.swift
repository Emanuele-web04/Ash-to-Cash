import SwiftUI
import Charts
import SwiftData

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var context
    @Query var cigarettes: [CigaretteStore]

    @State private var showModalsheet = false

    func calculateAverageEmotion() -> Emotion {
        let totalEmotionValue = cigarettes.reduce(0) { $0 + $1.emotion.rawValue }
        let averageValue = Float(totalEmotionValue) / Float(max(cigarettes.count, 1))
        let roundedAverage = Int(round(averageValue))
        
        print("Average emotion raw value: \(roundedAverage)") // Add this for debugging
        
        return Emotion(rawValue: roundedAverage) ?? .neutral
    }
    
    @StateObject var timerHandling = TimerHandling()
    
    @State private var animationGradient = false

    var body: some View {
        
        let averageEmotion = calculateAverageEmotion()
        let averageEmoji = averageEmotion.emoji
        
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    Spacer()
                    VStack {
                        Text("Last time since you smoked").bold() 
                        ZStack {
                            RoundedRectangle(cornerRadius: 10 )
                                .foregroundStyle(LinearGradient(colors: [.mint, .indigo], startPoint: .leading, endPoint: .bottomTrailing))
                                .hueRotation(.degrees(animationGradient ? 45 : 0))
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                                        animationGradient.toggle()
                                    }
                                }
                                .frame(height: 80)
                            Text("\(timerHandling.timeString(time: timerHandling.timer))").font(.system(size: 40))
                                .foregroundStyle(LinearGradient(colors: [.white, .white.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .fontWeight(.light)
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Your cigarettes for the day") .foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                        Spacer()
                        Text("\(cigarettes.count)").font(.system(size: 32))
                            .foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(LinearGradient(colors: [.mint, .teal], startPoint: .leading, endPoint: .bottomTrailing))
                    )
                    .padding(2)
                    Spacer()
                    HStack {
                        Text("Your average mood") .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                        Spacer()
                        withAnimation {
                            Text(averageEmoji).font(.system(size: 32))
                        }
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .bottomTrailing))
                    )
                    .padding(1)
                    Spacer()
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("Cigarettes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                   
                        Button(action: {
                           showModalsheet = true
                        }, label: {
                          
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(LinearGradient(colors: [.mint, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .opacity(0.7)
                            
                        })
                    
                }
            }
            .sheet(isPresented: $showModalsheet) {
                
                    SmokingModal(timerHandling: timerHandling)
                        .presentationDetents([.fraction(0.6)])
            
            }
        }
        .accessibilityLabel("Cigarettes list")
        .onAppear {
            timerHandling.isRunning = true
            print(timerHandling.isRunning ? "works" : "not works")
        }
        .onReceive(timerHandling.timerCount) { _ in
            if timerHandling.isRunning {
                timerHandling.timer += 1
                print(timerHandling.timer)
            }
        }

    }
}



// Ensure CigaretteStore conforms to Identifiable, Codable, and has a date property for sorting



#Preview {
    ContentView()
}
