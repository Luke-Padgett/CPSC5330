import SwiftUI

struct ContentView: View {
    @State private var usdText: String = ""
    @State private var errorMessage: String = ""
    @State private var c1: Bool = true
    @State private var c2: Bool = true
    @State private var c3: Bool = true
    @State private var c4: Bool = false
    @State private var navigate: Bool = false
    @State private var amountToPass: Int = 0
    @FocusState private var textFieldIsFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("CurrencyConverter")
                        .font(.title)
                        .padding(.top, 24)
                    HStack {
                        Text("Enter USD:")
                        Spacer()
                        TextField("0", text: $usdText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 120)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($textFieldIsFocused)
                            .onChange(of: usdText) { _, newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered != newValue { usdText = filtered }
                                if usdText.count > 9 { usdText = String(usdText.prefix(9)) }
                            }
                    }
                    .padding(.horizontal, 24)
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                    } else {
                        Text(" ")
                            .padding(.horizontal, 24)
                    }
                    VStack(spacing: 16) {
                        ToggleRow(label: "Currency 1", isOn: $c1)
                        ToggleRow(label: "Currency 2", isOn: $c2)
                        ToggleRow(label: "Currency 3", isOn: $c3)
                        ToggleRow(label: "Currency 4", isOn: $c4)
                    }
                    .padding(.horizontal, 24)
                    Spacer(minLength: 8)
                    Button("CONVERT") {
                        textFieldIsFocused = false
                        validateAndNavigate()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: 700)
                .padding(.horizontal)
            }
            .navigationDestination(isPresented: $navigate) {
                ResultsView(usdAmount: amountToPass, selected: [c1, c2, c3, c4])
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        textFieldIsFocused = false
                    }
                }
            }
        }
    }

    func validateAndNavigate() {
        errorMessage = ""
        guard !usdText.isEmpty, let amt = Int(usdText) else {
            errorMessage = "Please enter a whole number (USD)."
            return
        }
        if !c1 && !c2 && !c3 && !c4 {
            errorMessage = "Select at least one currency."
            return
        }
        amountToPass = amt
        navigate = true
    }
}
