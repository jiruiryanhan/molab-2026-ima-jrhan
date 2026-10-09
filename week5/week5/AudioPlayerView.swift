import SwiftUI

struct AudioPlayerView: View {
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
        .onDisappear {
            audioDJ.stop()
        }
    }
}

#Preview {
    AudioPlayerView()
}
