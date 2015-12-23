//
//  A4ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A4ViewController : UIViewController {
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var imgYatagarasu: UIImageView!
    
    /// 画面遷移時に渡す為の値
    var _param:Int = -1
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    // ユーザー名 今日の運勢のボタンを表示するかどうか
    var userName : String = ""
    
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
        
        // TODO 鑑定、そのために前の画面の名前を持ってくる
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
            print("userName:\(userName)")
        }
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {
        // 参考：http://dev.classmethod.jp/references/ios-8-cabasicanimation/
        
        let duration = 1.3    // アニメーション時間 2秒
        let singleTwist = M_PI * 2 // 360度
        
        // 縦回転アニメーション（X軸を中心に回転）
        let verticalTwistAnimation = CABasicAnimation(keyPath: "transform.rotation")
        verticalTwistAnimation.toValue = singleTwist * 2   // 2回転
        
        // アニメーションを同時実行するためにグループを作成
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.animations = [verticalTwistAnimation]

        // アニメーションを実行
        imgYatagarasu.layer.addAnimation(animationGroup, forKey: "moonSaltoAnimation")
        
        // 計算する
        aaa()
        
        // 3秒後に次の結果画面に遷移する
        NSTimer.scheduledTimerWithTimeInterval(2.0,target:self,selector:Selector("transition"), userInfo: nil, repeats: false)
    }
    
    // 3秒後に次の結果画面に遷移する
    func transition() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next:UIViewController = storyboard.instantiateViewControllerWithIdentifier("A05View") as UIViewController
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
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
    
    // test
    func aaa() {
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
            print("userName:\(userName)")
        }
        let characters = userName.characters.map { String($0) }
 
        for v in characters {
            print(v.unicodeScalars)
            for c in v.unicodeScalars {
                if c.value >= 0x3041 && c.value <= 0x3096 {
                    print("ChackHiragana OK")
                
                } else {
                    print("ChackHiragana NG")
                    break
                }
            }
        }
        
        // プロパティファイルをバインド
        let path = NSBundle.mainBundle().pathForResource("arrays", ofType: "plist")
        // rootがDictionaryなのでNSDictionaryに取り込み
        let dict = NSDictionary(contentsOfFile: path!)
        // キー"AAA"の中身はarrayなのでNSArrayで取得
        let arr:NSArray = dict!.objectForKey("free_divination_result_charas_pattern_01") as! NSArray
        // arrayで取れた分だけループ
        for value in arr {
            print(value)
            
        }
    }
}

