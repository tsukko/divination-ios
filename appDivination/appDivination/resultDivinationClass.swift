//
//  resultDivination.swift
//  appDivination
//
//  Created by Norizou on 2016/01/06.
//  Copyright © 2016年 Nori. All rights reserved.
//

import UIKit

class resultDivinationClass {
    var retDivination = [resultDivination]()
    
    struct resultDivination {
        var index: [String!]
        var message: [String!]
        var fortuneWord: [String!]
        func toDictionary() -> [String: [String!]] {
            return [
                "index" : index,
                "message" : message,
                "fortuneWord" : fortuneWord,
            ]
        }
    }
    
    // イニシャライザ
    init() {
        initialResultDivination()
    }
    
    // structの中身の定義
    func initialResultDivination() {
        // 01. 基本
        retDivination.append(resultDivination(
            index: ["0"],
            message: [
                "一般的な常識の型にはまると上手くいきません。\n",
                "基本的な事をすぐに身に付ける能力を持っています。\n",
                "資格やライセンスなどを取得したり、マニュアルなどを理解する能力がとても高いです。\n"],
            fortuneWord: ["ア", "カ", "ヒ", "レ"]))
        // 02. 努力
        retDivination.append(resultDivination(
            index: ["1"],
            message: [
                "努力が実りづらいので、自分の好きなことをしていた方がいい結果がでます。\n",
                "努力を積み重ねることで運気が上がっていきます。\n",
                "コツコツと努力を積み重ねることで大きな成功に導かれます。\n"],
            fortuneWord: ["ク", "フ", "ヱ"]))
        // 03. 身に付ける
        retDivination.append(resultDivination(
            index: ["2"],
            message: [
                "何かの技術や知識を習得するのに苦労するタイプです。\n",
                "知識や技術を習得することが上手です。\n",
                "本気になったら身につけられないことはほとんどないでしょう。\n"],
            fortuneWord: ["ウ", "チ", "ミ", "ラ"]))
        // 04. 伝える
        retDivination.append(resultDivination(
            index: ["3"],
            message: [
                "周囲に情報や意見を上手に伝えるのが苦手で、勘違いされやすいです。\n",
                "周囲に何かを伝えていくことが上手です。\n",
                "伝えたい情報や意見を、広く遠く沢山の人々に伝えることができます。\n"],
            fortuneWord: ["ヘ", "ユ", "ヨ", "ヲ"]))
        // 05. 世に出す
        retDivination.append(resultDivination(
            index: ["4"],
            message: [
                "あなたの持つ才能や意見はなかなか世に認められません。\n",
                "何かを世の中に生み出す能力を持っています。\n",
                "プロデューサー向きで、人や物を世に輩出する才能にたけています。\n"],
            fortuneWord: ["イ", "シ", "ソ", "ン"]))
        // 06. 淋しい
        retDivination.append(resultDivination(
            index: ["5"],
            message: [
                "仲間や家族を求めていても、気付けばいつも一人寂しくいます。\n",
                "友達作りが上手で、家族とのトラブルも少ないでしょう。\n",
                "沢山の仲間に恵まれ、沢山の子宝に恵まれたり大家族になります。\n"],
            fortuneWord: ["オ", "ム"]))
        // 07. 成し遂げる
        retDivination.append(resultDivination(
            index: ["6"],
            message: [
                "優柔不断で、なにかとタイミングが悪いことが多いです。\n",
                "何かを達成したければ、自分が納得するまで追求すれば結果に結びつくでしょう。\n",
                "持ち前のド根性でとことん突き進めば、どんなことでも成し遂げる事ができます。\n"],
            fortuneWord: ["ナ", "ニ"]))
        // 08. 仕上げる
        retDivination.append(resultDivination(
            index: ["7"],
            message: [
                "思い描いた結果がでないことばかりです。\n",
                "イメージ通りの状態に整えて仕上げていく能力をもっています。\n",
                "記録をつくったり賞を取ったり、何かを達成する能力がとても高いです。\n"],
            fortuneWord: ["ヌ", "ス", "ヤ"]))
//        print(retDivination)
    }

    // 占った結果をNSUserDefaultsで保存
    func divination() {
        var userName:String = ""
        // 名前は、NSUserDefaultsに保存したのを読み出す
        // NSUserDefaultsオブジェクトを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        // すでに名前が設定されていたら今日の運勢を行うボタンを表示する
        if let _ = defaults.stringForKey("userName") {
            // NSUserDefaultsに格納された値を取得
            userName = defaults.stringForKey("userName")!
//            print("divination userName:\(userName)")

            var plotResult:[Int] = [0,0,0,0,0,0,0,0]
            plotResult = divinationReturnResult(userName)
            
            // プロットの結果を保存、無料言霊鑑定結果画面
            defaults.setObject(plotResult, forKey: "plotResult")
            defaults.synchronize()
            print("divination plotResult : \(plotResult)")
        }
    }
    
    // 占った結果をInt配列で返却
    func divinationReturnResult(userName:String) -> Array<Int> {
        let characters = userName.characters.map { String($0) }

        let kanaData = kanaDataClass()
        var plotResult:[Int] = [0,0,0,0,0,0,0,0]

        // ここで文字を１文字づつ繰り返し処理
        for v in characters {
            for c in v.unicodeScalars {
                if (c.value >= 0x3041 && c.value <= 0x3096) ||
                   (c.value >= 0x30A1 && c.value <= 0x30F6) ||
                   c.value == 0x0020 || c.value == 0xFF5A {
                    print("ChackHiragana OK: \(v) : \(c.value)")
                    let s = NSString(format:"%2X", c.value) as String
                    var test:[String!] = kanaData.getPlotData("0x" + s)
                    for i in 0...7 {
                        plotResult[i] += Int(test[i])!
                    }
                } else {
                    // ここに来るまでに判定しているので、ここは通らない想定
                    print("ChackHiragana NG")
                    break
                }
            }
        }
        return plotResult
    }

