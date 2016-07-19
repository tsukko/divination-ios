//
//  A5ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 相性診断結果画面
 * 遷移先
 * 　池田先生の説明を聞く(説明ページ＿相性診断)
 * 　戻る（略）
 * 遷移元
 * 　相性診断アニメーション画面
 * 　トップ画面（右下のボタン）
 */
class A5ResultViewController : UIViewController {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!

    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A5ViewConNum
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    var userNameList:[String] = []
    var plotResultList:[[Int]] = [[]]

    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A5ResultViewController viewDidLoad")

        // 保存していた情報の復元
        // TODO 誕生日や性別の情報も保存・復元したほうがいいかも
        let defaults = NSUserDefaults.standardUserDefaults()
        if let temp = defaults.objectForKey(Const.UserNameList) as? [String] {
            userNameList = temp
            print("userList is not nil")
        }

        let retDivination = resultDivinationClass()
  //      for indexStr in userNameList {
            let userName = userNameList[0]
            let plotResult:[Int] = retDivination.divinationReturnResult(userName)
            plotResultList.append(plotResult)
   //     }

        // 点数のセット
        lblMessage.text = retDivination.getCompatibilityScore(plotResultList)
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

