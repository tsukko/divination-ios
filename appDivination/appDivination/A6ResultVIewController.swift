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
    
    @IBOutlet weak var resultScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resultBackImage: UIImageView!
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
        let defaults = UserDefaults.standard
        let retDivination = resultDivinationClass()
        var firstPlotResult:[Int] = []
        var secondPlotResult:[Int] = []
        if let firstName = defaults.string(forKey: Const.FirstUserName) {
            firstPlotResult = retDivination.divinationReturnResult(userName: firstName)
            lblName1.text = "父： " + firstName
        }
        if let secondName = defaults.string(forKey: Const.SecondUserName) {
            secondPlotResult = retDivination.divinationReturnResult(userName: secondName)
            lblName2.text = "母： " + secondName
        }
        
        lblResult.text = retDivination.getNaming(firstPlotResult, secondPlotData: secondPlotResult)
        lblResult.text = lblResult.text!
    }
    
    // 画面が表示された直後
    override func viewDidAppear(_ animated:Bool) {
        changeLayout();
    }

    func changeLayout(){
        // レイアウト高さ設定
        // 行数無制限
        lblResult.numberOfLines = 0
        // サイズを自動調整
        lblResult.sizeToFit()
        
        let height = lblResult.frame.height
        let width = lblResult.frame.width
        print("ラベルの高さ:\(height) 幅:\(width)")
        
        // ラベルの位置取得
        //let midX = CGRectGetMidX(lblResult.frame)
        //let midY = CGRectGetMidY(lblResult.frame)
        //print("ラベルの中心のX座業:\(midX) Y座標:\(midY)")
        
        // -40にしているのは見た目を合わせるため
        let newContentHeight = height+1020
        
        // TODO contentViewの方がよかったりする？？？？？
        let SVSize = resultScrollView.frame.size
        self.resultScrollView.contentSize = CGSize(width: SVSize.width, height: newContentHeight);
        resultBackImage.frame = CGRect(x: 0, y: 0, width: resultBackImage.frame.width, height: newContentHeight)
        
        //scroll画面の初期位置
        resultScrollView.contentOffset = CGPoint(x: 0, y: 0);
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

