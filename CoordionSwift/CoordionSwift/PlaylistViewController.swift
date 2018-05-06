//
//  PlaylistViewController.swift
//  CoordionSwift
//
//  Created by 新納真次郎 on 2017/11/10.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var titles: [String] = []
  var artists: [String] = []
  var global: AppDelegate!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    global = UIApplication.shared.delegate as! AppDelegate
    
    tableView.dataSource = self as UITableViewDataSource
    tableView.delegate = self as UITableViewDelegate
    
    titles = []
    artists = []
    
    for i in 0..<global.playlist.count {
      titles.append( global.playlist[i]["name"]! )
      artists.append( global.playlist[i]["artist"]! )
    }
  
    self.tableView.reloadData()
  }
  
  /// セルの個数を指定するデリゲートメソッド（必須）
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return global.playlist.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // セルにボタン表示する時に参考になりそう（http://joyplot.com/documents/2016/11/11/swift-uitableview/）
  //セルに表示する文字列を設定する
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
    // セルに値を設定
    cell.titleLabel.text = titles[indexPath.row] as? String
    cell.artistLabel.text = artists[indexPath.row] as? String
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  @IBAction func tapCamera(_ sender: Any) {
    let next = storyboard!.instantiateViewController(withIdentifier: "CameraView")
    next.modalTransitionStyle = .crossDissolve
    self.present(next,animated: true, completion: nil)
  }
  
}
