import SwiftUI

struct AudioPlayerView: View {
    @State var audioDJ = AudioDJ()
    @AppStorage("hammerCount") var hammerCount = 0
    @AppStorage("starCount") var starCount = 0
    @AppStorage("windCount") var windCount = 0
    @AppStorage("waveCount") var waveCount = 0

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button {
                        audioDJ.choose(0)
                        audioDJ.play()
                        hammerCount += 1
                    } label: {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: 45))
                            .frame(width: 100, height: 100)
                    }

                    Text("\(hammerCount)")
                }

                VStack {
                    Button {
                        audioDJ.choose(1)
                        audioDJ.play()
                        starCount += 1
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.system(size: 45))
                            .frame(width: 100, height: 100)
                    }

                    Text("\(starCount)")
                }
            }
            .buttonStyle(.bordered)

            HStack {
                VStack {
                    Button {
                        audioDJ.choose(2)
                        audioDJ.play()
                        windCount += 1
                    } label: {
                        Image(systemName: "wind")
                            .font(.system(size: 45))
                            .frame(width: 100, height: 100)
                    }

                    Text("\(windCount)")
                }

                VStack {
                    Button {
                        audioDJ.choose(3)
                        audioDJ.play()
                        waveCount += 1
                    } label: {
                        Image(systemName: "hand.wave.fill")
                            .font(.system(size: 45))
                            .frame(width: 100, height: 100)
                    }

                    Text("\(waveCount)")
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onDisappear {
            audioDJ.stop()
        }
    }
}

#Preview {
    AudioPlayerView()
}
