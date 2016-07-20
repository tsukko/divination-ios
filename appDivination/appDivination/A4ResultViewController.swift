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
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!

    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A4ViewConNum
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
        print("A4ResultViewController viewDidLoad")
 
        var userName:String = ""

        // 名前部分の表示
        let defaults = NSUserDefaults.standardUserDefaults()
        userName = defaults.stringForKey(Const.UserName)!
        lblName.text = userName
        
        // 占いの実行
        let retDivination = resultDivinationClass()
        let plotResult:[Int] = retDivination.divinationReturnResult(userName)

        // 運気を上げるつぶやき文字の取得とセット
        // 初めて占いを行う場合や、前に占ってから日付が変わっている場合に、占いを実施する。
        var LukcyWord:String? = defaults.stringForKey(Const.LukcyWord)
        let saveTime = defaults.objectForKey(Const.SaveTime) as? NSDate
        if LukcyWord == nil || LukcyWord!.isEmpty || saveTime == nil || !checkDateToday(saveTime!) {
            print("get LukcyWord")
            LukcyWord = retDivination.getTodayLuckyWord(userName, plotData: plotResult, tweetWord: "")
            defaults.setObject(LukcyWord, forKey: Const.LukcyWord)
            defaults.setObject(NSDate(), forKey: Const.SaveTime)
        } else {
            print("LukcyWord Already get")
        }
        lblMessage.text = LukcyWord
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {
        changeLayout();
    }

    func changeLayout(){
        // レイアウト高さ設定
    }
    
    // 説明を聞くボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = viewNumber
        performSegueWithIdentifier("segue",sender: nil)
    }

    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = viewNumber
        }
    }
    
    // 引数の日時が同じ日であるかどうかをチェックする
    func checkDateToday(savedDate: NSDate) -> Bool {
        // 日付の変換 YYYY MM DD
        let cal = NSCalendar.currentCalendar()
        let comp = cal.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day,
                NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second],
            fromDate: savedDate)
        let compNow = cal.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day,
                NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second],
            fromDate: NSDate())

        if comp.year == compNow.year &&
            comp.month == compNow.month &&
            comp.day == compNow.day {
            return true
        } else {
            return false
        }
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