    // レア言霊の出力判定、
    // 表示する文を返す。レアではない場合はnullを返す
    func getMessagRare(plotData:[Int]) -> String {
        let type: Int = getTypeRare(plotData)
        if type == 1 {
            return "この世に必要な音の響きの全てを持って誕生したあなた。\n皆に分け与え、繋ないでいく役目を持っています。\nただ、すべてを持ち合わせるためか、なかなか個性が見えづらい部分があります。"
        } else if type == 3 {
            return "あなたは、なんの使命もたずに生れ出た特殊な存在です。\n五感で感じるこの世には、まるで無のような存在です。\nもしかすると別の次元において大きな意味を持つ、特別な存在なのかもしれません。"
        } else if type == 2 {
            return "攻撃と防御を最大限に使うことが出来る、とても強い特殊な言霊です。\nただし、いつも張り詰めていて、ゆるみを持っていないため、常に戦い続けなければならない特性を持ち合わせています。"
        } else {
            return ""
        }
    }
    
    // レア言霊かどうか、タイプを判定する。-1はレアではないことを示す
    func getTypeRare(plotData:[Int]) -> Int {
        var flagYatanokagami: Int = 0
        var flagHutomani: Bool = true
        var flagMikumari: Int = 0
        for i in 0...7 {
            if plotData[i] > 0 {
                flagYatanokagami += 1
            } else {
                flagMikumari += 1
            }
        }
        
        // 01. ヤタノカガミ： 全てのプロット位置に丸がつく
        if flagYatanokagami == 8 {
            return 1
        }
        // 03. ミクマリ： 丸がひとつもつかない
        if flagMikumari == 8 {
            return 3
        }
        
        for i in 0...7 {
            if (i % 2 == 0) {
                // 十字の部分がどれか一つでも値がない場合はfalseを設定
                if (plotData[i] == 0) {
                    flagHutomani = false;
                }
            } else {
                // ×字の部分がどれか一つでも値がある場合はfalseを設定
                if (plotData[i] >= 1) {
                    flagHutomani = false;
                }
            }
        }
        
        // 02. フトマニ： 十字の部分にだけ丸がつく
        if flagHutomani {
            return 2
        }
        return -1
    }
    
    // 後半部分のメッセージ、特性について表示する文言の取得
    func getMessageLatter(plotData:[Int]) -> String {
        var index:Int = 0
        var msgTotal:String = ""
        for msg in retDivination {
            if plotData[index] >= 3 {
                msgTotal += "・" + msg.message[2]
            } else if plotData[index] < 3 && plotData[index] >= 1 {
                msgTotal += "・" + msg.message[1]
            } else  {
                msgTotal += "・" + msg.message[0]
            }
            index += 1
        }
        
        return msgTotal
    }
    
    // 運気を上げる文言の取得、
    // TODO 上と共通部分を抜き出したい
    func getMessageLuckyWord(plotData:[Int]) -> String {
        let type: Int = getTypeRare(plotData)
        if type == 1 {
            return "５０音すべて。"
        } else if type == 3 {
            return "５０音すべて。"
        } else if type == 2 {
            return "ネ"
        } else {
            var index:Int = 0
            var unkiIndex:Int = 0
            var fortuneWordTotal:String = ""
            for msg in retDivination {
                if plotData[index] >= 3 {
                } else if plotData[index] < 3 && plotData[index] >= 1 {
                } else  {
                    // 運気を上げる言葉をランダムで取得する
                    let randInt = Int(arc4random_uniform(UInt32(msg.fortuneWord.count)))
                    if unkiIndex == 0 {
                        fortuneWordTotal += msg.fortuneWord[randInt]
                    } else {
                        fortuneWordTotal += ", " + msg.fortuneWord[randInt]
                    }
                    unkiIndex += 1
                }
                index += 1
            }
            
            return fortuneWordTotal + " など"
        }
    }
    
    // 今日のつぶやきの結果文言の取得、
    func getTodayLuckyWord(userName:String, plotData:[Int]) -> String {
        var flagYatanokagami: Int = 0
//        var flagHutomani: Bool = true
//        var flagMikumari: Int = 0
        let userNameNew: String = userName
            for i in 0...7 {
            if plotData[i] > 0 {
                flagYatanokagami += 1
            } else {
				// a: 丸が付かない場所を埋める言葉を洗い出す
				// b: その中からランダムに一文字決め、名前にその文字を足し合わせる
				// userNameNew に一文字追加
            }
        }
        
        // 全てのプロット位置に丸がつくようになると終わり
        if flagYatanokagami == 8 {
            return "埋め終えるまでに引用した全ての言葉をランダムに並び替える"
        } else {
            // c: 音の鏡を確認し、まだ丸が付いて居ない箇所があれば、aからやり直す
            getTodayLuckyWord(userNameNew, plotData: divinationReturnResult(userNameNew))
        }
        
         return "ここは来ない想定"
    }
    
    // 相性診断の結果文言の取得
	// TODO plotResultは人数分必要、getCompatibilityScoreの引数も配列で
    func getCompatibilityScore(plotData:[Int]) -> String {
    	return ""
    }
    
    // 命名術の結果文言の取得
	// TODO plotResultは2人分必要、getNamingの引数も配列で
    func getNaming(plotData:[Int]) -> String {
    	return ""
    }
}
