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
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!

    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値　（TODO final値）
    var _paramOriginal:Int = 5
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A6ResultViewController viewDidLoad)
  
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // TODO "音霊命名術結果"を表示

		// 命名術結果の文言のセット
		// TODO plotResultは2人分必要、getNamingの引数も配列で
		let plotResult:[Int] = (defaults.objectForKey("plotResult") as? [Int])!
		let retDivination = resultDivinationClass()
		lblMessage.text = retDivination.getNaming(plotResult)
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
        _param = 4
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = _param
            secondViewController._paramOriginal = _paramOriginal
        }
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

