//
//  ViewController.swift
//  GIFReader
//
//  Created by Programus on 16/5/26.
//  Copyright © 2016年 programus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var service = Service()

  override func viewDidLoad() {
    super.viewDidLoad()
    loadGIF()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func loadGIF() {
    service.getGIF() {
      (data) in
      var current = 0
      var len = 6
      print(NSString(data: data.subdataWithRange(NSMakeRange(current, len)), encoding: NSUTF8StringEncoding))
      current += len
      len = 2
      var width = [UInt16](count: 1, repeatedValue: 0)
      data.getBytes(&width, range: NSMakeRange(current, len))
      current += len
      var height = [UInt16](count: 1, repeatedValue: 0)
      data.getBytes(&height, range: NSMakeRange(current, len))
      current += len
      len = 1
      var packed = [UInt8](count: 1, repeatedValue: 0)
      data.getBytes(&packed, range: NSMakeRange(current, len))
      let hasGlobalColorTable = (packed[0] & 1 == 1)
      print("(\(width), \(height)) \(hasGlobalColorTable) \(String(packed[0], radix: 2))")
    }
  }

}

