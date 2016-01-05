//
//  ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/11/08.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnTodayTweet: UIButton!
    
    /// 画面遷移時に渡す為の値
    var _param:Int = -1
    // ユーザー名 今日の運勢のボタンを表示するかどうか
    var userName : String = ""
    
    // インスタンス化された直後（初回に一度のみ）
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("ViewController viewDidLoad")
        
        // バック画像の設定
        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue")!)
        
        // viewにロングタップのジェスチャーを追加
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "doGesture:")
        longPressGesture.minimumPressDuration = 1.0
        self.btnTodayTweet.userInteractionEnabled = true
        self.btnTodayTweet.addGestureRecognizer(longPressGesture)
    }
    
    // 画面が表示される直前
    override func viewWillAppear(animated:Bool) {
        
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let tempUserName = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = tempUserName
            print("userName:\(userName)")
            btnTodayTweet.hidden = false
        } else {
            btnTodayTweet.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 鑑定術とは？を押した時
    @IBAction func touchDownBtnDescription(sender: AnyObject) {
        _param = 0
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // プロフィールを押した時
    @IBAction func touchDownBtnProfile(sender: AnyObject) {
        _param = 1
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        NSLog("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
        }
    }
    
    // 今日の運勢を押した時
    @IBAction func touchDownBtnTodayTweet(sender: AnyObject) {
        
    }
    
    // 今日の運勢を長押しした時
    func doGesture(sender: UILongPressGestureRecognizer) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("userName")
        defaults.removeObjectForKey("birthday")
        defaults.removeObjectForKey("sex")

        let alertController = UIAlertController(
            title: NSLocalizedString("delNameTitle", tableName: "main", comment: ""),
            message: NSLocalizedString("delNameMsg", tableName: "main", comment: ""),
            preferredStyle: .Alert)
        let defaultAction = UIAlertAction(
            title: NSLocalizedString("btnOK", tableName: "main", comment: ""),
            style: .Default,
            handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        
        btnTodayTweet.hidden = true
    }
}



