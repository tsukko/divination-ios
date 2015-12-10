//
//  ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/11/08.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //１のラベル
        let label1 = UILabel();
        label1.text = "ああああああああ！";
        self.view.addSubview(label1);
        label1.backgroundColor = UIColor.yellowColor();////背景色
        label1.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label1);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



