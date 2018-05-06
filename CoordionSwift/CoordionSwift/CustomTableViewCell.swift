//
//  CustomTableViewCell.swift
//  playMusic
//
//  Created by 新納真次郎 on 2017/10/08.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func tapOnemoreBtn(_ sender: Any) {
    print(String(describing: self.titleLabel.text) + "が押された")
  }
  
  
}

