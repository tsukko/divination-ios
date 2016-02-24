//
//  A3ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A3ResultViewController : UIViewController {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var resultScrollView: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var resultBackImage: UIImageView!
    @IBOutlet weak var CircleImageView: UIImageView!
    
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
        print("A3ResultViewController viewDidLoad msg: \(_message)")
        
        // バック画像の設定
//        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue")!)
        
        lblMessage.text = _message
        // 行数無制限
        lblMessage.numberOfLines = 0
        // サイズを自動調整
        lblMessage.sizeToFit()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        lblName.text = defaults.stringForKey("userName")!+" さん"
        let plotResult:[Int] = (defaults.objectForKey("plotResult") as? [Int])!
        
        // 占い結果の円の表示
        displayCycle(plotResult)
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {
        let SVSize = resultScrollView.frame.size
        self.resultScrollView.contentSize = CGSizeMake(SVSize.width, 1500);
        resultBackImage.frame.size.height = 1500
        
        //scroll画面の初期位置
        resultScrollView.contentOffset = CGPointMake(0, 0);
    }
    
    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = 2
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
        }
    }
    
    // 占い結果の円の表示
    func displayCycle(plotResult:[Int]) {
        CircleImageView.hidden = false
        if (plotResult[0]==0) {
            CircleImageView.hidden = true
        } else if (plotResult[0]==1) {
            CircleImageView.image = UIImage(named: "maru1")
        } else if (plotResult[0]==2) {
            CircleImageView.image = UIImage(named: "maru2")
        }
        
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

