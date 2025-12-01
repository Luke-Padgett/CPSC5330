import SwiftUI

struct ResultsView: View {
    let usdAmount: Int
    let selected: [Bool]
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 24) {
                    Text("Amount in USD")
                        .foregroundColor(.red)
                        .font(.title2)
                        .padding(.top, 20)
                    Text("\(usdAmount)")
                        .font(.largeTitle)
                        .padding(.bottom, 8)
                    VStack(spacing: 16) {
                        ForEach(Array(CurrencyConverter.availableCurrencies.enumerated()), id: \.element.id) { index, currency in
                            if selected.indices.contains(index) && selected[index] {
                                HStack {
                                    Text(currency.name)
                                    Spacer()
                                    Text(format(CurrencyConverter.convert(amountUSD: usdAmount, to: currency)))
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                    }
                    .frame(maxWidth: min(proxy.size.width - 40, 700))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Results")
    }

    func format(_ value: Double) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf.string(from: NSNumber(value: value)) ?? String(format: "%.2f", value)
    }
}
