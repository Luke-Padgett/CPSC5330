
import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: AdventureController
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    var body: some View {
        VStack(spacing: 16) {
            header
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text(controller.currentNode.title)
                        .font(.title)
                        .bold()
                    Text(controller.currentNode.description)
                        .font(.body)
                }
                .padding()
            }
            optionsArea
            Spacer(minLength: 10)
        }
        .padding()
        .sheet(isPresented: $controller.isEnded) {
            EndingView(success: controller.lastEndingWasSuccess,
                       message: controller.endingMessage) {
                controller.reset()
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Crescent Isle").font(.headline)
            Spacer()
            Button("Restart") { controller.reset() }
        }
    }

    @ViewBuilder
    private var optionsArea: some View {
        let options = controller.currentNode.options
        
        VStack(spacing: 10) {
            ForEach(options) { opt in
                Button(action: { controller.choose(option: opt) }) {
                    Text(opt.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.horizontal)
    }
}

struct EndingView: View {
    let success: Bool
    let message: String
    let onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 18) {
            Text(success ? "🎉 Victory!" : "💥 Oops...")
                .font(.largeTitle)
                .bold()
            
            Text(message)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: onRestart) {
                Label("Play Again", systemImage: "arrow.counterclockwise")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(30)
    }
}
