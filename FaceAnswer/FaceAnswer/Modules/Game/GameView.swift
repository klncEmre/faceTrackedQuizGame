//
//  GameView.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 14.05.2023.
//

import Foundation
import UIKit
import AVFoundation
import Vision


class GameViewController: UIViewController, AnyView, AVCaptureVideoDataOutputSampleBufferDelegate {
    var presenter: AnyPresenter?
    
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    var faceDetectionRequest: VNRequest!
    
    public let questionTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.text = "Question will be placed here Question will be placed here"
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let questionIndexLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.text = "Question index will be  here"
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let optionFirst: UIButton = {
        let button = UIButton()
        button.setTitle("option 1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(optionFirstPicked), for: .touchUpInside)
        return button
    }()
    
    public let optionSecond: UIButton = {
        let button = UIButton()
        button.setTitle("option2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(optionSecondPicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        setupCaptureSession()
        setupFaceDetection()
        startCaptureSession()
        
        view.addSubview(timerLabel)
        timerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        timerLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5 ).isActive = true
        
        view.addSubview(questionTextLabel)
        questionTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        questionTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -130).isActive = true
        questionTextLabel.heightAnchor.constraint(equalToConstant: 100 ).isActive = true
        questionTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9 ).isActive = true
        
        
        view.addSubview(optionFirst)
        optionFirst.translatesAutoresizingMaskIntoConstraints = false
        optionFirst.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        optionFirst.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 0).isActive = true

        optionFirst.heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        optionFirst.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5 ).isActive = true

        view.addSubview(optionSecond)
        optionSecond.translatesAutoresizingMaskIntoConstraints = false
        optionSecond.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        optionSecond.topAnchor.constraint(equalTo: optionFirst.bottomAnchor , constant: 20).isActive = true
        optionSecond.heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        optionSecond.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5 ).isActive = true
        
        view.addSubview(questionIndexLabel)
        questionIndexLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        questionIndexLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        questionIndexLabel.heightAnchor.constraint(equalToConstant: 40 ).isActive = true
        questionIndexLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8 ).isActive = true
        
        view.bringSubviewToFront(questionTextLabel)
        view.bringSubviewToFront(optionFirst)
        view.bringSubviewToFront(optionSecond)
        view.bringSubviewToFront(questionIndexLabel)
        
        (presenter as? GamePresenter)?.loadTheFirstQuestion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for sv in self.view.layer.sublayers! {
            if let previewLayer = sv as? AVCaptureVideoPreviewLayer {
                previewLayer.frame = self.view.bounds
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("done")
    }
    
    func setupCaptureSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            fatalError("Front camera not found.")
        }
        
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            fatalError("Unable to access front camera.")
        }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInteractive))
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
    }
    
    func setupFaceDetection() {
        faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: (presenter as? GamePresenter)!.handleFaceDetection)
    }
    
    func startCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func stopCaptureSession() {
        captureSession.stopRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch {
            print("Error performing face detection: \(error)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCaptureSession()
    }

}
