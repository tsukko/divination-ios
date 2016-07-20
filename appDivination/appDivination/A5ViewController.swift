//
//  A5ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 相性診断入力画面
 * 遷移先
 * 　鑑定する（相性診断アニメーション画面）
 * 　池田先生の説明を聞く(説明ページ＿相性診断)
 * 　戻る（略）
 * 遷移元
 * 　トップ画面

相性診断計算方法

～加算～

条件１　丸がない場所が他の人の余った丸で１箇所うまるごとに　＋２
　　　　（ただし、他の人の丸は一度しか使用できない）
★　　　12345678
　　 A:[12011201]
　　 B:[21211031]
　加算:[00100110]　→　3,6,7番目が該当する、6点、　and＆not　のような
　結果:[33222232]
　余り:[11000010]　→プラスして、全部2を引く
　　 C:[00112011]
　加算:[11000000]　→　1,2番目が該当する、4点、Cに対して0から1になったもの
　結果:[11112021]
　余り:[00001010]　→プラスして、全部1を引く

条件２　両端に丸がないラインが他の人の余った丸でうまったとき　＋２
　　　　（埋まるのが１箇所でも２箇所でも＋２　他の人の丸は一度しか使用できない）
　　　　（複数人鑑定の場合で、両端に丸のない同位置のラインが複数本ある場合はラインの片側が埋まるように優先的に丸を振り分ける）←これがうまく伝えられないので、手書きで追記します。
★　　　12345678　→15、26、37、48の両方が0で、かつ、埋まること
　　 A:[12011201]　→　37が埋まる、2点
　　 B:[21211031]
　　 C:[00112011]　→　26が埋まる、2点
　　 →一つでもOK、理解

条件３　すべての位置が丸でうまったとき　＋８
　　　　（最初にすべての位置の丸が埋まったときに一度だけ適用）
★　　　12345678
　　 A:[12011201]
　　 B:[21211031]
　結果:[33222232]　→そろった、8点
　　 →理解

～減点A～

鑑定する人の音の鏡を全て合わせたあとに

両端に丸がないライン１本につき　－２１
丸がないところ一箇所につき　－９
★　　　12345678　→15、26、37、48の両方が0で、かつ、埋まること
　　 A:[00101020]
　　 B:[10122010]
　結果:[10223030]　→26がない、-21点　、　かつ、2,6,8番が〇なし、-9*3点
　　 →理解


～減点B～

全員分の音の鏡を合わせた丸の位置と数から以下の式で計算

a-eライン
(b+c+d)と(f+g+h)の差と
(b+2c+d)と(f+2g+h)の差を合わせて減点

b-fライン
(c+d+e)と(g+h+a)の差と
(c+2d+e)と(g+2h+a)の差を合わせて減点

c-gライン
(d+e+f)と(h+a+b)の差と
(d+2e+f)と(h+2a+b)の差を合わせて減点

d-hライン
(e+f+g)と(a+b+c)の差と
(e+2f+g)と(a+2b+c)の差を合わせて減点


計算開始時は１００点とする。
鑑定される人すべての加算Aの点数を足し、全員の音の鏡を全て重ねたあと減点Aと減点Bを計算し点数を引く。

０点以下と１００点以上が出ます。
リリース前に、点数の加減の微調整を一度だけさせて頂く予定です。

条件２　両端に丸がないラインが他の人の余った丸でうまったとき
※ほかの人の余った丸の振り分け方について（複数人鑑定の場合で、両端に丸のない同位置のラインが複数本ある場合はラインの片側が埋まるように優先的に丸を振り分けることにたいしての説明）

追記.jpgを参照してください。

余った丸を与えるときは左のいちたさんから、右のよださんにたいして順に行っていった。

ーーーーーーーーーーーーー
いちたさんと、よださんはDHラインの両端に丸がない。
にださんと、さんたさんはともにHに丸を１つ余している。
にださんのHの丸をいちたさんに与え、さんたさんのHの丸をよださんに与える。
この場合、いちたさんに与える丸は、にださんの丸でも、さんたさんの丸でも構わない。
よださんに与える丸も同様。結局は同じになる。

にださんと、よださんはAEラインの両端に丸がない。
いちたさんはAに１つ、さんたさんはEに１つ丸を余している。
いちたさんのAの丸をにださんに与え、さんたさんのEの丸をよださんに与える。
この場合、にださんに与える丸は、いちたさんの丸でもさんたさんの丸でも構わない。
よださんに与える丸も同様。結局は同じになる。

