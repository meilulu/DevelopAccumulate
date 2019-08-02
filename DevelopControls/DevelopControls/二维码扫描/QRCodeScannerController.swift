//
//  QRCodeScannerController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/1/30.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScannerController: UIViewController {
    
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    //相机视图样式，可自定义（比如微信的扫描样式）
    let aView = QRCodePreview(frame: UIScreen.main.bounds)
    
    //创建会话
    let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫一扫"
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选择二维码", style: .done, target: self, action: #selector(doRightAction))
        
        self.view.addSubview(self.aView)
        
        self.setup()
    }
    
    func setup() {
        //初始化捕捉器设备，类型video
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        let input: AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        do {
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice!)
            
            //把输入流添加到会话
            self.captureSession.addInput(input)
            //把输出流添加到会话
            self.captureSession.addOutput(output)
            
        }catch {
            print("创建输入流异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue")
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,.ean13,.ean8,.code128]
        
        /**创建预览图层（这个图层可以自定义，就是扫描框以及上面的各种控件）**/
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        //设置预览图层的填充方式
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //设置预览图层的frame
        videoPreviewLayer.frame = self.aView.bounds
        //将预览图层添加到预览视图上
        self.aView.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let scanFrame = self.aView.scannerView.frame
        //设置扫描范围。
        output.rectOfInterest = CGRect(x: scanFrame.origin.y/height, y: scanFrame.origin.x/width, width: scanFrame.size.height/height, height: scanFrame.size.width/width)
        
        self.captureSession.startRunning()
    }
    
    @objc fileprivate func doRightAction() {
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.aView.startMove()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.aView.stopMove()
    }
}

//输出流代理
extension QRCodeScannerController:AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("_______")
        
        if metadataObjects.count > 0 {
            //二维码的data数据
            let metaData: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            //二维码数据转为字符串
            let stringValue = metaData.stringValue
            print(stringValue!)
            
            self.captureSession.stopRunning()
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
}

//照片代理
extension QRCodeScannerController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        
        //获取相册中二维码中的数据
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        let ciImage = CIImage(data: imageData!)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        let array = detector?.features(in: ciImage!)
        
        if let result = array!.first as? CIQRCodeFeature {
            print("二维码数据是：\(result.messageString)")
        }
        else {
            print("选择的图片不是二维码")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
