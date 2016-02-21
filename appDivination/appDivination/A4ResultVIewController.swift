//
//  A4ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A4ResultViewController : UIViewController {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lblMessage: UILabel!

    /// 画面遷移時に渡す為の値
    var _param:Int = -1
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    
    var _message:String = "b"
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("A4ResultViewController viewDidLoad msg: \(_message)")
        
        // バック画像の設定
//        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue")!)
        
        lblMessage.text = _message
        
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {
        
    }
    
    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = 2
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        NSLog("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
        }
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

