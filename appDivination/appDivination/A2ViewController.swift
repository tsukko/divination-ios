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
class A2ViewController : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var image_back: UIImageView!
    @IBOutlet weak var btnConsultation: UIButton!
    @IBOutlet weak var btnReceiveMail: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    
    // 画面番号、遷移元を知るために使用
    let viewNumber = Const.ViewNumber.A2ViewConNum
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
        print("A2ViewController viewDidLoad _param : \(_param) _second: \(_second)")
        
        naviBar.setBackgroundImage(UIImage(), for: .topAttached, barMetrics: .default)
        naviBar.shadowImage = UIImage()

        if _second == Const.ViewNumber.ViewConNum {
            if _param == Const.ViewNumber.A2ViewProfile  {
                // 鑑定士プロフィールを押した時
                image_back.image = UIImage(named: "説明ページ＿先生プロフ")
                btnReceiveMail.isHidden = true
                btnConsultation.isHidden = false
            } else if _param == Const.ViewNumber.A2ViewKatakamuna {
                // 音霊鑑定術とは？を押した時
                image_back.image = UIImage(named: "説明ページ＿カタカムナとは？")
                btnReceiveMail.isHidden = true
                btnConsultation.isHidden = false
            }
        } else if _second == Const.ViewNumber.A3ViewConNum  {
            // 池田先生の説明を聞く(説明ページ＿音霊鑑定)
            image_back.image = UIImage(named: "説明ページ＿音霊鑑定")
            btnReceiveMail.isHidden = true
            btnConsultation.isHidden = false
        } else if _second == Const.ViewNumber.A4ViewConNum  {
            // 池田先生の説明を聞く(説明ページ＿今日のつぶやき)を押した時
            image_back.image = UIImage(named: "説明ページ＿今日のつぶやき")
            btnReceiveMail.isHidden = true
            btnConsultation.isHidden = false
        } else if _second == Const.ViewNumber.A5ViewConNum  {
            // 池田先生の説明を聞く(説明ページ＿相性診断)を押した時
            image_back.image = UIImage(named: "説明ページ＿相性診断")
            btnReceiveMail.isHidden = true
            btnConsultation.isHidden = false
        } else if _second == Const.ViewNumber.A6ViewConNum  {
            // 池田先生の説明を聞く(説明ページ＿命名術)を押した時
            image_back.image = UIImage(named: "説明ページ＿命名術")
            btnReceiveMail.isHidden = true
            btnConsultation.isHidden = false
        } else if _second == Const.ViewNumber.A2ViewRequest  {
            // 池田先生に相談するを押した時
            image_back.image = UIImage(named: "ページ_鑑定依頼")
            btnReceiveMail.isHidden = false
            btnConsultation.isHidden = true
        }  else {
            // その他　ここはこない
        }
    }

    // 戻るボタンを押した時
    // もし、今表示しているページが相談するページ（_second = 6）なら、_paramのページに戻って
    // それ以外の場合は、遷移先ページ（_paramOriginal）に戻る
    @IBAction func touchDownBtnBack(_ sender: AnyObject) {
        // 遷移するViewを定義して、遷移してきた画面に移動する
        // 鑑定依頼ページから戻る場合は、同じA2ViewControllerに戻る
        if _second == Const.ViewNumber.A2ViewRequest  {
            let mySecondViewController:A2ViewController = self.storyboard!.instantiateViewController( withIdentifier: "A2View" ) as! A2ViewController
            mySecondViewController._second = _paramOriginal
            mySecondViewController._param = _param
            mySecondViewController._paramOriginal = _paramOriginal
            self.present(mySecondViewController, animated: true, completion: nil)
        }
        // 鑑定依頼ページ以外の一枚画像ページの場合は、遷移元ページに戻る
        if _paramOriginal == Const.ViewNumber.ViewConNum {
            let mySecondViewController = self.storyboard!.instantiateViewController( withIdentifier: "A1View" )
            self.present(mySecondViewController, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A3ViewConNum {
            let mySecondViewController = self.storyboard!.instantiateViewController( withIdentifier: "A3View" ) 
            self.present(mySecondViewController, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A4ViewConNum {
            let mySecondViewController = self.storyboard!.instantiateViewController( withIdentifier: "A4View" ) 
            self.present(mySecondViewController, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A5ViewConNum {
            let mySecondViewController = self.storyboard!.instantiateViewController( withIdentifier: "A5View" )
            self.present(mySecondViewController, animated: true, completion: nil)
        } else if _paramOriginal == Const.ViewNumber.A6ViewConNum {
            let mySecondViewController = self.storyboard!.instantiateViewController( withIdentifier: "A6View" )
            self.present(mySecondViewController, animated: true, completion: nil)
        }
    }

    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(_ sender: AnyObject) {
    //    _param = 6
        performSegue(withIdentifier: "segue",sender: nil)
    }
    
    // Segueはビューが遷移するタイミングで呼ばれるもの
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        print("prepareForSegue : \(segue.identifier), _param : \(_param)")
        if segue.identifier == "segue" {
            // ここでは、一枚絵ページから、同じViewである相談する一枚絵ページ（_second = 6）に遷移するための処理
            let secondViewController:A2ViewController = segue.destination as! A2ViewController
            secondViewController._second = Const.ViewNumber.A2ViewRequest
            secondViewController._param = _param
            secondViewController._paramOriginal = _paramOriginal
        }
    }

    // メーラー起動（相談する一枚絵ページのみに表示）
    @IBAction func touchDownSendMailBtn(_ sender: AnyObject) {
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }

        let mailViewController = MFMailComposeViewController()
        let toRecipients = [Const.MailFrom]

        mailViewController.mailComposeDelegate = self
        // メール件名
        mailViewController.setSubject(Const.MailSubject)
        // Toアドレスの表示
        mailViewController.setToRecipients(toRecipients)
        // メール本文
        mailViewController.setMessageBody(Const.MailBody, isHTML: false)
        
        self.present(mailViewController, animated: true, completion: nil)
    }

    // メールキャンセル
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Email Send Cancelled")
            break
        case MFMailComposeResult.saved.rawValue:
            print("Email Saved as a Draft")
            break
        case MFMailComposeResult.sent.rawValue:
            print("Email Sent Successfully")
            break
        case MFMailComposeResult.failed.rawValue:
            print("Email Send Failed")
            break
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
