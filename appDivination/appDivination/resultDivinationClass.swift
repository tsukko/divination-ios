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
        retDivination.append(resultDivination(index: ["0"], message: Const.free_divination_message_01, fortuneWord: Const.free_divination_fortuneWord_01))
        // 02. 努力
        retDivination.append(resultDivination(index: ["1"], message: Const.free_divination_message_02, fortuneWord: Const.free_divination_fortuneWord_02))
        // 03. 身に付ける
        retDivination.append(resultDivination(index: ["2"], message: Const.free_divination_message_03, fortuneWord: Const.free_divination_fortuneWord_03))
        // 04. 伝える
        retDivination.append(resultDivination(index: ["3"], message: Const.free_divination_message_04, fortuneWord: Const.free_divination_fortuneWord_04))
        // 05. 世に出す
        retDivination.append(resultDivination(index: ["4"], message: Const.free_divination_message_05, fortuneWord: Const.free_divination_fortuneWord_05))
        // 06. 淋しい
        retDivination.append(resultDivination(index: ["5"], message: Const.free_divination_message_06, fortuneWord: Const.free_divination_fortuneWord_06))
        // 07. 成し遂げる
        retDivination.append(resultDivination(index: ["6"], message: Const.free_divination_message_07, fortuneWord: Const.free_divination_fortuneWord_07))
        // 08. 仕上げる
        retDivination.append(resultDivination(index: ["7"], message: Const.free_divination_message_08, fortuneWord: Const.free_divination_fortuneWord_08))
    }

    // 占った結果をInt配列で返却
    func divinationReturnResult(userName:String) -> Array<Int> {
        let characters = userName.characters.map { String($0) }

        let kanaData = kanaDataClass(flagAll: true)
        var plotResult:[Int] = [0,0,0,0,0,0,0,0]

        // ここで文字を１文字づつ繰り返し処理
        for v in characters {
            for c in v.unicodeScalars {
                if (c.value >= 0x3041 && c.value <= 0x3096) ||
                   (c.value >= 0x30A1 && c.value <= 0x30F6) ||
                   c.value == 0x0020 || c.value == 0xFF5A {
                    //print("ChackHiragana OK: \(v) : \(c.value)")
                    let s = NSString(format:"%2X", c.value) as String
                    var sPlotData:[String!] = kanaData.getPlotData("0x" + s)
                    for i in 0...7 {
                        plotResult[i] += Int(sPlotData[i])!
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
        if type == Const.TypeNumYatanokagami {
            return Const.MessageYatanokagami
        } else if type == Const.TypeNumMikumari {
            return Const.MessageMikumari
        } else if type == Const.TypeNumHutomani {
            return Const.MessageHutomani
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
            return Const.TypeNumYatanokagami
        }
        // 03. ミクマリ： 丸がひとつもつかない
        if flagMikumari == 8 {
            return Const.TypeNumMikumari
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
            return Const.TypeNumHutomani
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
    
    // 運気を上げる文言の取得
    func getMessageLuckyWord(plotData:[Int]) -> String {
        let type: Int = getTypeRare(plotData)
        if type == Const.TypeNumYatanokagami {
            return Const.FortuneWordYatanokagami
        } else if type == Const.TypeNumMikumari {
            return Const.FortuneWordMikumari
        } else if type == Const.TypeNumHutomani {
            return Const.FortuneWordHutomani
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
    
    // 今日のつぶやきの結果文言の取得
    func getTodayLuckyWord(userName:String, tweetWord:String) -> String {
        let kanaData = kanaDataClass(flagAll: false)
        var newUserName = userName
        let newPlotData = divinationReturnResult(newUserName)
        
        // 01. ヤタノカガミ： 全てのプロット位置に丸がつくの場合は、一個もない人と同じ扱いにする
        if getTypeRare(newPlotData) == Const.TypeNumYatanokagami {
            newUserName = ""
        }

        return getTodayLuckyWord(newUserName, tweetWord: tweetWord, kanaData: kanaData)
    }
    
    func getTodayLuckyWord(userName:String, tweetWord:String, kanaData:kanaDataClass) -> String {
        var flagYatanokagami: Int = 0
        var newUserName: String = userName
        var lTweetWord:String = tweetWord
        let plotData = divinationReturnResult(newUserName)
        
        for i in 0...7 {
            if plotData[i] > 0 {
                flagYatanokagami += 1
            } else {
                print("plotData[\(i)] is zero.")
                // a: 丸が付かない場所を埋める言葉を洗い出す
                // b: その中からランダムに一文字決め、名前にその文字を足し合わせる
                // userNameNew に一文字追加
                let newAddWord = kanaData.getRandomCharaFromPlotData(plotData)
                print("add word :\(newAddWord)")
                lTweetWord = tweetWord + newAddWord
                newUserName = userName + newAddWord
                break
            }
        }

        // 全てのプロット位置に丸がつくようになると終わり
        if flagYatanokagami == 8 {
            var outputWord:String = ""
            var characters = lTweetWord.characters.map { String($0) }
            // 並び替える
            for _ in characters {
                let d = Int(arc4random_uniform(UInt32(characters.count)))
                outputWord = outputWord + characters.removeAtIndex(d)
            }
            print("inputWord :\(lTweetWord) -> outputWord :\(outputWord)")
            return outputWord
        } else {
            print("flagYatanokagami :\(flagYatanokagami)")
            // c: 音の鏡を確認し、まだ丸が付いて居ない箇所があれば、aからやり直す
            return getTodayLuckyWord(newUserName, tweetWord: lTweetWord, kanaData: kanaData)
        }
    }

    // 相性診断の結果文言の取得
    func getCompatibilityScore(plotDataList:[[Int]]) -> String {
        let score:Int = 100
        
        // 条件
        let scoreAddFirst:Int = getScoreAddFirst(plotDataList)
        let scoreAddSecond:Int = getScoreAddSecond(plotDataList)
        let scoreAddThird:Int = getScoreAddThird(plotDataList)
        let scoreSubFirst:Int = getScoreSubFirst(plotDataList)
        let scoreSubSecond:Int = getScoreSubSecond(plotDataList)
        
        let scoreTotal:Int = score + scoreAddFirst + scoreAddSecond + scoreAddThird + scoreSubFirst + scoreSubSecond
        return scoreTotal.description
    }

    // 加算　条件１
    func getScoreAddFirst(plotDataList:[[Int]]) -> Int {
        var score:Int = 0
        var add2Count = 0
        var amari = [0,0,0,0,0,0,0,0]
        var sPlotDataList = plotDataList

        print("\(sPlotDataList[0])")
        print("\(sPlotDataList[1])")
        // 一人目と二人目のとき
        for index in 0..<8 {
            if (0 == sPlotDataList[0][index] && 2 <= sPlotDataList[1][index]) ||
                (2 <= sPlotDataList[0][index] && 0 == sPlotDataList[1][index]) {
                add2Count = add2Count + 1
            }
            amari[index] = sPlotDataList[0][index] + sPlotDataList[1][index] - 2
            if amari[index] < 0 {
                amari[index] = 0
            }
        }

        print("1:add2Count=\(add2Count), amari=\(amari)")

        // 次でfor文でまわすで計算した一人目二人目を削除
        sPlotDataList.removeFirst()
        sPlotDataList.removeFirst()

        for plotDataTMP in sPlotDataList {
            print("plotDataTMP =\(plotDataTMP)")
            // 3人目以降
            for index in 0..<8 {
                var subPoint = 0
                var addPoint = 0
                if 0 == plotDataTMP[index] && amari[index] != 0 {
                    add2Count = add2Count + 1
                    subPoint = 1
                }
                if 2 <= plotDataTMP[index] {
                    addPoint = plotDataTMP[index] - 1
                }
                amari[index] = amari[index] - subPoint + addPoint
            }
            print("2:dd2Count=\(add2Count), amari=\(amari)")
        }
        
        score = add2Count * 2
        print("条件1 score=\(score)")
        return score
    }

    // 加算　条件２
    func getScoreAddSecond(plotDataList:[[Int]]) -> Int {
        var score:Int = 0
        var add2Count = 0
        var heapPlotData = [0,0,0,0,0,0,0,0]
        var addPointPlotData = [0,0,0,0,0,0,0,0]
        for plotDataTMP in plotDataList {
            print("plotDataTMP =\(plotDataTMP)")
            for index in 0..<8 {
                if plotDataTMP[index] > 1 {
                    heapPlotData[index] = heapPlotData[index] + 1
                }
                if index < 4 {
                    if plotDataTMP[index] == 0 && plotDataTMP[index + 4] == 0 {
                        addPointPlotData[index] += 1
                        addPointPlotData[index + 4] += 1
                    }
                }
            }
        }
        print("heapPlotData=\(heapPlotData), addPointPlotData=\(addPointPlotData)")

        for index in 0..<8 {
            if addPointPlotData[index] > 0 && heapPlotData[index] > 0 {
                heapPlotData[index] -= 1
                if index < 4 {
                    heapPlotData[index + 4] -= 1
                } else {
                    // ここはこない想定
                    heapPlotData[index - 4] -= 1
                }
                add2Count += 1
            }
        }
        score = add2Count * 2
        print("条件2 score=\(score)")
        return score
    }

    // 加算　条件３
    func getScoreAddThird(plotDataList:[[Int]]) -> Int {
        var score:Int = 0
        var heapPlotData = [0,0,0,0,0,0,0,0]
        for plotDataTMP in plotDataList {
            print("plotDataTMP =\(plotDataTMP)")
            var flagAllPlot = true
            
            for index in 0..<8 {
                heapPlotData[index] = heapPlotData[index] + plotDataTMP[index]
                if heapPlotData[index] <= 0 {
                    flagAllPlot = false
                }
            }

            print("heapPlotData=\(heapPlotData)")
            if flagAllPlot {
                score = 8
                break
            }
        }
        print("条件3 score=\(score)")
        return score
    }

    // 減点　条件A
    func getScoreSubFirst(plotDataList:[[Int]]) -> Int {
        var score:Int = 0
        var del9Count = 0
        var del21Count = 0
        var heapPlotData = [0,0,0,0,0,0,0,0]
        for plotDataTMP in plotDataList {
            print("plotDataTMP =\(plotDataTMP)")

            for index in 0..<8 {
                heapPlotData[index] = heapPlotData[index] + plotDataTMP[index]
            }
        }
        print("heapPlotData=\(heapPlotData)")
        
        for index in 0..<8 {
            if 0 == heapPlotData[index] {
                del9Count += 1
            }
            if index < 4 {
                if heapPlotData[index] == 0 && heapPlotData[index + 4] == 0 {
                    del21Count += 1
                }
            }
        }
        
        score = -(del9Count * 9 + del21Count * 21)
        print("条件A score=\(score)")
        return score
    }
    
    // 減点　条件B
    func getScoreSubSecond(plotDataList:[[Int]]) -> Int {
        var score:Int = 0
        var delCount = 0
        var heapPlotData = [0,0,0,0,0,0,0,0]
        for plotDataTMP in plotDataList {
            print("plotDataTMP =\(plotDataTMP)")

            for index in 0..<8 {
                heapPlotData[index] = heapPlotData[index] + plotDataTMP[index]
            }
        }
        print("heapPlotData=\(heapPlotData)")
        
        for index in 0..<4 {
            delCount += heapPlotData[exchangeIndex(index + 1)]
            + heapPlotData[exchangeIndex(index + 2)]
            + heapPlotData[exchangeIndex(index + 3)]
            - heapPlotData[exchangeIndex(index + 5)]
            - heapPlotData[exchangeIndex(index + 6)]
            - heapPlotData[exchangeIndex(index + 7)]

            + heapPlotData[exchangeIndex(index + 1)]
            + heapPlotData[exchangeIndex(index + 2)] * 2
            + heapPlotData[exchangeIndex(index + 3)]
            - heapPlotData[exchangeIndex(index + 5)]
            - heapPlotData[exchangeIndex(index + 6)] * 2
            - heapPlotData[exchangeIndex(index + 7)]
            
            // debugログ
            let delCount1 = heapPlotData[exchangeIndex(index + 1)] + heapPlotData[exchangeIndex(index + 2)] + heapPlotData[exchangeIndex(index + 3)]
            let delCount2 = heapPlotData[exchangeIndex(index + 5)] + heapPlotData[exchangeIndex(index + 6)] + heapPlotData[exchangeIndex(index + 7)]
            let delCount3 = heapPlotData[exchangeIndex(index + 1)] + heapPlotData[exchangeIndex(index + 2)] * 2 + heapPlotData[exchangeIndex(index + 3)]
            let delCount4 = heapPlotData[exchangeIndex(index + 5)] + heapPlotData[exchangeIndex(index + 6)] * 2 + heapPlotData[exchangeIndex(index + 7)]
            var lineName:String!
            if index == 0 {
                lineName = "CG"
            } else if index == 1 {
                lineName = "DH"
            } else if index == 2 {
                lineName = "AE"
            } else if index == 3 {
                lineName = "BF"
            }
            print("delCount1=\(delCount1),\tdelCount2=\(delCount2),\tdelCount1 - delCount2=\(delCount1 - delCount2)")
            print("delCount3=\(delCount3),\tdelCount4=\(delCount4),\tdelCount3 - delCount4=\(delCount3 - delCount4)")
            print("\(lineName)ラインの点=\(delCount1 - delCount2 + delCount3 - delCount4)")
//            print("delCountTotal=\(-delCount)")
        }
        
        score = delCount
        print("条件B score=\(score)")
        return score
    }

    // PlotDataの配列が時計の3時の場所から”反時計回り”で数えているが、
    // この呼び先（条件B）は0時の場所から"時計回り"で計算している
    // それに適応するようにindexを変換
    func exchangeIndex(num:Int) -> Int {
        var changeNum = 0
        if num > 7 {
            changeNum = num - 8
        } else {
            changeNum = num
        }
        // 反時計のindexを時計回りに対応させる
        var retNum = 0
        if changeNum == 0 || changeNum == 4 {
            retNum = changeNum
        } else if changeNum == 1 {
            retNum = 7
        } else if changeNum == 2 {
            retNum = 6
        } else if changeNum == 3 {
            retNum = 5
        } else if changeNum == 5 {
            retNum = 3
        } else if changeNum == 6 {
            retNum = 2
        } else if changeNum == 7 {
            retNum = 1
        }
        return retNum
    }

    // 命名術の結果文言の取得
    func getNaming(firstPlotData:[Int], secondPlotData:[Int]) -> String {
        var heapPlotData = [0,0,0,0,0,0,0,0]
        var charaList:[[String]] = [[String]]()
        var wordALL:String = ""
        for index in 0..<8 {
            heapPlotData[index] = firstPlotData[index] + secondPlotData[index]
        }
        
        let kanaData = kanaDataClass(flagAll: true)
        charaList = kanaData.getCharaListFromPlotData(heapPlotData)
        print("ALL charaList=\(charaList)")
        
        // すべてに当てはまるもの
        for index in 0..<8 {
            var tempWord:String = ""
            if 0 < Int(heapPlotData[index]) {
                continue
            } else {
                print("\(charaList[index])")
                for chara in charaList[index] {
                    tempWord += chara
                }
            }
            
            if !tempWord.isEmpty {
                if index != 7 {
                    wordALL += tempWord + " + "
                } else {
                    wordALL += tempWord + "\n"
                }
            }
        }
        
        // TODO 一つ目が丸が2個以上ある場合
        for index in 0..<8 {
            var tempWord:String = ""
            if 0 < Int(heapPlotData[index]) {
                continue
            } else {
                print("\(charaList[index])")
                for chara in charaList[index] {
                    tempWord += chara
                }
            }
            
            if !tempWord.isEmpty {
                if index != 7 {
                    wordALL += tempWord + " + "
                } else {
                    wordALL += tempWord + "\n"
                }
            }
        }
        
        return wordALL

    }
}

/*
命名診断結果

父: さわきたりき
母: さわきたみう

[パターン１]

～命名方法～

ご家族の調和をとるために導きだされた結果になります。
結果で表示されたパターンの中からお好きなパターンをお一つお選びください。
１～５個位のカッコ群で構成されていますので、すべてのカッコの中からそれぞれ一文字ずつお選びください。
ほかのカッコの中に同じ文字が重複している場合があります。
もし重複している文字をお選びになる場合は、ほかのカッコの中からも同じ文字を選んでください。
同じ文字を複数回選んだとしても、使用されるのは一回で結構です。
必ずカッコからお選びいただいた文字は全て使用してください。
それ以外の文字は、何文字でも５０音からご自由にお選びいただけます。
お好きなように組み合わせて命名してくださって結構です。
こちらの説明だけではご理解いただけない場合や、文字数が多くて組み合わせが困難な場合、また、お子様にこのように育ってほしい、ある特性を伸ばしたいなどのご希望がある場合は直接ご相談ください。


コマツザキ
21301121
よねだ
11021102
まえだ
30301031
あべ
10113000
*/
