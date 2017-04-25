//
//  Service.swift
//  GIFReader
//
//  Created by Programus on 16/5/26.
//  Copyright © 2016年 programus. All rights reserved.
//

import UIKit

class Service {
  var url = "http://i.imgur.com/j74SykU.gif"
  
  func getGIF(callback: (NSData) -> Void) {
    request(url, callback: callback)
  }
  
  func request(url: String, callback: (NSData) -> Void) {
    if let nsUrl = NSURL(string: url) {
      let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl) {
        (data, response, error) in
        if let d = data {
          callback(d)
        }
      }
      task.resume()
    }
  }
}