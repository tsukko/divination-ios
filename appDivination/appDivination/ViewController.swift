//
//  ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/11/08.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * トップ画面
 * 遷移先
 * 　鑑定士プロフィール
 * 　音霊鑑定術とは？
 * 　池田先生の説明を聞く(説明ページ＿音霊鑑定)
 * 　池田先生の説明を聞く(説明ページ＿今日のつぶやき)
 * 　池田先生の説明を聞く(説明ページ＿相性診断)
 * 　池田先生の説明を聞く(説明ページ＿命名術)
 * 　池田先生に相談する
 * 遷移元
 * 　なし 
 */
class ViewController: UIViewController {

    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnTodayTweet: UIButton!
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.ViewConNum
    // 画面遷移時に渡す為の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // ユーザー名 今日の運勢のボタンを表示するかどうか
    var userName : String = ""
    
    // インスタンス化された直後（初回に一度のみ）
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController viewDidLoad", terminator: "")
        
        // viewにロングタップのジェスチャーを追加
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.doGesture(_:)))
        longPressGesture.minimumPressDuration = 1.0
        self.btnTodayTweet.userInteractionEnabled = true
        self.btnTodayTweet.addGestureRecognizer(longPressGesture)
    }
    
    // 画面が表示される直前
    override func viewWillAppear(animated:Bool) {
        
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let tempUserName = defaults.stringForKey(Const.UserName) {
            // NSUserDefaultsに格納された値を取得
            userName = tempUserName
            print("ViewController viewWillAppear userName:\(userName)", terminator: "")
            btnTodayTweet.hidden = false
        } else {
            btnTodayTweet.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // プロフィールを押した時
    @IBAction func touchDownBtnProfile(sender: AnyObject) {
        _param = Const.ViewNumber.A2ViewProfile
        performSegueWithIdentifier("segue",sender: nil)
    }

    // 鑑定術とは？を押した時
    @IBAction func touchDownBtnDescription(sender: AnyObject) {
        _param = Const.ViewNumber.A2ViewKatakamuna
        performSegueWithIdentifier("segue",sender: nil)
    }

    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)", terminator: "")
        if segue.identifier == "segue" {
            // 元画面を示す値_paramOriginal = 0
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = viewNumber
            secondViewController._param = _param
            secondViewController._paramOriginal = viewNumber
        }
    }
    
    // 今日の運勢を押した時
    @IBAction func touchDownBtnTodayTweet(sender: AnyObject) {
        // 無料音霊鑑定の結果ページ
    }
    
    // 裏機能。今日の運勢を長押しした時、保存されたすべてのデーターを削除する
    func doGesture(sender: UILongPressGestureRecognizer) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(Const.UserName)
        defaults.removeObjectForKey(Const.Birthday)
        defaults.removeObjectForKey(Const.Sex)
        defaults.removeObjectForKey(Const.LukcyWord)
        defaults.removeObjectForKey(Const.SaveTime)
        defaults.removeObjectForKey(Const.UserNameList)
        defaults.removeObjectForKey(Const.FirstUserName)
        defaults.removeObjectForKey(Const.FirstBirthday)
        defaults.removeObjectForKey(Const.FirstSex)
        defaults.removeObjectForKey(Const.SecondUserName)
        defaults.removeObjectForKey(Const.SecondBirthday)
        defaults.removeObjectForKey(Const.SecondSex)

        let alertController = UIAlertController(
            title: Const.DelNameTitle,
            message: Const.DelNameMsg,
            preferredStyle: .Alert)
        let defaultAction = UIAlertAction(
            title: Const.BtnOK,
            style: .Default,
            handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        
        btnTodayTweet.hidden = true
    }
}



