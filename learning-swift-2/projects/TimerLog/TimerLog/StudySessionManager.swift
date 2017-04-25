//
//  StudySessionManager.swift
//  TimerLog
//
//  Created by Programus on 16/7/4.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation

struct StudySession {
  var createAt: NSTimeInterval
  var finishedAt: NSTimeInterval = 0
}

class StudySessionManager {
  static let sharedInstance = StudySessionManager()
  var sessions = [StudySession]()
}