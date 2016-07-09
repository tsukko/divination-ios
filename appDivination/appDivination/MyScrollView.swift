//
//  MyScrollView.swift
//  appDivination
//
//  Created by Norizou on 2016/07/10.
//  Copyright © 2016年 Nori. All rights reserved.
//

import UIKit

class MyScrollView: UIScrollView {
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        superview?.touchesEnded(touches, withEvent: event)
    }
    
}