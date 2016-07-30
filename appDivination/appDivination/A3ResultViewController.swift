//
//  A3ResultViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

/*
 * 無料言霊鑑定結果画面
 * 遷移先
 * 　池田先生の説明を聞く(説明ページ＿音霊鑑定)
 * 　戻る（略）
 * 遷移元
 * 　無料言霊鑑定アニメーション画面
 * 　トップ画面（右下のボタン）
 */
class A3ResultViewController : UIViewController {
    
    @IBOutlet weak var resultScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resultBackImage: UIImageView!
    @IBOutlet weak var CircleImageView1: UIImageView!
    @IBOutlet weak var CircleImageView2: UIImageView!
    @IBOutlet weak var CircleImageView3: UIImageView!
    @IBOutlet weak var CircleImageView4: UIImageView!
    @IBOutlet weak var CircleImageView5: UIImageView!
    @IBOutlet weak var CircleImageView6: UIImageView!
    @IBOutlet weak var CircleImageView7: UIImageView!
    @IBOutlet weak var CircleImageView8: UIImageView!

    // レア音霊、あなたの特性、運気を上げる文言のタイトルとメッセージ表示部
    @IBOutlet weak var lblTitleRare: UILabel!
    @IBOutlet weak var lblMessageRare: UILabel!
    @IBOutlet weak var lblTitleLatter: UILabel!
    @IBOutlet weak var lblMessageLatter: UILabel!
    @IBOutlet weak var lblTitleLuckyWord: UILabel!
    @IBOutlet weak var lblMessageLuckyWord: UILabel!
    
    // レア音霊が非表示となったときに高さをつめるための定義
    @IBOutlet weak var labelHeightConstraintRare: NSLayoutConstraint!
    
    var img: [UIImage] = [
        UIImage(named:"maru1")!,
        UIImage(named:"maru2")!,
        UIImage(named:"maru3")!,
        UIImage(named:"maru4")!,
        UIImage(named:"maru5")!,
        UIImage(named:"maru6")!]
    var imageView01: [UIImageView?] = []
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A3ViewConNum
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
        print("A3ResultViewController viewDidLoad")

        // 占い結果を取得、無料言霊鑑定アニメーション画面で保存している
        let defaults = NSUserDefaults.standardUserDefaults()
        let userName = defaults.stringForKey(Const.UserName)!
        
        // 占いの実行
        let retDivination = resultDivinationClass()
        let plotResult:[Int] = retDivination.divinationReturnResult(userName)
        
        // 占い結果の円の表示
        displayCycle(plotResult)
        
        // レア言霊
        lblMessageRare.text = retDivination.getMessagRare(plotResult)
        if lblMessageRare.text!.isEmpty {
            lblMessageRare.hidden = true
            lblTitleRare.hidden = true
            // -30にしているのは見た目を合わせるため。TitleとMessageのView間の高さ（それぞれ15,5だけど30引いた方がいい感じだった。。。）
            labelHeightConstraintRare.constant = -30
        } else {
            lblMessageRare.hidden = false
            lblTitleRare.hidden = false
            labelHeightConstraintRare.constant = 20
        }
        // あなたの特性の表示
        lblMessageLatter.text = retDivination.getMessageLatter(plotResult)
        
        // 運気を上げる文言の表示
        lblMessageLuckyWord.text = retDivination.getMessageLuckyWord(plotResult)
        
        //ここで変更しても反映されない
        //changeLayout();
    }

    override func viewWillAppear(animated:Bool) {
        changeLayout();
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
        
        // -40にしているのは見た目を合わせるため
        let newContentHeight = height+midY-40
        
        // TODO contentViewの方がよかったりする？？？？？
        let SVSize = resultScrollView.frame.size
        self.resultScrollView.contentSize = CGSizeMake(SVSize.width, newContentHeight);
        resultBackImage.frame = CGRectMake(0, 0, resultBackImage.frame.width, newContentHeight)
        
        //scroll画面の初期位置
        resultScrollView.contentOffset = CGPointMake(0, 0);
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
                // TODO 7以上は、数字を表示、ひとまず最大を表示
                imageView01[index]!.image = img[5]
            }
        }
    }
    
    // 画像とテキストを合成する
    func drawText(image :UIImage) ->UIImage {
        let text = "Some text.."

        let font = UIFont.boldSystemFontOfSize(32)
        let imageRect = CGRectMake(0,0,image.size.width,image.size.height)

        UIGraphicsBeginImageContext(image.size);

        image.drawInRect(imageRect)

        let textRect  = CGRectMake(5, 5, image.size.width - 5, image.size.height - 5)
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName: textStyle
        ]
        text.drawInRect(textRect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext()

        return newImage
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

