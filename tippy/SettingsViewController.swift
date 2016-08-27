//
//  SettingsViewController.swift
//  tippy
//
//  Created by Yoko Yamaguchi on 8/25/16.
//  Copyright © 2016 Yoko Yamaguchi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var defaultTipControl: UISegmentedControl!
  let defaults = NSUserDefaults.standardUserDefaults()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tipControlIndex = defaults.integerForKey(Constants.TipControlIndex)
    defaultTipControl.selectedSegmentIndex = tipControlIndex
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tipControlChanged(sender: AnyObject) {
    // Persist default tip % value
    defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: Constants.TipControlIndex)
    defaults.synchronize()
    
    NSNotificationCenter.defaultCenter().postNotificationName(Notification.DefaultTipChanged, object: self)
  }
}
