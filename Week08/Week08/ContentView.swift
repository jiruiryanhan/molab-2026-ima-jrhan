//
//  ContentView.swift
//  Week08
//
//  Based on the MoLab Week 08 CameraRecorder example.
//  https://github.com/molab-itp/08-CameraRecorder
//
import SwiftUI

struct ContentView: View {
    @State var model = Model()
    @State var audioDJ = AudioDJ()

    var body: some View {
        VStack(spacing: 0) {
            FrameView(image: model.previewImage)
                .edgesIgnoringSafeArea(.top)

            FilterSelectionView()
        }
        .background(Color.black)
        .onAppear {
            model.checkPermissions()
        }
    }

    func FilterSelectionView() -> some View {
        return VStack(spacing: 8) {
            HStack {
                VStack {
                    Button {
                        audioDJ.choose(0)
                        audioDJ.play()
                        model.changeEffect(to: .sepia)
                    } label: {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                            .background(model.selectedEffect == .sepia ? Color.blue : Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Text(VideoEffect.sepia.rawValue)
                        .foregroundColor(.white)
                }

                VStack {
                    Button {
                        audioDJ.choose(1)
                        audioDJ.play()
                        model.changeEffect(to: .pixellate)
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                            .background(model.selectedEffect == .pixellate ? Color.blue : Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Text(VideoEffect.pixellate.rawValue)
                        .foregroundColor(.white)
                }
            }
            HStack {
                VStack {
                    Button {
                        audioDJ.choose(2)
                        audioDJ.play()
                        model.changeEffect(to: .blur)
                    } label: {
                        Image(systemName: "wind")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                            .background(model.selectedEffect == .blur ? Color.blue : Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Text(VideoEffect.blur.rawValue)
                        .foregroundColor(.white)
                }

                VStack {
                    Button {
                        audioDJ.choose(3)
                        audioDJ.play()
                        model.changeEffect(to: .vignette)
                    } label: {
                        Image(systemName: "hand.wave.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                            .background(model.selectedEffect == .vignette ? Color.blue : Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Text(VideoEffect.vignette.rawValue)
                        .foregroundColor(.white)
                }
            }
            Button {
                audioDJ.stop()
                model.changeEffect(to: .normal)
            } label: {
                Text(VideoEffect.normal.rawValue)
                    .padding(8)
                    .background(model.selectedEffect == .normal ? Color.blue : Color.gray.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}
