import SwiftUI
import CoreMotion
import Observation

@Observable
class MotionDetector {
    let manager = CMMotionManager()
    var timer = Timer()

    var x = 0.0
    var y = 0.0

    func start() {
        manager.deviceMotionUpdateInterval = 0.05
        manager.startDeviceMotionUpdates()

        timer.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 0.05,
            repeats: true
        ) { _ in
            if let motion = self.manager.deviceMotion {
                self.x = motion.attitude.roll
                self.y = motion.attitude.pitch
            }
        }
    }

    func stop() {
        manager.stopDeviceMotionUpdates()
        timer.invalidate()
    }
}

struct LevelView: View {
    @State var motion = MotionDetector()

    var body: some View {
        VStack(spacing: 30) {
            Text("Bubble Level")
                .font(.largeTitle)

            ZStack {
                Circle()
                    .stroke()
                    .frame(width: 250, height: 250)

                Circle()
                    .fill(.blue)
                    .frame(width: 40, height: 40)
                    .offset(
                        x: motion.x * 60,
                        y: motion.y * 60
                    )
            }

            Text(
                "X: \(motion.x, specifier: "%.2f")"
            )

            Text(
                "Y: \(motion.y, specifier: "%.2f")"
            )
        }
        .onAppear {
            motion.start()
        }
        .onDisappear {
            motion.stop()
        }
    }
}

#Preview {
    LevelView()
}
