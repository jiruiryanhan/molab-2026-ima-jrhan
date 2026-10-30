// based on the molab Week 08 examples:
// https://github.com/molab-itp/08-CameraRecorder
// https://github.com/molab-itp/08-FilterTheWorld

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("Video feed")

    var body: some View {
        if let image = image {
            GeometryReader { geometry in
                Image(image, scale: 1.0, orientation: .upMirrored, label: label)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center
                    )
                    .clipped()
            }
        } else {
            EmptyView()
        }
    }
}
