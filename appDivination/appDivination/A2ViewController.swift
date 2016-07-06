//
//  A2ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit
import MessageUI

/*
 * 一枚絵画面
 * 遷移先
 * 　池田先生に相談する
 * 　戻る（略）
 * 遷移元
 * 　トップ画面　　　　　　　　　　　→　鑑定士プロフィール
 * 　トップ画面　　　　　　　　　　　→　音霊鑑定術とは？
 * 　無料言霊鑑定入力・結果　　　　　→　池田先生の説明を聞く(説明ページ＿音霊鑑定)
 * 　今日のつぶやき入力・結果　　　　→　池田先生の説明を聞く(説明ページ＿今日のつぶやき)
 * 　相性診断入力・結果　　　　　　　→　池田先生の説明を聞く(説明ページ＿相性診断)
 * 　命名術入力・結果　　　　　　　　→　池田先生の説明を聞く(説明ページ＿命名術)
 * 　一枚絵ページ全部（相談する以外）→　池田先生に相談する
 */
 // TODO バックキーでの戻りを何とかする
class A2ViewController : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var image_back: UIImageView!
//    @IBOutlet weak var btnConsultation: UIButton!
    @IBOutlet weak var btnReceiveMail: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    
    // _paramと_secondはまとめられる？
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
        print("A2ViewController viewDidLoad")
        
        naviBar.setBackgroundImage(UIImage(named: "component_01_header2"), forBarPosition: .TopAttached, barMetrics: .Default)

        if _second == 0  {
            // 鑑定士プロフィールを押した時
            image_back.image = UIImage(named: "説明ページ＿先生プロフ")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 1  {
            // 音霊鑑定術とは？を押した時
            image_back.image = UIImage(named: "説明ページ＿カタカムナとは？")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 2  {
            // 池田先生の説明を聞く(説明ページ＿音霊鑑定)
            image_back.image = UIImage(named: "説明ページ＿音霊鑑定")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 3  {
            // 池田先生の説明を聞く(説明ページ＿今日のつぶやき)を押した時
            image_back.image = UIImage(named: "説明ページ＿今日のつぶやき")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 4  {
            // 池田先生の説明を聞く(説明ページ＿相性診断)を押した時
            image_back.image = UIImage(named: "説明ページ＿相性診断")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 5  {
            // 池田先生の説明を聞く(説明ページ＿命名術)を押した時
            image_back.image = UIImage(named: "説明ページ＿命名術")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 6  {
            // 池田先生に相談するを押した時
            image_back.image = UIImage(named: "ページ_鑑定依頼")
            btnReceiveMail.hidden = false
//            btnConsultation.hidden = true
        }  else {
            // その他　ここはこない
        }
    }
    
    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
    //    _param = 6
        performSegueWithIdentifier("segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            // ここでは、一枚絵ページから、相談する一枚絵ページ（_second = 6）に遷移するための処理
            let secondViewController:A2ViewController = segue.destinationViewController as! A2ViewController
            secondViewController._second = 6
            secondViewController._param = _param
            secondViewController._paramOriginal = _paramOriginal
        }
    }

    // TODO 戻るボタンを押したときの遷移をつくる
    // もし、今表示しているページが相談するページ（_second = 6）なら、_paramのページに戻って
    // それ以外の場合は、遷移先ページ（_paramOriginal）に戻る
    
    
    // メーラー起動（相談する一枚絵ページのみに表示）
    @IBAction func touchDownSendMailBtn(sender: AnyObject) {
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }

        let mailViewController = MFMailComposeViewController()
        let toRecipients = ["otodamakantei@gmail.com"]

        mailViewController.mailComposeDelegate = self
        // メール件名
        mailViewController.setSubject("")
        // Toアドレスの表示
        mailViewController.setToRecipients(toRecipients)
        // メール本文
        mailViewController.setMessageBody("件名・本文を変更せずに、このまま送信してください。鑑定についての詳細を返信致します。", isHTML: false)
        
        self.presentViewController(mailViewController, animated: true, completion: nil)
    }

    // メールキャンセル
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Email Send Cancelled")
            break
        case MFMailComposeResultSaved.rawValue:
            print("Email Saved as a Draft")
            break
        case MFMailComposeResultSent.rawValue:
            print("Email Sent Successfully")
            break
        case MFMailComposeResultFailed.rawValue:
            print("Email Send Failed")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
