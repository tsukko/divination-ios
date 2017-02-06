//
//  A6ViewController.swift
//  appDivination
//
//  Created by nt on 2015/12/22.
//  Copyright © 2015年 nt. All rights reserved.
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

父親 ヤマダタロウさん　　やまだたろう　[0, 1, 2, 0, 0, 1, 1, 1]
母親 ヤマダハナコさん　　やまだはなこ　[2, 0, 1, 0, 1, 0, 2, 2]
あなたのお子様が御家族を幸福に導く存在となれるような、愛と調和の言霊をお伝えさせていただきます。

一文字
（ケ、ネ、ノ、ヘ、メ、モ、ユ、ヨ、ヲ）
 の中からどれか一文字を必ず使ってください。

 もし同じ文字が二回以上選べる場合でも、一度使えば繰り返さなくても結構です。
 お伝えさせていただいた文字は必ずお使い下さい。
 それ以外の文字もご自由にお使いください。

★補足
index=3 が1になる文字
け [0, 0, 0, 1, 0, 0, 0, 1]
ね [0, 1, 0, 1, 0, 1, 0, 1]
の [0, 0, 0, 1, 0, 0, 0, 1]
へ [0, 0, 0, 1, 0, 0, 0, 0]
め [0, 0, 0, 1, 0, 0, 0, 1]
も [0, 0, 0, 1, 0, 0, 0, 1]
ゆ [0, 0, 0, 1, 0, 0, 0, 0]
よ [0, 0, 0, 1, 0, 0, 0, 0]
を [0, 0, 0, 1, 0, 0, 0, 0]

例２

父親 サトウタロウさん　　さとうたろう　[0, 1, 2, 0, 0, 1, 0, 0]
母親 サトウアイさん　　　さとうあい　　[1, 0, 1, 0, 1, 0, 0, 0]
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

★補足
け [0, 0, 0, 1, 0, 0, 0, 1]
え [0, 0, 1, 0, 0, 0, 1, 0]

======
例）
 父: さわきたりき    [00000000]
 母: さわきたみう    [00200000]

組み合わせ(36通り)
- つ + ね
- つ + せろね + けのめもね
- つ + せろね + へゆよをけのめもね + すぬやこけのめもね
- つ + くふヱせろね + ね
- つ + くふヱせろね + けのめもね + おむせろね
- つ + くふヱせろね + へゆよをけのめもね + ね
- つ + くふヱせろね + へゆよをけのめもね + おむせろね + すぬやこけのめもね
- こ + ね + つ
- こ + ね + いしそんはほるつ + なにえてまつ
- こ + せろね + へゆよをけのめもね + つ
- こ + せろね + へゆよをけのめもね + いしそんはほるつ + なにえてまつ
- こ + くふヱせろね + ね + つ
- こ + くふヱせろね + ね + いしそんはほるつ + なにえてまつ
- こ + くふヱせろね + へゆよをけのめもね + つ + おむせろね
- こ + くふヱせろね + へゆよをけのめもね + いしそんはほるつ + おむせろね + なにえてまつ
- はほるつ + ね + なにえてまつ
- はほるつ + せろね + けのめもね + なにえてまつ
- はほるつ + せろね + へゆよをけのめもね + なにえてまつ + すぬやこけのめもね
- はほるつ + くふヱせろね + ね + なにえてまつ
- はほるつ + くふヱせろね + けのめもね + おむせろね + なにえてまつ
- はほるつ + くふヱせろね + へゆよをけのめもね + ね + なにえてまつ
- はほるつ + くふヱせろね + へゆよをけのめもね + おむせろね + なにえてまつ + すぬやこけのめもね
- あかひれはほるこつ + ね + つ
- あかひれはほるこつ + ね + いしそんはほるつ + なにえてまつ
- あかひれはほるこつ + せろね + けのめもね + つ
- あかひれはほるこつ + せろね + けのめもね + いしそんはほるつ + なにえてまつ
- あかひれはほるこつ + せろね + へゆよをけのめもね + つ + すぬやこけのめもね
- あかひれはほるこつ + せろね + へゆよをけのめもね + いしそんはほるつ + なにえてまつ + すぬやこけのめもね
- あかひれはほるこつ + くふヱせろね + ね + つ
- あかひれはほるこつ + くふヱせろね + ね + いしそんはほるつ + なにえてまつ
- あかひれはほるこつ + くふヱせろね + けのめもね + つ + おむせろね
- あかひれはほるこつ + くふヱせろね + けのめもね + いしそんはほるつ + おむせろね + なにえてまつ
- あかひれはほるこつ + くふヱせろね + へゆよをけのめもね + つ + ね
- あかひれはほるこつ + くふヱせろね + へゆよをけのめもね + つ + おむせろね + すぬやこけのめもね
- あかひれはほるこつ + くふヱせろね + へゆよをけのめもね + いしそんはほるつ + ね + なにえてまつ
- あかひれはほるこつ + くふヱせろね + へゆよをけのめもね + いしそんはほるつ + おむせろね + なにえてまつ + すぬやこけのめもね

