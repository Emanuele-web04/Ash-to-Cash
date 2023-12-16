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
                    Text("- Made by: Samira Rasouliilkhechi").font(.caption).foregroundStyle(.gray).bold()
                }
                Text("Cosa Succede Quando Si Smette di Fumare Gradualmente?")
                    .font(.title)
                    .fontWeight(.bold)

                Text("1. Dopo 20 minuti: ")
                    .fontWeight(.semibold)
                Text("La pressione sanguigna e la frequenza del polso ritornano normali.")

                Text("2. Dopo 12 ore: ")
                    .fontWeight(.semibold)
                Text("I livelli di monossido di carbonio nel sangue tornano normali.")

                Text("3. Dopo 2-12 settimane: ")
                    .fontWeight(.semibold)
                Text("Migliora la circolazione sanguigna e aumenta la funzione polmonare.")

                Text("4. Dopo 1-9 mesi: ")
                    .fontWeight(.semibold)
                Text("Diminuiscono la tosse e la difficoltà respiratoria.")

                Text("5. Dopo 1 anno: ")
                    .fontWeight(.semibold)
                Text("Il rischio di malattie cardiache è circa la metà rispetto a un fumatore.")

                Text("6. Dopo 5 anni: ")
                    .fontWeight(.semibold)
                Text("Il rischio di ictus è ridotto a quello di un non fumatore.")

                Text("7. Dopo 10 anni: ")
                    .fontWeight(.semibold)
                Text("Il rischio di cancro ai polmoni è circa la metà rispetto a un fumatore.")

                Text("8. Dopo 15 anni: ")
                    .fontWeight(.semibold)
                Text("Il rischio di malattie cardiache è lo stesso di una persona che non ha mai fumato.")
            }
            .padding()
        }
    }
}