にださんと、さんたさんと、よださんはCGラインの両端に丸がない。
いちたさんはCに丸を余している。
いちたさんのCの丸を、にださんか、さんたさんか、よださんに与える。
この場合誰に与えても構わない。結局は同じになる。

いちたさんと、にださんと、さんたさんはBFラインの両端に丸がない。
よださんはBに２つ、Fに１つ丸を余している。
いちたさんはBとFに丸がないため、よださんのBとFから丸を１つずつ受け取りたいが
そうしてしまうと、にださんか、さんたさんのBFラインの片側に丸がいきわたらないので、よださんの余った丸は、いちださんと、にださんと、さんたさんに１つずつ与える。
この場合、よださんのBとFの余った３つの丸は、１つずつなら、いちたさん、にださん、さんたさんにどのように与えても構わない。結局は一緒になる。
重要なのは、複数の同じ位置の両端の丸がないラインを持つ人に対して少しでも多くのラインに片側がうまるように振り分けをすること。
よださんの余った丸を、いちたさんのBとFに与えて、にださんか、さんたさんのBFラインに丸がいかなくなってしまうことがないように振り分ける。
 
 */
class A5ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var btnAppraise: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A5ViewConNum
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    var datePicker1: UIDatePicker!
    var alert = UIAlertController()
    let dataList = Const.SexDataList

    var userNameList:[String] = []
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A5ViewController viewDidLoad", terminator: "")
        
        naviBar.setBackgroundImage(UIImage(named: "component_01_header2"), forBarPosition: .TopAttached, barMetrics: .Default)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // separatorのlineのマージンを0にする（デフォルト15）
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.layoutMargins = UIEdgeInsetsZero
        // 空のセルのセパレータは非表示とする
        self.tableView.tableFooterView = UIView()
        //tableView.layer.borderColor = UIColor.grayColor().CGColor
        //tableView.layer.borderWidth = 1
        
        // 保存していた情報の復元
        // 誕生日や性別の情報も保存・復元はおこなっていない
        let defaults = NSUserDefaults.standardUserDefaults()
        if let temp = defaults.objectForKey(Const.UserNameList) as? [String] {
            userNameList = temp
            print("userList is not nil", terminator: "")
        }
    }
    
    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = viewNumber
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)", terminator: "")
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

    // 鑑定するボタンを押したとき　　入力の確認
    @IBAction func touchDownbtnAppraise(sender: AnyObject) {
        if userNameList.isEmpty || userNameList.count == 1 {
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgDataEmpty,
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }

    // ダイアログで名前を追加するときの入力確認
    func checkInput() -> Bool {
        // 名前欄のTextFieldの確認
        if (alert.textFields![0].text!.isEmpty) {
            print("nameTextField.text is enpty.", terminator: "")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgNameEmpty,
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            return false
        } else {
            if !alert.textFields![0].text!.ChackHiraganaOrKatakana() {
                print("nameTextField.text is not hiragana or katakana.", terminator: "")
                let alertController = UIAlertController(
                    title: Const.ErrorTitle,
                    message: Const.ErrorMsgNameKana,
                    preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: Const.BtnOK, style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)
                return false
            }
        }
        
        // 誕生日欄のTextFieldの確認
        if (alert.textFields![1].text!.isEmpty) {
            print("dateTextField.text is not hiragana.", terminator: "")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgDate,
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        
        // 性別選択の確認
//        if (alert.textFields![2].selectedSegmentIndex == -1) {
        if (alert.textFields![2].text!.isEmpty) {
            print("alert.textFields![2].text!.isEmpty", terminator: "")
            let alertController = UIAlertController(
                title: Const.ErrorTitle,
                message: Const.ErrorMsgSex,
                preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: Const.BtnOK, style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }

        // 保存はセルの追加削除時に行っている
        return true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // userList項目＋追加ボタン　分の数とする
        return userNameList.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyTestCell")

        if (indexPath.row < userNameList.count) {
            cell.textLabel!.text = "\(userNameList[indexPath.row])"
            let tblBackColor: UIColor = UIColor.clearColor()
            cell.backgroundColor = tblBackColor
        } else {
            cell.textLabel!.text = Const.LblAdd
            cell.textLabel!.textAlignment = NSTextAlignment.Center
        }
        // separatorのlineのマージンを0にする（デフォルト15）
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }

    // セルの削除許可の設定
    func tableView(tableView: UITableView,canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // 削除
            userNameList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            // データの保存
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(self.userNameList, forKey: Const.UserNameList)
            defaults.synchronize()
        }
    }
    // タップした時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("indexPath.row:\(indexPath.row), testteste.count + 1 :\(userNameList.count + 1)", terminator: "")
        if (indexPath.row == userNameList.count ) {
            // ダイアログ表示
            alert = UIAlertController(title: Const.AddNameTitle, message: Const.AddNameMsg, preferredStyle: .Alert)
            let saveAction = UIAlertAction(title: Const.LblAdd, style: .Default) { (action:UIAlertAction) -> Void in
                self.alert.textFields![0].resignFirstResponder()
                self.alert.textFields![1].resignFirstResponder()
                self.alert.textFields![2].resignFirstResponder()
                if self.checkInput() {
                    // 追加
                    self.userNameList.append(self.alert.textFields![0].text!)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)

                    // データの保存
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(self.userNameList, forKey: Const.UserNameList)
                    defaults.synchronize()
                    return
                } else {
                    return
                }
            }
            
            let cancelAction = UIAlertAction(title: Const.BtnCancel, style: .Default) { (action:UIAlertAction) -> Void in
                self.alert.textFields![0].resignFirstResponder()
                self.alert.textFields![1].resignFirstResponder()
                self.alert.textFields![2].resignFirstResponder()
            }
            
            // UIAlertControllerにtextFieldを追加、UserName
            alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
                 textField.placeholder = Const.NamePlaceholder
            }
            // 誕生日のtextField
            alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
                textField.placeholder = Const.BirthdayPlaceholder
                // TODO 配置!!!!!!!!!!!!!!!!!
                textField.frame = CGRectMake(20,30,300,120)
            }
            // 性別のtextField
            alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
                textField.placeholder = Const.SexPlaceholder
            }
            
            setPickerInfo()
            
            // アクションの追加
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func setPickerInfo() {
        // 誕生日のテキストフィールドにDatePickerを表示する
       datePicker1 = UIDatePicker()
       datePicker1.addTarget(self, action: #selector(A5ViewController.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
       // 日本の日付表示形式にする、年月日の表示にする
       datePicker1.datePickerMode = UIDatePickerMode.Date
       format(datePicker1.date,style: "yyyy/MM/dd")
       datePicker1.locale = NSLocale(localeIdentifier: "ja_JP")
       // 最小値、最大値、初期値を設定
       let dateFormatter = NSDateFormatter()
       dateFormatter.dateFormat = Const.DateSetFormat
       datePicker1.minimumDate = dateFormatter.dateFromString(Const.MinDateString)
       datePicker1.maximumDate = dateFormatter.dateFromString(Const.MaxDateString)
       datePicker1.date = dateFormatter.dateFromString(Const.DefDateString)!
       alert.textFields![1].inputView = datePicker1
        
       // 性別
       let picker = UIPickerView()
       picker.delegate = self
       picker.dataSource = self
       picker.showsSelectionIndicator = true
       picker.frame = CGRectMake(0,0,self.view.bounds.width, 250.0)
       alert.textFields![2].inputView = picker

        // nameTextField の情報を受け取るための delegate を設定
        alert.textFields![0].delegate = self
    }

    // 日付Picker用 ここから
    // 日付の変更イベント
    func changedDateEvent(sender:AnyObject?){
        //        var dateSelecter:UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(datePicker1.date)
    }
    // 日付の変更
    func changeLabelDate(date:NSDate) {
        alert.textFields![1].text = format(datePicker1.date,style: Const.DateFormat)
    }
    
    // 名前の入力完了時に閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        alert.textFields![0].resignFirstResponder()
        return true
    }
    // 日付Picker用 ここまで

    // 性別用のリスト ここから
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        alert.textFields![2].text = dataList[row]
    }
    
    func cancel() {
        alert.textFields![2].text = ""
        alert.textFields![2].endEditing(true)
    }
    
    func done() {
        alert.textFields![2].endEditing(true)
    }
    // 性別用のリスト ここまで


    // 画面の適当なところをタッチした時、キーボードを隠す
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        print("close keyboard", terminator: "")
//        alert.textFields![0].resignFirstResponder()
//        alert.textFields![1].resignFirstResponder()
//        alert.textFields![2].resignFirstResponder()
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
