import UIKit

let size = CGSize(width: 1024, height: 1024)

let format = UIGraphicsImageRendererFormat()
format.scale = 1

let renderer = UIGraphicsImageRenderer(
    size: size,
    format: format
)

let image = renderer.image { context in
    for row in 0..<16 {
        for column in 0..<16 {
            let color = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1
            )

            color.setFill()

            context.fill(CGRect(
                x: CGFloat(column * 64),
                y: CGFloat(row * 64),
                width: 64,
                height: 64
            ))
        }
    }
}

image
