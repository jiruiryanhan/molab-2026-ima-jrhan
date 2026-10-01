//
//  ContentView.swift
//  week4
//
//  Created by Jirui Han on 10/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("audio")
                    .font(.system(size: 40))

                NavigationLink("enter") {
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
    
    @State var audioDJ = AudioDJ()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    audioDJ.choose(0)
                    audioDJ.play()
                } label: {
                    Image(systemName: "hammer.fill")
                        .font(.system(size: 45))
                        .frame(width: 100, height: 100)
                }

                Button {
                    audioDJ.choose(1)
                    audioDJ.play()
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 45))
                        .frame(width: 100, height: 100)
                }
            }
            .buttonStyle(.bordered)

            HStack {
                Button {
                    audioDJ.choose(2)
                    audioDJ.play()
                } label: {
                    Image(systemName: "wind")
                        .font(.system(size: 45))
                        .frame(width: 100, height: 100)
                }

                Button {
                    audioDJ.choose(3)
                    audioDJ.play()
                } label: {
                    Image(systemName: "hand.wave.fill")
                        .font(.system(size: 45))
                        .frame(width: 100, height: 100)
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }

}

#Preview {
    ContentView()
}
