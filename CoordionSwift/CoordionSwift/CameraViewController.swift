//
//  CameraViewController.swift
//  CoordionSwift
//
//  Created by 新納真次郎 on 2017/11/10.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
  
  @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var LoadingLabel: UILabel!
  @IBOutlet weak var LoadingView: UIView!
  @IBOutlet weak var myVideoView: UIView!
  var mySession : AVCaptureSession!
  var myDevice : AVCaptureDevice!
  var myImageOutput: AVCapturePhotoOutput!
  var cameraDevice: AVCaptureDevice!
  var isBack = true
  var global: AppDelegate!
  @IBOutlet weak var successImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    global = UIApplication.shared.delegate as! AppDelegate
    runCapture()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func runCapture(){
    // セッションの作成.
    mySession = AVCaptureSession()
    let devices = AVCaptureDevice.devices()
    for device in devices {
      // isBack == True  -> Back Camera
      // iSBack == False -> Front Camera
      let devicePosition: AVCaptureDevice.Position = isBack ? .back : .front
      if (device as AnyObject).position == devicePosition {
        self.cameraDevice = device as! AVCaptureDevice
      }
    }
    
    // バックカメラからVideoInputを取得.
    let videoInput = try! AVCaptureDeviceInput.init(device: cameraDevice!)
    // セッションに追加.
    mySession.addInput(videoInput)
    
    // 出力先を生成.
    myImageOutput = AVCapturePhotoOutput()
    // セッションに追加.
    mySession.addOutput(myImageOutput)
    
    // 画像を表示するレイヤーを生成.
    let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
    myVideoLayer.frame = myVideoView.bounds
    myVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    myVideoView.layer.addSublayer(myVideoLayer)
    
//    // セッション開始.
//    mySession.startRunning()
//
    let metadataOutput = AVCaptureMetadataOutput()
    mySession.addOutput(metadataOutput)
    
    // QRコードを検出した際のデリゲート設定
    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    // QRコードの認識を設定
    metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    // セッションの開始
    DispatchQueue.global(qos: .userInitiated).async {
      self.mySession.startRunning()
    }
  }
  
  @IBAction func tapCameraButton(_ sender: Any) {
    mySession.stopRunning()
    
    ActivityIndicator.startAnimating()
    LoadingView.isHidden = false
    
    // mysqlに服IDを送信し，V-A値を取得する
    let random = Int(arc4random_uniform(89)+1)
    let postString = "id=\(random)"
    // APIに取得したV-A値を送信し，プレイリストを取得する
    var request = URLRequest(url: URL(string: "http://nkmr.io/~sasaki/Songle/value_request.php")!)
    request.httpMethod = "POST"
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      do {
        print("response: \(response!)")
        let phpOutput = String(data: data!, encoding: .utf8)!
        let dic_cloth = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,String>

        self.ActivityIndicator.stopAnimating()
        self.ActivityIndicator.isHidden = true
        self.successImage.isHidden = false
        print("=====================")
        print( dic_cloth["valence"]! )
        print( dic_cloth["arousal"]! )
        print("=====================")
        
        let postString2 = "v=\(dic_cloth["valence"]!)&a=\(dic_cloth["arousal"]!)"
        var request2 = URLRequest(url: URL(string: "http://aramasa.nkmr.io/cordion")!)
        request2.httpMethod = "POST"
        request2.httpBody = postString2.data(using: .utf8)
         let task2 = URLSession.shared.dataTask(with: request2, completionHandler: { (data2, response2, error2) in
          if error2 != nil {
            print(error2)
            return
          }
          do {
            let dic_array = try JSONSerialization.jsonObject(with: data2!, options: []) as! [Dictionary<String,String>]
            self.global.playlist = dic_array
            let next = self.storyboard!.instantiateViewController(withIdentifier: "TabBarView")
            next.modalTransitionStyle = .crossDissolve
            self.present(next,animated: true, completion: nil)
          }
          catch {
            print(error2?.localizedDescription)
          }

         })
        task2.resume()
      }
      catch {
        print(error.localizedDescription)
      }
    })
    task.resume()
  }
  
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
      for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
        // QRコードのデータかどうかの確認
        if metadata.type == AVMetadataObject.ObjectType.qr {
          // 検出位置を取得
          if metadata.stringValue != nil {
            // 検出データを取得
            print("====================")
            print(metadata.stringValue!)
            print("====================")

          }
        }
      }
  }
  
  @IBAction func tapUndoButton(_ sender: Any) {
    dismiss(animated: true)
    mySession.stopRunning()
  }
  
  @IBAction func changedSwitch(_ sender: Any) {
    switch (sender as AnyObject).selectedSegmentIndex {
    case 0:
      print("背面")
      isBack = true
      runCapture()
    case 1:
      print("正面")
      isBack = false
      runCapture()
    default:
      print("")
    }
  }
  
}
