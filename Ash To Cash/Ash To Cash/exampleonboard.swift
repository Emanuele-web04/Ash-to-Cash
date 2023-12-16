import SwiftUI

struct OnBoardPage: View {
    @FocusState var isTextFieldFocused: FocusField?
    @State private var numberDisplayed = 0
    
    enum FocusField {
        case cig, pack, currency
    }
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            Spacer()
            Image(systemName: "wind.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.mint)
            Text("How many cigarettes did you smoke per day?")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300)
            TextField("0", value: $numberDisplayed, formatter: NumberFormatter())
                .focused($isTextFieldFocused, equals: .cig)
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
            .bold()
            .font(.system(size: 60))
            .multilineTextAlignment(.center)
            Text(numberDisplayed == 0 ? "" : numberDisplayed <= 3 ? "This number is good!" : numberDisplayed <= 8 ? "We need to work on that!" : "We have to do better!")
                .foregroundStyle(numberDisplayed == 0 ? .black : numberDisplayed <= 3 ? .mint : numberDisplayed <= 8 ? .indigo : .red)
                .animation(.easeIn(duration: 0.5))
            Spacer()
            if numberDisplayed != 0 && isTextFieldFocused == nil {
                withAnimation {
                    Button(action: {
                    }, label: {
                        Text("Continue")
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.mint)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

#Preview {
    OnBoardPage()
}
