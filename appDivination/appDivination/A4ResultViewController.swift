//
//  A4ResultViewController.swift
//  appDivination
//
//  Created by nt on 2015/12/22.
//  Copyright © 2015年 nt. All rights reserved.
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
        let defaults = UserDefaults.standard
        userName = defaults.string(forKey: Const.UserName)!
        lblName.text = userName
        
        // 占いの実行
        let retDivination = resultDivinationClass()

        // 運気を上げるつぶやき文字の取得とセット
        // 初めて占いを行う場合や、前に占ってから日付が変わっている場合に、占いを実施する。
        var LukcyWord:String? = defaults.string(forKey: Const.LukcyWord)
        let saveTime = defaults.object(forKey: Const.SaveTime) as? Date
        if LukcyWord == nil || LukcyWord!.isEmpty || saveTime == nil || !checkDateToday(saveTime!) {
            print("get LukcyWord")
            LukcyWord = retDivination.getTodayLuckyWord(userName, tweetWord: "")
            defaults.set(LukcyWord, forKey: Const.LukcyWord)
            defaults.set(Date(), forKey: Const.SaveTime)
        } else {
            print("LukcyWord Already get")
        }
        lblMessage.text = LukcyWord
    }
    
    // 画面が表示された直後
    override func viewDidAppear(_ animated:Bool) {
        changeLayout();
    }

    func changeLayout(){
        // レイアウト高さ設定
    }
    
    // 説明を聞くボタンを押した時
    @IBAction func touchDownBtnConsultation(_ sender: AnyObject) {
        _param = viewNumber
        performSegue(withIdentifier: "segue",sender: nil)
    }

    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destination as! A2ViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = viewNumber
        }
    }
    
    // 引数の日時が同じ日であるかどうかをチェックする
    func checkDateToday(_ savedDate: Date) -> Bool {
        // 日付の変換 YYYY MM DD
        let cal = Calendar.current
        let comp = (cal as NSCalendar).components(
            [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day,
                NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second],
            from: savedDate)
        let compNow = (cal as NSCalendar).components(
            [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day,
                NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second],
            from: Date())

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

