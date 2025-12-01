import Foundation

struct Currency: Identifiable {
    let id: Int
    let name: String
    let ratePerUSD: Double
}

class CurrencyConverter {
    static let availableCurrencies: [Currency] = [
        Currency(id: 1, name: "Euro", ratePerUSD: 0.91),
        Currency(id: 2, name: "INR", ratePerUSD: 74.5),
        Currency(id: 3, name: "GBP", ratePerUSD: 0.77),
        Currency(id: 4, name: "CAD", ratePerUSD: 1.10)
    ]
    static func convert(amountUSD: Int, to currency: Currency) -> Double {
        return Double(amountUSD) * currency.ratePerUSD
    }
}
