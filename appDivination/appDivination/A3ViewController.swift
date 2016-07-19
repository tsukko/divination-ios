//
//  A3ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 無料言霊鑑定入力画面
 * 遷移先
 * 　鑑定する（無料言霊鑑定アニメーション画面）
 * 　池田先生の説明を聞く(説明ページ＿音霊鑑定)
 * 　戻る（略）
 * 遷移元
 * 　トップ画面
 */
class A3ViewController : UIViewController, UITextFieldDelegate {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var sgCtlSex: UISegmentedControl!
    @IBOutlet weak var btnAppraise: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
//    @IBOutlet weak var btnConsultation: UIButton!
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = 3
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    //    var toolBar:UIToolbar!
    var datePicker1: UIDatePicker!
    let defDateString = "2000-01-01"
    let minDateString = "1900-01-01"
    let maxDateString = "2100-01-01"
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A3ViewController viewDidLoad")

        naviBar.setBackgroundImage(UIImage(named: "component_01_header2"), forBarPosition: .TopAttached, barMetrics: .Default)
        
        // テキストフィールドにDatePickerを表示する
        datePicker1 = UIDatePicker()
        datePicker1.addTarget(self, action: #selector(A3ViewController.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
        // 日本の日付表示形式にする、年月日の表示にする
        datePicker1.datePickerMode = UIDatePickerMode.Date
        format(datePicker1.date,style: "yyyy/MM/dd")
        datePicker1.locale = NSLocale(localeIdentifier: "ja_JP")
        // 最小値、最大値、初期値を設定
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        datePicker1.minimumDate = dateFormatter.dateFromString(minDateString)
        datePicker1.maximumDate = dateFormatter.dateFromString(maxDateString)
        datePicker1.date = dateFormatter.dateFromString(defDateString)!
        dateTextField.inputView = datePicker1

        // 保存していた情報の復元
        let defaults = NSUserDefaults.standardUserDefaults()
        nameTextField.text = defaults.stringForKey("userName")
        dateTextField.text = defaults.stringForKey("birthday")
        sgCtlSex.selectedSegmentIndex = defaults.integerForKey("sex")
        
        // nameTextField の情報を受け取るための delegate を設定
        nameTextField.delegate = self
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
            secondViewController._paramOriginal = viewNumber
        } else if segue.identifier == "midstream" {
            let secondViewController:MidstreamViewController = segue.destinationViewController as! MidstreamViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = viewNumber
        }
    }
    
    // 日付の変更イベント
    func changedDateEvent(sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(datePicker1.date)
    }
    // 日付の変更
    func changeLabelDate(date:NSDate) {
        dateTextField.text = format(datePicker1.date,style: "yyyy年 MM月 dd日")
    }
    
    // 名前の入力完了時に閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    // 鑑定するボタンを押したとき　　入力の確認
    @IBAction func touchDownbtnAppraise(sender: AnyObject) {
        // 名前欄のTextFieldの確認
        if (nameTextField.text!.isEmpty) {
            // null、空のとき
            print("nameTextField.text is enpty.")
            let alertController = UIAlertController(
                title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                message: NSLocalizedString("errorMsgNameEmpty", tableName: "main", comment: ""),
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            if !nameTextField.text!.ChackHiraganaOrKatakana() {
                // ひらがな、カタカナ、空白以外のとき
                print("nameTextField.text is not hiragana or katakana.")
                let alertController = UIAlertController(
                    title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                    message: NSLocalizedString("errorMsgNameKana", tableName: "main", comment: ""),
                    preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
        // 誕生日欄のTextFieldの確認
        if (dateTextField.text!.isEmpty) {
            // null、空のとき
            print("dateTextField.text is not hiragana.")
            let alertController = UIAlertController(
                title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                message: NSLocalizedString("errorMsgDate", tableName: "main", comment: ""),
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        // 性別選択の確認
        if (sgCtlSex.selectedSegmentIndex == -1) {
            // 未選択のとき
            print("sgCtlSex.selectedSegmentIndex == -1")
            let alertController = UIAlertController(
                title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                message: NSLocalizedString("errorMsgSex", tableName: "main", comment: ""),
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }

        // この判定が終わったら、次の画面に遷移する
        
        // NSUserDefaultsオブジェクトを取得し、設定情報を保存する
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nameTextField.text, forKey: "userName")
        defaults.setObject(dateTextField.text, forKey: "birthday")
        defaults.setInteger(sgCtlSex.selectedSegmentIndex, forKey: "sex")
        defaults.synchronize()
    }
    
    // 画面の適当なところをタッチした時、キーボードを隠す
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        print("close keyboard")
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    // 書式指定に従って日付を文字列に変換します
    // パラメータ
    //  date : 日付データ(NSDate型)を指定します
    //  style : 書式を指定します
    //          yyyy 西暦,MM 月,dd 日,HH 時,mm 分,ss 秒
    //
    func format(date : NSDate, style : String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/*
// コピーやペーストなどのメニューを非表示にするための拡張
class SampleTextField: UITextField{
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        UIMenuController.sharedMenuController().menuVisible = false
        return false
    }
}

// ひらがなチェック用の拡張
// TODO 定義するクラスを変更する
extension String {
    func ChackHiraganaOrKatakana() -> Bool {
        var flagKana:Bool = false
        
        // 文字列を表現するUInt32
        for c in unicodeScalars {
            // ひらがな、もしくは、カタカナ、半角空白、全角空白であること
            if (c.value >= 0x3041 && c.value <= 0x3096) ||
                (c.value >= 0x30A1 && c.value <= 0x30F6) ||
                c.value == 0x0020 || c.value == 0xFF5A {
       //         print("ChackHiragana OK")
                flagKana = true
            } else {
                print("ChackHiragana NG : \(c.value)")
                flagKana = false
                break
            }
        }
        
        return flagKana
    }
}
 */