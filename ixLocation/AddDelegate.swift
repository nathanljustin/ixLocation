//
//  AddDelegate.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

protocol AddDelegate {
    func didSaveActivity(activity: Activity)
    func didCancelActivity()
}
