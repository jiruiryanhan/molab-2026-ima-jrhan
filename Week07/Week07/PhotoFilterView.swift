import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct PhotoFilterView: View {
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State var audioDJ = AudioDJ()
    @AppStorage("hammerCount") var hammerCount = 0
    @AppStorage("starCount") var starCount = 0
    @AppStorage("windCount") var windCount = 0
    @AppStorage("waveCount") var waveCount = 0

    let context = CIContext()

    var body: some View {
        VStack(spacing: 12) {
            PhotosPicker(selection: $selectedItem) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView(
                        "No Photo",
                        systemImage: "photo.badge.plus",
                        description: Text("Tap to choose a photo")
                    )
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedItem, loadImage)
            .frame(maxHeight: 260)

            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity, applyProcessing)
            }

            HStack {
                VStack {
                    Button {
                        audioDJ.choose(0)
                        audioDJ.play()
                        hammerCount += 1
                        setFilter(CIFilter.sepiaTone())
                    } label: {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                    }

                    Text("Sepia: \(hammerCount)")
                }

                VStack {
                    Button {
                        audioDJ.choose(1)
                        audioDJ.play()
                        starCount += 1
                        setFilter(CIFilter.pixellate())
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                    }

                    Text("Pixel: \(starCount)")
                }
            }
            .buttonStyle(.bordered)

            HStack {
                VStack {
                    Button {
                        audioDJ.choose(2)
                        audioDJ.play()
                        windCount += 1
                        setFilter(CIFilter.gaussianBlur())
                    } label: {
                        Image(systemName: "wind")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                    }

                    Text("Blur: \(windCount)")
                }

                VStack {
                    Button {
                        audioDJ.choose(3)
                        audioDJ.play()
                        waveCount += 1
                        setFilter(CIFilter.vignette())
                    } label: {
                        Image(systemName: "hand.wave.fill")
                            .font(.system(size: 30))
                            .frame(width: 70, height: 55)
                    }

                    Text("Vignette: \(waveCount)")
                }
            }
            .buttonStyle(.bordered)

        }
        .padding()
        .navigationTitle("Audio Photo Filter")
        .onDisappear {
            audioDJ.stop()
        }
    }

    // Class example: https://github.com/molab-itp/07-Instafilter/blob/main/project13/Instafilter/ContentView.swift
    func loadImage() {
        Task {
            guard let imageData = try? await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }

    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    NavigationStack {
        PhotoFilterView()
    }
}
