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
        print("score add1 :\(scoreAddFirst)")
        let scoreAddSecond:Int = getScoreAddSecond(plotDataList)
        print("score add2 :\(scoreAddSecond)")
        let scoreAddThird:Int = getScoreAddThird(plotDataList)
        print("score add3 :\(scoreAddSecond)")
        let scoreSubFirst:Int = getScoreSubFirst(plotDataList)
        print("score sub1 :\(scoreSubFirst)")
        let scoreSubSecond:Int = getScoreSubSecond(plotDataList)
        print("score sub2 :\(scoreSubSecond)")
        
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
            if 0 == test(sPlotDataList[0][index]) & test(sPlotDataList[1][index]) {
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
                if 0 == plotDataTMP[index] && amari[index] != 0 {
                    add2Count = add2Count + 1
                }
                amari[index] = amari[index] + plotDataTMP[index] - 1
                if amari[index] < 0 {
                    amari[index] = 0
                }
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
            
            // debug
            let delCount1 = heapPlotData[exchangeIndex(index + 1)] + heapPlotData[exchangeIndex(index + 2)] + heapPlotData[exchangeIndex(index + 3)]
            let delCount2 = heapPlotData[exchangeIndex(index + 5)] + heapPlotData[exchangeIndex(index + 6)] + heapPlotData[exchangeIndex(index + 7)]
            let delCount3 = heapPlotData[exchangeIndex(index + 1)] + heapPlotData[exchangeIndex(index + 2)] * 2 + heapPlotData[exchangeIndex(index + 3)]
            let delCount4 = heapPlotData[exchangeIndex(index + 5)] + heapPlotData[exchangeIndex(index + 6)] * 2 + heapPlotData[exchangeIndex(index + 7)]
            print("delCount1=\(delCount1)")
            print("delCount2=\(delCount2)")
            print("delCount3=\(delCount3)")
            print("delCount4=\(delCount4)")
            print("delCount1 - delCount2=\(delCount1 - delCount2)")
            print("delCount3 - delCount4=\(delCount3 - delCount4)")
            print("delCount=\(delCount1 - delCount2 + delCount3 - delCount4)")
            print("delCountTotal=\(-delCount)")
        }
        
        score = delCount
        print("条件B score=\(score)")
        return score
    }

    // １つ以上の丸がある場合、１を返す（例えば丸が３つあっても１を返す）
    func test(num:Int) -> Int {
        if num > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    // PlotDataの配列が時計の3時の場所から”反時計回り”で数えているが、この呼び先（条件B）は"時計回り"で計算している
    // 反時計回り計算を逆にする
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
