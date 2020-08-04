//
//  YPCameraView.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/3.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit
import AVFoundation

class YPCameraView: UIView, UIImagePickerControllerDelegate {
    
    var captureSeesion: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        
        self.backgroundColor = HEXColor(h: 0x999999)
        
        captureSeesion = AVCaptureSession()
        if (captureSeesion?.canSetSessionPreset(AVCaptureSession.Preset.hd4K3840x2160))! {
            captureSeesion?.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160
        } else if (captureSeesion?.canSetSessionPreset(AVCaptureSession.Preset.hd1920x1080))! {
            captureSeesion?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        } else if (captureSeesion?.canSetSessionPreset(AVCaptureSession.Preset.hd1280x720))! {
            captureSeesion?.sessionPreset = AVCaptureSession.Preset.hd1280x720
        } else {
            captureSeesion?.sessionPreset = AVCaptureSession.Preset.high
        }
        
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if (authStatus != AVAuthorizationStatus.authorized) {
            print("无权限\(authStatus.rawValue)")
            return
        }
        let backCamera: AVCaptureDevice = AVCaptureDevice.devices().first!
        
        var error: Error?
        
        var input: AVCaptureDeviceInput!
        do {
            try input = AVCaptureDeviceInput(device: backCamera)
        } catch let e as Error {
            error = e
            input = nil
        }

        if (error != nil || input == nil) {
            print("show input error == \(String(describing: error?.localizedDescription))")
            return
        }
        
        if (captureSeesion?.canAddInput(input))! {
            
            captureSeesion?.addInput(input)
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if (captureSeesion?.canAddOutput(stillImageOutput!))! {
                
                captureSeesion?.addOutput(stillImageOutput!)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSeesion!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer?.connection?.videoOrientation =  AVCaptureVideoOrientation.portrait
                
                self.layer.insertSublayer(previewLayer!, at: 0)
                
                captureSeesion?.startRunning()
            }
        }
    }
}
