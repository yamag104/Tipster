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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tipControlChanged(sender: AnyObject) {
    // Persist tip % value
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: Constants.kTipControlIndex)
    defaults.synchronize()
  }
}
