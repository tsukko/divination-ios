//
//  A2ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit
import MessageUI

class A2ViewController : UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var image_back: UIImageView!
//    @IBOutlet weak var btnConsultation: UIButton!
    @IBOutlet weak var btnReceiveMail: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    
    /// 画面遷移時に渡す為の値
    var _param:Int = -1
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("A2ViewController viewDidLoad")
        
        // バック画像の設定
        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue")!)

        naviBar.setBackgroundImage(UIImage(named: "component_01_header2"), forBarPosition: .TopAttached, barMetrics: .Default)

        if _second == 0  {
            // 鑑定術とは？を押した時
            image_back.image = UIImage(named: "page_01_whats_Katakamuna")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 1  {
            // プロフィールを押した時
            image_back.image = UIImage(named: "page_04_appraisers_profile")
            btnReceiveMail.hidden = true
//            btnConsultation.hidden = false
        } else if _second == 2  {
            // 相談を押した時
            image_back.image = UIImage(named: "page_07_kanteiirai")
            btnReceiveMail.hidden = false
//            btnConsultation.hidden = true
        } else {
            // その他
            image_back.image = UIImage(named: "page_02_free_appraisal")
            btnReceiveMail.hidden = false
//            btnConsultation.hidden = false
        }
        
    }
    
    // 相談ボタンを押した時
    @IBAction func touchDownBtnConsultation(sender: AnyObject) {
        _param = 2
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
    
    @IBAction func touchDownSendMailBtn(sender: AnyObject) {
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            NSLog("Email Send Failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients = ["to@1gmail.com"]
        let CcRecipients = ["cc@1gmail.com","Cc2@1gmail.com"]
        let BccRecipients = ["Bcc@1gmail.com","Bcc2@1gmail.com"]
        
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("メールの件名")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients) //Ccアドレスの表示
        mailViewController.setBccRecipients(BccRecipients) //Bccアドレスの表示
        mailViewController.setMessageBody("メールの本文", isHTML: false)
        
        self.presentViewController(mailViewController, animated: true, completion: nil)
    
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            NSLog("Email Send Cancelled")
            break
        case MFMailComposeResultSaved.rawValue:
            NSLog("Email Saved as a Draft")
            break
        case MFMailComposeResultSent.rawValue:
            NSLog("Email Sent Successfully")
            break
        case MFMailComposeResultFailed.rawValue:
            NSLog("Email Send Failed")
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
