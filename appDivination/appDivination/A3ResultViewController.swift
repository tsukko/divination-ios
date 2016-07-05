//
//  A3ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A3ResultViewController : UIViewController {
    
//    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var resultScrollView: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var resultBackImage: UIImageView!
    @IBOutlet weak var CircleImageView1: UIImageView!
    @IBOutlet weak var CircleImageView2: UIImageView!
    @IBOutlet weak var CircleImageView3: UIImageView!
    @IBOutlet weak var CircleImageView4: UIImageView!
    @IBOutlet weak var CircleImageView5: UIImageView!
    @IBOutlet weak var CircleImageView6: UIImageView!
    @IBOutlet weak var CircleImageView7: UIImageView!
    @IBOutlet weak var CircleImageView8: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var lblTitleRare: UILabel!
    @IBOutlet weak var lblMessageRare: UILabel!
    @IBOutlet weak var lblTitleLatter: UILabel!
    @IBOutlet weak var lblMessageLatter: UILabel!
    @IBOutlet weak var lblTitleLuckyWord: UILabel!
    @IBOutlet weak var lblMessageLuckyWord: UILabel!
    
    @IBOutlet weak var labelHeightConstraintRare: NSLayoutConstraint!
    
    var img: [UIImage] = [
        UIImage(named:"maru1")!,
        UIImage(named:"maru2")!,
        UIImage(named:"maru3")!,
        UIImage(named:"maru4")!,
        UIImage(named:"maru5")!,
        UIImage(named:"maru6")!]
    var imageView01: [UIImageView?] = []
    
    /// 画面遷移時に渡す為の値
    var _param:Int = -1
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    
    // 前半メッセージ、後半メッセージ、運気のあがある言葉の３種類
    var _messageAAA:String = ""
    var _message:String = "b"
    var _messageUnki:String = "b"
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A3ResultViewController viewDidLoad msg: \(_message)")
        
        // バック画像の設定
//        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue")!)
        
        // 占い結果を取得
        let defaults = NSUserDefaults.standardUserDefaults()
        let plotResult:[Int] = (defaults.objectForKey("plotResult") as? [Int])!
        
        // 占い結果の円の表示
        displayCycle(plotResult)
        
        let retDivination = resultDivinationClass()
        // レア言霊
        lblMessageRare.text = retDivination.getMessagRare(plotResult)
        if lblMessageRare.text!.isEmpty {
            lblMessageRare.hidden = true
            lblTitleRare.hidden = true
            labelHeightConstraintRare.constant = -20
        } else {
            lblMessageRare.hidden = false
            lblTitleRare.hidden = false
            labelHeightConstraintRare.constant = 10
        }
        // あなたの特性の表示
        lblMessageLatter.text = retDivination.getMessageLatter(plotResult)
        
        // 運気を上げる文言の表示
        lblMessageLuckyWord.text = retDivination.getMessageLuckyWord(plotResult)
        
        //ここで変更しても反映されない
        //changeLayout();
    }
    
    // 画面が表示された直後
    override func viewDidAppear(animated:Bool) {
        changeLayout();
    }
    
    func changeLayout(){
        // 行数無制限
        lblMessageLatter.numberOfLines = 0
        // サイズを自動調整
        lblMessageLatter.sizeToFit()
        
        let height = CGRectGetHeight(lblMessageLatter.frame)
        let width = CGRectGetWidth(lblMessageLatter.frame)
        print("ラベルの高さ:\(height) 幅:\(width)")
        
        // ボタンの位置取得
        let midX = CGRectGetMidX(lblMessageLatter.frame)
        let midY = CGRectGetMidY(lblMessageLatter.frame)
        print("ボタンの中心のX座業:\(midX) Y座標:\(midY)")
        
        let newContentHeight = height+midY-80
        
        let SVSize = resultScrollView.frame.size
        self.resultScrollView.contentSize = CGSizeMake(SVSize.width, newContentHeight);
        resultBackImage.frame = CGRectMake(0, 0, resultBackImage.frame.width, newContentHeight)
        
        //scroll画面の初期位置
        resultScrollView.contentOffset = CGPointMake(0, 0);
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
        }
    }
    
    // 占い結果の円の表示
    func displayCycle(plotResult:[Int]) {
        // UIImageViewにUIIimageを追加
        imageView01 = [
            CircleImageView1,
            CircleImageView2,
            CircleImageView3,
            CircleImageView4,
            CircleImageView5,
            CircleImageView6,
            CircleImageView7,
            CircleImageView8]
        
        for index in 0...7 {
            imageView01[index]!.hidden = false
            if (plotResult[index]==0) {
                // 0の場合は、円の画像は表示しない
                imageView01[index]!.hidden = true
            } else if (plotResult[index]>=1 && plotResult[index]<=6) {
                // 1〜6までの時は、画像を表示
                imageView01[index]!.image = img[plotResult[index]-1]
            } else {
                // TODO 7以上は、数字を表示
                
            }
        }
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

