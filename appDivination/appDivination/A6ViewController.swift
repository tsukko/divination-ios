//
//  A6ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 命名術入力画面
 * 遷移先
 * 　鑑定する（命名術アニメーション画面）
 * 　池田先生の説明を聞く(説明ページ＿命名術)
 * 　戻る（略）
 * 遷移元
 * 　トップ画面

子供の命名アルゴリズム

父親と母親の氏名の音の鏡を合わせて、丸が足りないところの文字をすべてひろう。
丸をすべて埋められるような組み合わせを全て拾い出し、文字数ごとに表示する。

例１

父親 ヤマダタロウさん
母親 ヤマダハナコさん
あなたのお子様が御家族を幸福に導く存在となれるような、愛と調和の言霊をお伝えさせていただきます。

一文字
（ケ、ネ、ノ、ヘ、メ、モ、ユ、ヨ、ヲ）
 の中からどれか一文字を必ず使ってください。

 もし同じ文字が二回以上選べる場合でも、一度使えば繰り返さなくても結構です。
 お伝えさせていただいた文字は必ずお使い下さい。
 それ以外の文字もご自由にお使いください。


例２

父親 サトウタロウさん
母親 サトウアイさん
あなたのお子様が御家族を幸福に導く存在となれるような、愛と調和の言霊をお伝えさせていただきます。

一文字
なし

二文字
（ケ、ネ、ノ、メ、モ）
 の中からどれか一文字と
（エ、ツ、テ、ナ、ニ、マ）
 の中からどれか一文字を選んだ二文字。

三文字
（ケ、ネ、ノ、ヘ、メ、モ、ユ、ヨ、ヲ）
 の中からどれか一文字と
（ケ、コ、ス、ヌ、ネ、ノ、メ、モ、ヤ）
 の中からどれか一文字と
（エ、ツ、テ、ナ、ニ、マ）
 の中からどれか一文字を選んだ三文字。
 
 もし同じ文字が二回以上選べる場合でも、一度使えば繰り返さなくても結構です。
 お伝えさせていただいた文字は必ずお使い下さい。
 それ以外の文字もご自由にお使いください。


 */
class A6ViewController : UIViewController, UITextFieldDelegate {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstDateTextField: UITextField!
    @IBOutlet weak var firstSgCtlSex: UISegmentedControl!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var secondDateTextField: UITextField!
    @IBOutlet weak var secondSgCtlSex: UISegmentedControl!
    @IBOutlet weak var btnAppraise: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    //    @IBOutlet weak var btnConsultation: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = 6
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    //    var toolBar:UIToolbar!
    var datePicker1: UIDatePicker!
    var datePicker2: UIDatePicker!
    let defDateString = "2000-01-01"
    let minDateString = "1900-01-01"
    let maxDateString = "2100-01-01"
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A6ViewController viewDidLoad")
        
        // TODO レイアウト関係
        // 音霊鑑定術
        // カタカムナ音霊命名術でお子様の命名のサポートをさせていただきます。会社名・屋号やペットの命名も可能です。
        // 詳しくは先生の説明をご覧下さい。
        // 父（母）の名前、お誕生日、性別が2セット

        naviBar.setBackgroundImage(UIImage(named: "component_01_header2"), forBarPosition: .TopAttached, barMetrics: .Default)
        
        // 行数無制限
        lblTitle.numberOfLines = 0
        
        // テキストフィールドにDatePickerを表示する
        datePicker1 = UIDatePicker()
        datePicker1.addTarget(self, action: #selector(A6ViewController.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
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
        firstDateTextField.inputView = datePicker1

        // テキストフィールドにDatePickerを表示する
        datePicker2 = UIDatePicker()
        datePicker2.addTarget(self, action: #selector(A6ViewController.changedDateEvent2(_:)), forControlEvents: UIControlEvents.ValueChanged)
        // 日本の日付表示形式にする、年月日の表示にする
        datePicker2.datePickerMode = UIDatePickerMode.Date
        format(datePicker2.date,style: "yyyy/MM/dd")
        datePicker2.locale = NSLocale(localeIdentifier: "ja_JP")
        // 最小値、最大値、初期値を設定
        datePicker2.minimumDate = dateFormatter.dateFromString(minDateString)
        datePicker2.maximumDate = dateFormatter.dateFromString(maxDateString)
        datePicker2.date = dateFormatter.dateFromString(defDateString)!
        secondDateTextField.inputView = datePicker2

        // nameTextField の情報を受け取るための delegate を設定
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
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
    
    // 日付の変更イベント1
    func changedDateEvent(sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(datePicker1.date)
    }
    // 日付の変更1
    func changeLabelDate(date:NSDate) {
        firstDateTextField.text = format(datePicker1.date,style: "yyyy年 MM月 dd日")
    }
    
    // 日付の変更イベント2
    func changedDateEvent2(sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate2(datePicker2.date)
    }
    // 日付の変更2
    func changeLabelDate2(date:NSDate) {
        secondDateTextField.text = format(datePicker2.date,style: "yyyy年 MM月 dd日")
    }
    
    // 名前の入力完了時に閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        return true
    }
    
    // 鑑定するボタンを押したとき　　入力の確認
    @IBAction func touchDownbtnAppraise(sender: AnyObject) {
        // 名前欄のTextFieldの確認
        if (firstNameTextField.text!.isEmpty ||
            secondNameTextField.text!.isEmpty) {
            print("nameTextField.text is enpty.")
            let alertController = UIAlertController(
                title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                message: NSLocalizedString("errorMsgNameEmpty", tableName: "main", comment: ""),
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            if !firstNameTextField.text!.ChackHiraganaOrKatakana() ||
               !secondNameTextField.text!.ChackHiraganaOrKatakana() {
                print("NameTextField.text is not hiragana.")
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
        if (firstDateTextField.text!.isEmpty ||
            secondDateTextField.text!.isEmpty) {
            print("DateTextField.text is not hiragana.")
            let alertController = UIAlertController(
                title: NSLocalizedString("errorTitle", tableName: "main", comment: ""),
                message: NSLocalizedString("errorMsgDate", tableName: "main", comment: ""),
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        // 性別選択の確認
        if (firstSgCtlSex.selectedSegmentIndex == -1 ||
            secondSgCtlSex.selectedSegmentIndex == -1 ) {
            print("SgCtlSex.selectedSegmentIndex == -1")
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
        defaults.setObject(firstNameTextField.text, forKey: "firstuserName")
        defaults.setObject(firstDateTextField.text, forKey: "firstbirthday")
        defaults.setInteger(firstSgCtlSex.selectedSegmentIndex, forKey: "firstsex")
        defaults.setObject(secondNameTextField.text, forKey: "seconduserName")
        defaults.setObject(secondDateTextField.text, forKey: "secondbirthday")
        defaults.setInteger(secondSgCtlSex.selectedSegmentIndex, forKey: "secondsex")
        defaults.synchronize()
    }
    
    // 画面の適当なところをタッチした時、キーボードを隠す
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        print("close keyboard")
        firstNameTextField.resignFirstResponder()
        firstDateTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        secondDateTextField.resignFirstResponder()
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
