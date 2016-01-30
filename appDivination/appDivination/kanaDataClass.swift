//
//  katakanaData.swift
//  appDivination
//
//  Created by Norizou on 2016/01/06.
//  Copyright © 2016年 Nori. All rights reserved.
//

import UIKit

class kanaDataClass {
    
    var knDt = [kanaData]()
    
    struct kanaData {
        var code: String!
        var character: String!
        var vowel: String!
        var plot: [String!]=["","","","","","","",""]
        func toDictionary() -> [String: String!] {
            return [
                "code" : code,
                "character" : character,
                "vowel" : vowel,
                "plot[0]" : plot[0],
                "plot[1]" : plot[1],
                "plot[2]" : plot[2],
                "plot[3]" : plot[3],
                "plot[4]" : plot[4],
                "plot[5]" : plot[5],
                "plot[6]" : plot[6],
                "plot[7]" : plot[7],
            ]
        }
    }
    
    // イニシャライザ
    init() {
        initialKanaData()
    }
    
    func initialKanaData() {
        knDt.append(kanaData(code: "0x3041", character: "ぁ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3042", character: "あ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3043", character: "ぃ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3044", character: "い", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3045", character: "ぅ", vowel: "2", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3046", character: "う", vowel: "2", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3047", character: "ぇ", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3048", character: "え", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3049", character: "ぉ", vowel: "4", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x304A", character: "お", vowel: "4", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x304B", character: "か", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x304C", character: "が", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x304D", character: "き", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x304E", character: "ぎ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x304F", character: "く", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3050", character: "ぐ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3051", character: "け", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3052", character: "げ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3053", character: "こ", vowel: "4", plot: ["1", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3054", character: "ご", vowel: "4", plot: ["1", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3055", character: "さ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3056", character: "ざ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3057", character: "し", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3058", character: "じ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3059", character: "す", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x305A", character: "ず", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x305B", character: "せ", vowel: "3", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x305C", character: "ぜ", vowel: "3", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x305D", character: "そ", vowel: "4", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x305E", character: "ぞ", vowel: "4", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x305F", character: "た", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3060", character: "だ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3061", character: "ち", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3062", character: "ぢ", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3063", character: "っ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3064", character: "つ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3065", character: "づ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3066", character: "て", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3067", character: "で", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x3068", character: "と", vowel: "4", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3069", character: "ど", vowel: "4", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x306A", character: "な", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x306B", character: "に", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x306C", character: "ぬ", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x306D", character: "ね", vowel: "3", plot: ["0", "1", "0", "1", "0", "1", "0", "1"]))
        knDt.append(kanaData(code: "0x306E", character: "の", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x306F", character: "は", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3070", character: "ば", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3071", character: "ぱ", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3072", character: "ひ", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3073", character: "び", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3074", character: "ぴ", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3075", character: "ふ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3076", character: "ぶ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3077", character: "ぷ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3078", character: "へ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3079", character: "べ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x307A", character: "ぺ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x307B", character: "ほ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x307C", character: "ぼ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x307D", character: "ぽ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x307E", character: "ま", vowel: "0", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x307F", character: "み", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3080", character: "む", vowel: "2", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x3081", character: "め", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3082", character: "も", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3083", character: "ゃ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3084", character: "や", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x3085", character: "ゅ", vowel: "2", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3086", character: "ゆ", vowel: "2", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3087", character: "ょ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3088", character: "よ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3089", character: "ら", vowel: "0", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x308A", character: "り", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x308B", character: "る", vowel: "2", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x308C", character: "れ", vowel: "3", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x308D", character: "ろ", vowel: "4", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x308E", character: "ゎ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x308F", character: "わ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3090", character: "ゐ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3091", character: "ゑ", vowel: "3", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3092", character: "を", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x3093", character: "ん", vowel: "2", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        //        let params = [
        //            "knDt": knDt.map{e in e.toDictionary()}
        //        ]
        //print(knDt)
        //        print(params)
    }
    
    func getPlotData(code: String) -> [String!] {
        let sPlot: [String!]=["","","","","","","",""]
        for chara in knDt {
            if code == chara.code {
                print(chara.character)
                return chara.plot
            }
        }
        return sPlot
    }
    
    func checkResult(plotData:[Int]) -> String {
        var flagYatanokagami: Int = 0
        var flagHutomani: Bool = false
        var flagMikumari: Int = 0
        for i in 0...7 {
            if plotData[i] > 0 {
                flagYatanokagami++
            } else {
                flagMikumari++
            }
        }
        
        // 01. ヤタノカガミ： 全てのプロット位置に丸がつく
        if flagYatanokagami == 8 {
            return "この世に必要な音の響きの全てを持って誕生したあなた。\n皆に分け与え、繋ないでいく役目を持っています。\nただ、すべてを持ち合わせるためか、なかなか個性が見えづらい部分があります。\n\nあなたの運気を上げる音：５０音すべて。"
        }
        // 03. ミクマリ： 丸がひとつもつかない
        if flagMikumari == 8 {
            return "攻撃と防御を最大限に使うことが出来る、とても強い特殊な言霊です。\nただし、いつも張り詰めていて、ゆるみを持っていないため、常に戦い続けなければならない特性を持ち合わせています。\n\nあなたの運気を上げる最強の音：ネ"
        }

        for i in 0...7 {
            if (i % 2 == 0) {
                if (plotData[i] == 0) {
                    flagHutomani = false;
                }
            } else {
                if (plotData[i] >= 1) {
                    flagHutomani = false;
                }
            }
        }
        
        // 02. フトマニ： 十字の部分にだけ丸がつく
        if flagHutomani {
            return "あなたは、なんの使命もたずに生れ出た特殊な存在です。\n五感で感じるこの世には、まるで無のような存在です。\nもしかすると別の次元において大きな意味を持つ、特別な存在なのかもしれません。\n\nあなたの運気を上げる音：５０音すべて。"
        }
        
        // 一般的なパターン
        let retDivination = resultDivinationClass()
        let test123:String = retDivination.getMessage(plotData)

        return test123
    }
}
