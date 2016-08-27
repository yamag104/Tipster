//
//  ViewController.swift
//  tippy
//
//  Created by Yoko Yamaguchi on 8/25/16.
//  Copyright © 2016 Yoko Yamaguchi. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
  
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var tipView: UIView!
  var tipViewHidden: Bool!
  let defaults = NSUserDefaults.standardUserDefaults()
  
  override func viewDidLoad() {
    print("viewDidLoad")
    super.viewDidLoad()
    setViewMovedUp(false)
    // Always show number pad
    billField.becomeFirstResponder()
    updateTipSegmentControl()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "defaultTipChanged",
                                                               name: Notification.DefaultTipChanged,
                                                             object: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func defaultTipChanged() {
    updateTipSegmentControl()
    calculateTip(self)
  }
  
  @IBAction func calculateTip(sender: AnyObject) {
    let tipPercentages = [0.18, 0.2, 0.25]
    
    let bill = Double(billField.text!) ?? 0
    let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
    let total = bill + tip
    
    tipLabel.text = String(format: "$%.2f", tip)
    totalLabel.text = String(format: "$%.2f", total)

    if (tipViewHidden && billField.text != "") {
      setViewMovedUp(true)
    } else if (billField.text == ""){
     setViewMovedUp(false)
    }
  }
  
  func setViewMovedUp(movedUp: Bool) {
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(0.3)
    
    var rect = tipView.frame
    if (movedUp) {
      rect.origin.y -= Constants.KeyboardOffset
      rect.size.height += Constants.KeyboardOffset
      tipViewHidden = false
    } else {
      rect.origin.y += Constants.KeyboardOffset
      rect.size.height -= Constants.KeyboardOffset
      tipViewHidden = true
    }
    
    tipView.frame = rect
    UIView.commitAnimations()
  }
  
  func updateTipSegmentControl() {
    let tipControlIndex = defaults.integerForKey(Constants.TipControlIndex)
    tipControl.selectedSegmentIndex = tipControlIndex
  }
}

