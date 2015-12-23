//
//  A4ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A4ViewController : UIViewController, UITextFieldDelegate {
    
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    
    @IBOutlet var viewBack: UIView!

    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("A4ViewController viewDidLoad")
        
        // バック画像の設定
        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue.png")!)
        
        // TODO タイマー処理
        // TODO アニメーション
        // TODO 鑑定、そのために前の画面の名前を持ってくる
        

    }
    

    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

