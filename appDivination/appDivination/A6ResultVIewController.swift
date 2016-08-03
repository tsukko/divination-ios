//
//  A6ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 命名術結果画面
 * 遷移先
 * 　池田先生の説明を聞く(説明ページ＿命名術)
 * 　戻る（略）
 * 遷移元
 * 　命名術アニメーション画面
 * 　トップ画面（右下のボタン）
 */
class A6ResultViewController : UIViewController {
    
    @IBOutlet weak var lblName1: UILabel!
    @IBOutlet weak var lblName2: UILabel!
    @IBOutlet weak var lblResult: UILabel!

    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A6ViewConNum
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
        print("A6ResultViewController viewDidLoad")

        // 保存していた情報の復元
        let defaults = NSUserDefaults.standardUserDefaults()
        let retDivination = resultDivinationClass()
        var firstPlotResult:[Int] = []
        var secondPlotResult:[Int] = []
        if let firstName = defaults.stringForKey(Const.FirstUserName) {
            firstPlotResult = retDivination.divinationReturnResult(firstName)
            lblName1.text = "父： " + firstName
        }
        if let secondName = defaults.stringForKey(Const.SecondUserName) {
            secondPlotResult = retDivination.divinationReturnResult(secondName)
            lblName1.text = "母： " + secondName
        }
        
        lblResult.text = retDivination.getNaming(firstPlotResult, secondPlotData: secondPlotResult)
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
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

