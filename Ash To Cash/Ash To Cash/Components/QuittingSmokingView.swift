//
//  QuittingSmokingView.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 15/12/23.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        guard let url = Bundle.main.url(forResource: name, withExtension: "gif"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load GIF: \(name).gif")
        }

        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        webView.scrollView.isScrollEnabled = false

        return webView
    }


    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("pokeball")
    }
}

struct QuittingSmokingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    GifImage("LungLoop").scaledToFit()
                        .cornerRadius(20)
                        .accessibilityHidden(true)
                    Text("- Made by: Samira Rasouliilkhechi").font(.caption).foregroundStyle(.gray).bold()
                        .accessibilityHidden(true)
                }
                Text("What Happens When You Quit Smoking Gradually?")
                    .font(.title)
                    .fontWeight(.bold)

                Text("1. After 20 minutes: ")
                    .fontWeight(.semibold)
                Text("The blood pressure and pulse rate return to normal.")

                Text("2. After 12 hours: ")
                    .fontWeight(.semibold)
                Text("Levels of carbon monoxide in blood return to normal.")

                Text("3. After 48 hours: ")
                    .fontWeight(.semibold)
                Text("The sense of taste and smell are improved.")

                Text("4. After 1-9 months: ")
                    .fontWeight(.semibold)
                Text("The body rids itself of the presence of nicotine. The lungs are less fatigued and coughing disappears. Walking becomes easier and physical energy increases, as well as the sense of fatigue and exhaustion are lessened.")

                Text("5. After 1 year: ")
                    .fontWeight(.semibold)
                Text("The risk of desease decreases by 50 %.")

                Text("6. After 5 years: ")
                    .fontWeight(.semibold)
                Text("The risk of cerebral hemorrhage drops by 41 %, while the risk of stroke becomes equal to the levels of those who have never smoked. For women former smokers, the threat of getting diabetes falls to the level of women who have never smoked.")

                Text("7. After 10 years: ")
                    .fontWeight(.semibold)
                Text("Even for men, the risk of diabetes falls to the levels of nonsmokers. Moreover, are reduced also the risk of ulcers and possibility to develop cancers of the mouth, throat, esophagus,bladder, kidney, pancreas; the risk of lung cancer drops by up to 70 %.")

                Text("8. After 15 years: ")
                    .fontWeight(.semibold)
                Text("Many factors return to normality, on par with those who have never smoked in their lives. In particular, conditions equalize for tooth loss, coronary heart disease, and generic risk of early death.")
                
                Text("8. After 20 years: ")
                    .fontWeight(.semibold)
                Text("The lungs of an ex-smoker are completely healed and can be considered the same as those of an individual who has never smoked.")
                
            }
            .padding()
        }
    }
}


