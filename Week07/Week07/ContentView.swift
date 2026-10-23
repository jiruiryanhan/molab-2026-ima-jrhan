//
//  ContentView.swift
//  Week07
//
//  Created by Jirui Han on 10/8/26.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Audio Photo Filter")
                    .font(.largeTitle)

                NavigationLink("Open") {
                    PhotoFilterView()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    ContentView()
}
