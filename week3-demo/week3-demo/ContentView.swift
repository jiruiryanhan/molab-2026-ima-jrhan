import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Random Images")
                    .font(.system(size: 40))

                NavigationLink("View Image") {
                    PatternView()
                }
                .font(.system(size: 30))
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

struct PatternView: View {
    let choices = [
        "globe",
        "car.side",
        "person.fill",
        "apple.logo"
    ]

    @State var images = Array(
        repeating: "globe",
        count: 9
    )

    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        let index = row * 3 + column

                        Image(systemName: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                    }
                }
            }

            Button("Generate Again") {
                randomize()
            }
            .font(.system(size: 25))
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            randomize()
        }
    }

    func randomize() {
        for index in 0..<images.count {
            let randomNumber = Int.random(
                in: 0..<choices.count
            )

            images[index] = choices[randomNumber]
        }
    }
}

#Preview {
    ContentView()
}
