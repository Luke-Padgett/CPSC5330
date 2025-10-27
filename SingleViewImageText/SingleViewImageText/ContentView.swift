import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            VStack(spacing: 16) {
                Image("SampleImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Text("Hello from my single-view app")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}
