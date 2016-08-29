//
//  ViewController.swift
//  FRDIntentDemo
//
//  Created by GUO Lin on 8/25/16.
//  Copyright © 2016 Douban Inc. All rights reserved.
//

import UIKit
import FRDIntent

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "MainViewController"
    view.backgroundColor = UIColor.whiteColor()

    let button = UIButton()
    button.frame = CGRect(x: 20, y: 100, width: view.bounds.size.width - 40, height: 44)
    button.setTitle("By uri", forState: .Normal)
    button.backgroundColor = UIColor.greenColor()
    button.addTarget(self, action: #selector(gotoFirstViewController), forControlEvents: .TouchUpInside)
    view.addSubview(button)

    let secondButton = UIButton()
    secondButton.frame = CGRect(x: 20, y: 200, width: view.bounds.size.width - 40, height: 44)
    secondButton.setTitle("By Class Name", forState: .Normal)
    secondButton.backgroundColor = UIColor.greenColor()
    secondButton.addTarget(self, action: #selector(gotoSecondViewController), forControlEvents: .TouchUpInside)
    view.addSubview(secondButton)

    let thirdButton = UIButton()
    thirdButton.frame = CGRect(x: 20, y: 300, width: view.bounds.size.width - 40, height: 44)
    thirdButton.setTitle("Intent for result", forState: .Normal)
    thirdButton.backgroundColor = UIColor.greenColor()
    thirdButton.addTarget(self, action: #selector(gotoThirdViewController), forControlEvents: .TouchUpInside)
    view.addSubview(thirdButton)

  }

  func gotoFirstViewController() {
    let intent = Intent(uri: NSURL(string: "douban://douban.com/frodo/firstViewController")!)
    intent.putExtra(name: "number", data: 1)
    let manager = ControllerManager.sharedInstance
    manager.startController(source: self, intent: intent)
  }

  func gotoSecondViewController() {
    let intent = Intent(clazz: SecondViewController.self)
    intent.putExtra(name: "number", data: 2)
    let manager = ControllerManager.sharedInstance
    manager.startController(source: self, intent: intent)
  }

  func gotoThirdViewController() {
    let intent = Intent(clazz: ThirdViewController.self)
    intent.putExtra(name: "text", data: "Text From Source")
    let manager = ControllerManager.sharedInstance
    manager.startForResultController(source: self, intent: intent, requestCode: 1)
  }

}

extension ViewController: IntentForResultSendableController {

  func onControllerResult(requestCode requestCode: Int, resultCode: Int, data: Intent) {
    let text = data.extra["text"]
    print("get from destination : \(text)")
  }

}