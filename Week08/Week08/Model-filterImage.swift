// Adapted from the MoLab Week 08 CameraRecorder example.
// https://github.com/molab-itp/08-CameraRecorder/blob/main/CaptureRecorder/Model-filterImage.swift

import AVFoundation
import CoreImage.CIFilterBuiltins
import SwiftUI

enum VideoEffect: String, CaseIterable {
    case normal = "Original"
    case sepia = "Sepia"
    case pixellate = "Pixel"
    case blur = "Blur"
    case vignette = "Vignette"

    var filterName: String? {
        switch self {
        case .normal: return nil
        case .sepia: return "CISepiaTone"
        case .pixellate: return "CIPixellate"
        case .blur: return "CIGaussianBlur"
        case .vignette: return "CIVignette"
        }
    }
}

extension Model {
    func filterImage(_ pixelBuffer: CVPixelBuffer) -> (CIImage, Bool) {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        var filteredImage = ciImage
        var changed = false

        if let filterName = currentEffect.filterName {
            if let filter = CIFilter(name: filterName) {
                filter.setValue(ciImage, forKey: kCIInputImageKey)

                switch currentEffect {
                case .sepia:
                    filter.setValue(0.7, forKey: kCIInputIntensityKey)
                case .pixellate:
                    filter.setValue(30, forKey: kCIInputScaleKey)
                case .blur:
                    filter.setValue(100, forKey: kCIInputRadiusKey)
                case .vignette:
                    filter.setValue(0.5, forKey: kCIInputIntensityKey)
                    filter.setValue(1.0, forKey: kCIInputRadiusKey)
                default:
                    break
                }

                if let outputImage = filter.outputImage {
                    filteredImage = outputImage
                    changed = true
                }
            }
        }

        if let cgImage = context!.createCGImage(filteredImage, from: filteredImage.extent) {
            DispatchQueue.main.async {
                self.previewImage = cgImage
            }
        }

        return (filteredImage, changed)
    }
}
