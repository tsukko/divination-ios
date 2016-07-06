//
//  A4MidstreamViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit


// TODO これ、あとで、A3MidstreamViewControllerと共通化すること
/*
 * 今日のつぶやきアニメーション画面
 * 遷移先ページ
 * 　自動遷移
 * 　池田先生の説明を聞く(説明ページ＿今日のつぶやき)
 * 　戻る（略）
 * 遷移元ページ
 * 　無料言霊鑑定入力画面
 */
class A4MidstreamViewController : UIViewController {

//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var imgYatagarasu: UIImageView!
    
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値　（TODO final値）
    var _paramOriginal:Int = 4
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0
    // ユーザー名 今日の運勢のボタンを表示するかどうか
    var userName : String = ""
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A4MidstreamViewController viewDidLoad")
        
        // TODO 鑑定、そのために前の画面の名前を持ってくる
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
            print("A4MidstreamViewController viewDidLoad userName:\(userName)")
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
//        let msg:String = divination()
        divination()
        
        // 3秒後に次の結果画面に遷移する
        // 第1引数の部分は、タイマーを発生させる間隔です。例えば、0.1なら0.1秒間隔になります。1.0なら1.0秒間隔です。
        // 第2引数の「target」は、タイマー発生時に呼び出すメソッドがあるターゲットを指定します。通常は「self」で大丈夫だと思います。
        // 第3引数の「selector」の部分は、タイマー発生時に呼び出すメソッドを指定します。今回の場合は「onUpdate」を呼び出しています。
        // 2.0で設定していた
        // TODO userInfo: msg を空にした
        NSTimer.scheduledTimerWithTimeInterval(2.0,target:self,selector:#selector(A4MidstreamViewController.transition(_:)), userInfo: "", repeats: false)
    }
    
    // TODO そのうち共通化
    // 3秒後に次の結果画面に遷移する
    func transition(timer: NSTimer) {
        let msg = timer.userInfo as! String
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next:A4ResultViewController = storyboard.instantiateViewControllerWithIdentifier("A4ResultView") as! A4ResultViewController
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        next._message = msg
        self.presentViewController(next, animated: true, completion: nil)
    }
    

    // 説明を聞くボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = 3
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = _paramOriginal
        }
    }

    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TODO resultDivinationClassに移す
    // 占った結果をNSUserDefaultsで保存
    func divination() {
        // 名前は、NSUserDefaultsに保存したのを読み出す
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
//            print("divination userName:\(userName)")
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

        // プロットの結果を保存、無料言霊鑑定結果画面
        defaults.setObject(plotResult, forKey: "plotResult")
        defaults.synchronize()
//        let retDivination = resultDivinationClass()
//        let message = retDivination.specialResult(plotResult)
//        let test123:String = retDivination.getMessage(plotResult)
 //       print("message : \(message)")
//        return message
//        return ""
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
        print("divination plotResult : \(plotResult)")
    }
}

