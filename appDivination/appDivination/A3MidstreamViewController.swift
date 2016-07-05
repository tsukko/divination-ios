//
//  A3MidstreamViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A3MidstreamViewController : UIViewController {
    
//    @IBOutlet var viewBack: UIView!
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
        print("A3MidstreamViewController viewDidLoad")
        
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
        
        // アニメーション時間　2.0秒で設定→1.3秒
        let duration = 0.2 //1.3 デバッグ用に変更   // アニメーション時間 2秒
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
        // TODO 特別な結果と、一般を一気にして、一つのStringとして取得している
        // TODO 前半のメッセージと後半のメッセージ、運気の上がる言葉の３つのストリングを取得する
//        let msg:String = divination()
        divination()
        
        // 3秒後に次の結果画面に遷移する
        // 第1引数の部分は、タイマーを発生させる間隔です。例えば、0.1なら0.1秒間隔になります。1.0なら1.0秒間隔です。
        // 第2引数の「target」は、タイマー発生時に呼び出すメソッドがあるターゲットを指定します。通常は「self」で大丈夫だと思います。
        // 第3引数の「selector」の部分は、タイマー発生時に呼び出すメソッドを指定します。今回の場合は「onUpdate」を呼び出しています。
        // 2.0で設定していた
        // TODO userInfo: msg を空にした
        NSTimer.scheduledTimerWithTimeInterval(0.1,target:self,selector:#selector(A3MidstreamViewController.transition(_:)), userInfo: "", repeats: false)
    }
    
    // 3秒後に次の結果画面に遷移する
    func transition(timer: NSTimer) {
        let msg = timer.userInfo as! String
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next:A3ResultViewController = storyboard.instantiateViewControllerWithIdentifier("A3ResultView") as! A3ResultViewController
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        next._messageAAA = msg
        next._message = msg
        self.presentViewController(next, animated: true, completion: nil)
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
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // TODO 特別な結果と、一般を一気にして、一つのStringとして取得している
    // 占った結果をNSUserDefaultsで保存
    func divination() {
        // 名前は、NSUserDefaultsに保存したのを読み出す
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
//            print("userName:\(userName)")
        }
        let characters = userName.characters.map { String($0) }

        let kanaData = kanaDataClass()
        var plotResult:[Int] = [0,0,0,0,0,0,0,0]

        // ここで文字を１文字づつ繰り返し処理
        for v in characters {
            for c in v.unicodeScalars {
                if (c.value >= 0x3041 && c.value <= 0x3096) ||
                   (c.value >= 0x30A1 && c.value <= 0x30F6) ||
                   c.value == 0x0020 || c.value == 0xFF5A {
                    print("ChackHiragana OK: \(v) : \(c.value)")
                    let s = NSString(format:"%2X", c.value) as String
                    var test:[String!] = kanaData.getPlotData("0x" + s)
                    for i in 0...7 {
                        plotResult[i] += Int(test[i])!
                    }
                } else {
                    // ここに来るまでに判定しているので、ここは通らない想定
                    print("ChackHiragana NG")
                    break
                }
            }
        }
        
        // やっつけ。プロットの結果を保存
        defaults.setObject(plotResult, forKey: "plotResult")
        defaults.synchronize()

        print("plotResult : \(plotResult)")
 //       let message = resultDivinationClass.specialResult(plotResult)
 //       print("message : \(message)")

//        let retDivination = resultDivinationClass()
//        let message:String = retDivination.specialResult(plotResult)
        
//        return message

/*
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
*/
    }
}

