//
//  A4ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 今日のつぶやき結果画面
 * 遷移先
 * 　池田先生の説明を聞く(説明ページ＿今日のつぶやき)
 * 　戻る（略）
 * 遷移元
 * 　今日のつぶやきアニメーション画面
 * 　トップ画面（右下のボタン）
 */
class A4ResultViewController : UIViewController {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!

    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値　（TODO final値）
    var _paramOriginal:Int = 4
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A4ResultViewController viewDidLoad")
 
        var userName:String = ""
        
        // 占いの実行　、standardUserDefaultsにわざわざ保存しなくてもいい
        let retDivination = resultDivinationClass()
        retDivination.divination()

        // 名前部分の表示
        let defaults = NSUserDefaults.standardUserDefaults()
        userName = defaults.stringForKey("userName")!
        lblName.text = userName
        
        // 占いの実行　、standardUserDefaultsにわざわざ保存しなくてもいい
        let retDivination = resultDivinationClass()
        let plotResult:[Int] = retDivination.divinationReturnResult(userName)
       
        // TODO 名前の後に　" さんの"とつける
        // TODO 名前の下に"今日の運気を上げるつぶやきは．．．"を表示

        // 運気を上げるつぶやき文字の取得とセット
        lblMessage.text = retDivination.getTodayLuckyWord(userName, plotData: plotResult, "")

        // TODO 下に表示
        // "声に出してつぶやくとより運気も高まります！"
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {     
        changeLayout();
    }

    func changeLayout(){
    	// TODO 念のためレイアウト高さの設定が必要？？
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
}

