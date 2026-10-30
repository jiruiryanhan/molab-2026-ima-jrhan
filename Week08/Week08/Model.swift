// Adapted from the MoLab Week 08 CameraRecorder example.
// https://github.com/molab-itp/08-CameraRecorder/blob/main/CaptureRecorder/Model.swift

import AVFoundation
import CoreImage.CIFilterBuiltins
import SwiftUI

@Observable
class Model: NSObject {
    var session = AVCaptureSession()
    var previewImage: CGImage?
    var selectedEffect: VideoEffect = .normal

    @ObservationIgnored var currentEffect: VideoEffect = .normal
    @ObservationIgnored var context: CIContext?
    @ObservationIgnored var videoDataOutput: AVCaptureVideoDataOutput?

    override init() {
        super.init()
        context = CIContext(options: nil)
    }

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupSession()
                }
            }
        default:
            print("Camera access denied")
        }
    }

    func setupSession() {
        guard let videoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front
        ) else { return }

        session.beginConfiguration()

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            }
        } catch {
            print("Error setting up video input: \(error)")
        }

        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput?.setSampleBufferDelegate(
            self,
            queue: DispatchQueue(label: "videoQueue")
        )

        if let videoDataOutput = videoDataOutput,
           session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            videoDataOutput.videoSettings = [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
            ]

            let videoConnection = videoDataOutput.connection(with: .video)
            videoConnection?.videoRotationAngle = 90.0
        }

        session.commitConfiguration()

        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }

    func changeEffect(to effect: VideoEffect) {
        currentEffect = effect
        selectedEffect = effect
    }
}

extension Model: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        let (_, _) = filterImage(pixelBuffer)
    }
}
