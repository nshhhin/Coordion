//
//  PlayerViewController.swift
//  CoordionSwift
//
//  Created by 新納真次郎 on 2017/11/10.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {
  
  /* プレイヤーのUI部分 */
  @IBOutlet weak var artworkView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var seekBar: UISlider!
  @IBOutlet weak var rewindBtn: UIButton!
  @IBOutlet weak var playpauseBtn: UIButton!
  @IBOutlet weak var skipBtn: UIButton!
  
  var youtubeView: YTPlayerView!
  var youtubeList: [String] = []
  var playIndex = 0
  var global: AppDelegate!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    global = UIApplication.shared.delegate as! AppDelegate
    for i in 0..<global.playlist.count {
      youtubeList.append( global.playlist[i]["link"]! )
    }
    
    youtubeView = YTPlayerView(frame: CGRect(x: artworkView.bounds.minX, y: artworkView.bounds.minY, width: artworkView.frame.width, height: artworkView.frame.height))
    youtubeView.load(withVideoId: youtubeList[0], playerVars: ["playsinline":1,"controls":0])
    artworkView.addSubview(youtubeView)
    
    titleLabel.text = global.playlist[0]["name"] as! String
    artistLabel.text = global.playlist[0]["artist"] as! String
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func tapRewind(_ sender: Any) {
    playIndex -= 1
  }
  
  @IBAction func tapSkip(_ sender: Any) {
    youtubeView.stopVideo()
    playIndex += 1
  }
  
  @IBAction func tapPlayPauseBtn(_ sender: Any) {
//    youtubeView.removeFromSuperview()
//    youtubeView.load(withVideoId: youtubeList[playIndex])
//    artworkView.addSubview(youtubeView)
      youtubeView.playVideo()
      playpauseBtn.imageView?.image = UIImage(named: "BtnPause")
//    playpauseBtn.imageView?.image = UIImage(named: "BtnPause")
  }
  
}

