//
//  ViewController.swift
//  CoordionSwift
//
//  Created by 新納真次郎 on 2017/11/10.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDelegate {

  @IBOutlet weak var pageControl: UIPageControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("起動されました")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  var index = 0
  
  func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    
  }
}

