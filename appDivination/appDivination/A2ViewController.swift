//
//  A2ViewController.swift
//  appDivination
//
//  Created by Norizou on 2015/12/22.
//  Copyright © 2015年 Nori. All rights reserved.
//

import UIKit

class A2ViewController : UIViewController {
    
    /// 遷移時の受け取り用の変数
    var _second:Int = 0
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var image_back: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    /**
     インスタンス化された直後（初回に一度のみ）
     viewDiDLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("A2ViewController viewDidLoad")
        
        // バック画像の設定
        viewBack.backgroundColor = UIColor(patternImage: UIImage(named: "backimg_blue.png")!)
        
        if _second == 0  {
            // 鑑定術とは？を押した時
            image_back.image = UIImage(named: "page_01_whats_Katakamuna.png")
        } else if _second == 1  {
            // プロフィールを押した時
            image_back.image = UIImage(named: "page_04_appraisers_profile.png")
        } else {
            // その他
            image_back.image = UIImage(named: "page_02_free_appraisal.png")
        }
        
    }
    
    /**
     memoryWarnig
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
