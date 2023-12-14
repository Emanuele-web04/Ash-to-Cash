import SwiftUI
import Charts
import SwiftData

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var context
    @Query var cigarettes: [CigaretteStore]

    @State private var showModalsheet = false

    private func calculateAverageEmotion() -> String {
        let totalEmotionValue = cigarettes.reduce(0) { $0 + $1.emotion.rawValue }
        let averageValue = Float(totalEmotionValue) / Float(max(cigarettes.count, 1))
        let roundedAverage = Int(round(averageValue))
        return Emotion(rawValue: roundedAverage)?.emoji ?? Emotion.neutral.emoji
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(cigarettes.indices, id: \.self) { index in
                        let cigarette = cigarettes[index]
                        HStack {
                            Text(cigarette.cigaretteName)
                            Spacer()
                            Text(cigarette.emotion.emoji)
                        }
                    }
                }

                Chart {
                    RuleMark(y: .value("Avarage", 3))
                        .foregroundStyle(.indigo)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    ForEach(cigarettes.indices, id: \.self) { index in
                        LineMark(
                            x: .value("Cigarette Count", index + 1),
                            y: .value("Emotion", cigarettes[index].emotion.rawValue)
                        )
                        .symbol(by: .value("Emotion", cigarettes.indices))
                    }
                }
                .frame(height: 200)
                .foregroundStyle(.mint.gradient)
                .chartYScale(domain: 1...5)
            }
            .navigationTitle("Cigarettes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showModalsheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showModalsheet) {
                
                    SmokingModal()
                        .presentationDetents([.fraction(0.6)])
            
            }
        }
        .accessibilityLabel("Cigarettes list")
    }
}



// Ensure CigaretteStore conforms to Identifiable, Codable, and has a date property for sorting



#Preview {
    ContentView()
}