つ [1, 0, 1, 0, 1, 0, 1, 0]
ね [0, 1, 0, 1, 0, 1, 0, 1]
せ [0, 1, 0, 0, 0, 1, 0, 0]
ろ [0, 1, 0, 0, 0, 1, 0, 0]
せろね [0, 3, 0, 1, 0, 3, 0, 1]

======
 */
class A6ViewController : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstDateTextField: UITextField!
    @IBOutlet weak var firstSgCtlSex: UISegmentedControl!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var secondDateTextField: UITextField!
    @IBOutlet weak var secondSgCtlSex: UISegmentedControl!
    @IBOutlet weak var btnAppraise: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!

    @IBOutlet weak var InputView1: UIView!
    @IBOutlet weak var InputView2: UIView!

    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A6ViewConNum
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    //    var toolBar:UIToolbar!
    var datePicker1: UIDatePicker!
    var datePicker2: UIDatePicker!
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A6ViewController viewDidLoad")
        
        naviBar.setBackgroundImage(UIImage(), for: .topAttached, barMetrics: .default)
        naviBar.shadowImage = UIImage()
        
        self.InputView1.layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0).cgColor
        self.InputView1.layer.borderWidth = 1
        self.InputView1.layer.cornerRadius = 5
        self.InputView2.layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0).cgColor
        self.InputView2.layer.borderWidth = 1
        self.InputView2.layer.cornerRadius = 5
        
        // テキストフィールドにDatePickerを表示する
        datePicker1 = UIDatePicker()
        datePicker1.addTarget(self, action: #selector(A6ViewController.changedDateEvent(_:)), for: UIControlEvents.valueChanged)
        // 日本の日付表示形式にする、年月日の表示にする
        datePicker1.datePickerMode = UIDatePickerMode.date
        //format(datePicker1.date,style: "yyyy/MM/dd")
        datePicker1.locale = Locale(identifier: "ja_JP")
        // 最小値、最大値、初期値を設定
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Const.DateSetFormat
        datePicker1.minimumDate = dateFormatter.date(from: Const.MinDateString)
        datePicker1.maximumDate = dateFormatter.date(from: Const.MaxDateString)
        datePicker1.date = dateFormatter.date(from: Const.DefDateString)!
        firstDateTextField.inputView = datePicker1

        // テキストフィールドにDatePickerを表示する
        datePicker2 = UIDatePicker()
        datePicker2.addTarget(self, action: #selector(A6ViewController.changedDateEvent2(_:)), for: UIControlEvents.valueChanged)
        // 日本の日付表示形式にする、年月日の表示にする
        datePicker2.datePickerMode = UIDatePickerMode.date
        //format(datePicker2.date,style: "yyyy/MM/dd")
        datePicker2.locale = Locale(identifier: "ja_JP")
        // 最小値、最大値、初期値を設定
        datePicker2.minimumDate = dateFormatter.date(from: Const.MinDateString)
        datePicker2.maximumDate = dateFormatter.date(from: Const.MaxDateString)
        datePicker2.date = dateFormatter.date(from: Const.DefDateString)!
        secondDateTextField.inputView = datePicker2

        // 保存していた情報の復元
        let defaults = UserDefaults.standard
        firstNameTextField.text = defaults.string(forKey: Const.FirstUserName)
        firstDateTextField.text = defaults.string(forKey: Const.FirstBirthday)
        firstSgCtlSex.selectedSegmentIndex = defaults.integer(forKey: Const.FirstSex)
        secondNameTextField.text = defaults.string(forKey: Const.SecondUserName)
        secondDateTextField.text = defaults.string(forKey: Const.SecondBirthday)
        secondSgCtlSex.selectedSegmentIndex = defaults.integer(forKey: Const.SecondSex)

        // nameTextField の情報を受け取るための delegate を設定
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        
        // scrollviewを使った場合、ここでタップを検知できるように設定する
        myScrollView.delegate = self
        let singleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action:#selector(A6ViewController.singleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        self.myScrollView.isUserInteractionEnabled = true
        self.myScrollView.addGestureRecognizer(singleTapGesture)
    }

    // 相談ボタンを押した時
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
        } else if segue.identifier == "midstream" {
            let secondViewController:MidstreamViewController = segue.destination as! MidstreamViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = viewNumber
        }
    }
    
    // 日付の変更イベント1
    func changedDateEvent(_ sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(datePicker1.date)
    }
    // 日付の変更1
    func changeLabelDate(_ date:Date) {
        firstDateTextField.text = format(datePicker1.date,style: Const.DateFormat)
    }
    
    // 日付の変更イベント2
    func changedDateEvent2(_ sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate2(datePicker2.date)
    }
    // 日付の変更2
    func changeLabelDate2(_ date:Date) {
        secondDateTextField.text = format(datePicker2.date,style: Const.DateFormat)
    }
    
    // 名前の入力完了時に閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        return true
    }
    
    // 鑑定するボタンを押したとき　　入力の確認
    @IBAction func touchDownbtnAppraise(_ sender: AnyObject) {
        // 名前欄のTextFieldの確認
        if (firstNameTextField.text!.isEmpty ||
            secondNameTextField.text!.isEmpty) {
            print("nameTextField.text is enpty.")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgNameEmpty,
                preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            if !firstNameTextField.text!.ChackHiraganaOrKatakana() ||
               !secondNameTextField.text!.ChackHiraganaOrKatakana() {
                print("nameTextField.text is not hiragana or katakana.")
                let alertController = UIAlertController(
                    title: Const.ErrorTitle,
                    message: Const.ErrorMsgNameKana,
                    preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: Const.BtnOK, style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
        }
        
        // 誕生日欄のTextFieldの確認
        if (firstDateTextField.text!.isEmpty ||
            secondDateTextField.text!.isEmpty) {
            print("DateTextField.text is not hiragana.")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgDate,
                preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
        // 性別選択の確認
        if (firstSgCtlSex.selectedSegmentIndex == -1 ||
            secondSgCtlSex.selectedSegmentIndex == -1 ) {
            print("SgCtlSex.selectedSegmentIndex == -1")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgSex,
                preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }

        // この判定が終わったら、次の画面に遷移する
        
        // NSUserDefaultsオブジェクトを取得し、設定情報を保存する
        let defaults = UserDefaults.standard
        defaults.set(firstNameTextField.text, forKey: Const.FirstUserName)
        defaults.set(firstDateTextField.text, forKey: Const.FirstBirthday)
        defaults.set(firstSgCtlSex.selectedSegmentIndex, forKey: Const.FirstSex)
        defaults.set(secondNameTextField.text, forKey: Const.SecondUserName)
        defaults.set(secondDateTextField.text, forKey: Const.SecondBirthday)
        defaults.set(secondSgCtlSex.selectedSegmentIndex, forKey: Const.SecondSex)
        defaults.synchronize()
    }

/*  // scrollviewを使った場合は、このイベントはこない
    // 画面の適当なところをタッチした時、キーボードを隠す
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        print("close keyboard")
        firstNameTextField.resignFirstResponder()
        firstDateTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        secondDateTextField.resignFirstResponder()
    }
*/
    // scrollviewを使った場合は、こちらでタップを検知したときの処理となる
    func singleTap(_ gesture: UITapGestureRecognizer) -> Void {
        print("tapped")
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
    func format(_ date : Date, style : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = style
        return  dateFormatter.string(from: date)
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
