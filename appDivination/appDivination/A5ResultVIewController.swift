//
//  A5ResultViewController.swift
//  appDivination
//
//  Created by nt on 2015/12/22.
//  Copyright © 2015年 nt. All rights reserved.
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
    
    @IBOutlet weak var lblScore: UILabel!

    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A5ViewConNum
    // 画面遷移時に遷移元が渡す遷移先の値
    var _param:Int = -1
    // 画面遷移時に遷移元が渡す遷移元の値
    var _paramOriginal:Int = -1
    // 画面遷移時に遷移先が受け取る遷移先の値
    var _second:Int = 0

    var userNameList:[String] = []
    var plotResultList:[[Int]] = [[Int]]()

    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A5ResultViewController viewDidLoad")

        // 保存していた情報の復元
        let defaults = UserDefaults.standard
        if let userNameList = defaults.object(forKey: Const.UserNameList) as? [String] {
            print("userNameList:\(userNameList)")
            let retDivination = resultDivinationClass()
            for indexStr in userNameList {
                //let userName = userNameList[0]
                if let plotResult:[Int] = retDivination.divinationReturnResult(userName: indexStr) {
                    plotResultList.append(plotResult)
                }
            }
            //print("userList is not nil")
            // 点数のセット、マイナス時は青字、１００点以上は赤字
            if !plotResultList.isEmpty {
                let score = retDivination.getCompatibilityScore(plotResultList)
                let scoreInt:Int! = Int(NumberFormatter().number(from: score)!)
                let scoreLength = score.characters.count
                var scoreColor = UIColor.black
                
                if scoreInt >= 100 {
                    scoreColor = UIColor.red
                } else if scoreInt < 0 {
                    scoreColor = UIColor.blue
                }
                let attrText = NSMutableAttributedString(string: score + " 点")
                attrText.addAttribute(NSForegroundColorAttributeName,
                                      value: scoreColor,
                                      range: NSMakeRange(0, scoreLength))
                attrText.addAttribute(NSFontAttributeName,
                                      value: UIFont(name: "Helvetica Neue", size: 52.0)!,
                                      range: NSMakeRange(0, scoreLength))
                lblScore.attributedText = attrText
            }
        }
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
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

