//
//  ContentView.swift
//  week5
//
//  Created by Jirui Han on 10/8/26.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("My App")
                    .font(.largeTitle)

                NavigationLink("Random Images") {
                    PatternView()
                }
                .buttonStyle(.bordered)

                NavigationLink("Bubble Level") {
                    LevelView()
                }
                .buttonStyle(.bordered)

    

                NavigationLink("Audio Player") {
                    AudioPlayerView()
                }
                .buttonStyle(.bordered)
            }
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
        VStack(spacing: 20) {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        Image(
                            systemName:
                                images[row * 3 + column]
                        )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                    }
                }
            }

            Button("Generate Again") {
                randomize()
            }
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
