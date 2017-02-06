//
//  A3MidstreamViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 無料言霊鑑定アニメーション画面
 * 遷移先ページ
 * 　自動遷移
 * 　池田先生の説明を聞く(説明ページ＿音霊鑑定)
 * 　戻る（略）
 * 遷移元ページ
 * 　無料言霊鑑定入力画面
 */
class MidstreamViewController : UIViewController {
    
    @IBOutlet weak var imgYatagarasu: UIImageView!
    
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MidstreamViewController viewDidLoad:_paramOriginal:\(_paramOriginal)")
        
        self.imgYatagarasu.isHidden = true
    }

    // 画面が表示された直後
    override func viewDidAppear(_ animated:Bool) {
        // 参考：http://dev.classmethod.jp/references/ios-8-cabasicanimation/
        
        self.imgYatagarasu.isHidden = false
        self.imgYatagarasu.isUserInteractionEnabled = true
        let myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MidstreamViewController.touchImgSkipAnimation(_:)))
        self.imgYatagarasu.addGestureRecognizer(myTap)
        
        // アニメーション時間　2.0秒で設定→1.3秒
        let duration = 1.3   // アニメーション時間 2秒
        let singleTwist = M_PI * 2 // 360度
        
        // 縦回転アニメーション（X軸を中心に回転）
        let verticalTwistAnimation = CABasicAnimation(keyPath: "transform.rotation")
        verticalTwistAnimation.toValue = singleTwist * 2   // 2回転

        // TODO サイズを変化させるアニメーション
        let sizeAnimation:CABasicAnimation = CABasicAnimation(keyPath: "bounds.size")
//        sizeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        sizeAnimation.fromValue = NSValue(cgSize:CGSize(width: 360/6, height: 266/6))
        sizeAnimation.toValue = NSValue(cgSize:CGSize(width: 360, height: 266))
        
        // アニメーションを同時実行するためにグループを作成
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.animations = [verticalTwistAnimation, sizeAnimation]

        // アニメーションを実行
        imgYatagarasu.layer.add(animationGroup, forKey: "moonSaltoAnimation")

        // 3秒後に次の結果画面に遷移する
        // 第1引数の部分は、タイマーを発生させる間隔です。例えば、0.1なら0.1秒間隔になります。1.0なら1.0秒間隔です。
        // 第2引数の「target」は、タイマー発生時に呼び出すメソッドがあるターゲットを指定します。通常は「self」で大丈夫だと思います。
        // 第3引数の「selector」の部分は、タイマー発生時に呼び出すメソッドを指定します。今回の場合は「onUpdate」を呼び出しています。
        // 2.0で設定していた
        Timer.scheduledTimer(timeInterval: 1.3, target:self, selector:#selector(MidstreamViewController.transition(_:)), userInfo: "", repeats: false)
    }

    // 3秒後に画像を点滅させてから、次の結果画面に遷移する
    func transition(_ timer: Timer) {
        print("MidstreamViewController transition:_paramOriginal:\(_paramOriginal)")
        
        //点滅アニメーション
        UIView.animate(withDuration: 0.2,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.repeat,
                                   animations: {() -> Void in
                                    self.imgYatagarasu.alpha = 0.0},
                                   completion: nil)
        
        Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(MidstreamViewController.transition2(_:)), userInfo: "", repeats: false)
    }
    
    func transition2(_ timer: Timer) {
        
        //点滅の停止処理
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.animate(withDuration: 0.001, animations: {
            self.imgYatagarasu.alpha = 1.0
        })
        
        goExplainPage()
    }

    // 次の結果画面に遷移する
    func goExplainPage() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        if _paramOriginal == Const.ViewNumber.A3ViewConNum {
            // 無料言霊鑑定結果画面
           let next:A3ResultViewController = storyboard.instantiateViewController(withIdentifier: "A3ResultView") as! A3ResultViewController
           next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
           self.present(next, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A4ViewConNum {
            // 今日のつぶやき結果画面
           let next:A4ResultViewController = storyboard.instantiateViewController(withIdentifier: "A4ResultView") as! A4ResultViewController
           next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
           self.present(next, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A5ViewConNum {
            // 相性診断結果画面
           let next:A5ResultViewController = storyboard.instantiateViewController(withIdentifier: "A5ResultView") as! A5ResultViewController
           next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
           self.present(next, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A6ViewConNum {
            // 命名術結果画面
           let next:A6ResultViewController = storyboard.instantiateViewController(withIdentifier: "A6ResultView") as! A6ResultViewController
           next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
           self.present(next, animated: true, completion: nil)
        }
    }
    
    // アニメーション画像をタップして、アニメーションを飛ばす
    func touchImgSkipAnimation(_ sender:UITapGestureRecognizer) {
        goExplainPage()
    }

    // 説明を聞くボタンを押した時
    @IBAction func touchDownBtnConsultation(_ sender: AnyObject) {
        _param = _paramOriginal
        performSegue(withIdentifier: "segue",sender: nil)
    }

    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destination as! A2ViewController
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
}

