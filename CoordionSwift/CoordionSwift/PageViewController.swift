//
//  PageViewController.swift
//  CoordionSwift
//
//  Created by 新納真次郎 on 2017/11/11.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getFirst() -> PageViewController {
    return storyboard!.instantiateViewController(withIdentifier: "turtorial1") as!  PageViewController
  }
  
}
