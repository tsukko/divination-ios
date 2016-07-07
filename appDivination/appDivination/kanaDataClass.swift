//
//  katakanaData.swift
//  appDivination
//
//  Created by Norizou on 2016/01/06.
//  Copyright © 2016年 Nori. All rights reserved.
//

import UIKit
/*
 * ひらがな、カタカナ、空白文字の占い結果を扱う
 */
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
    init(flagAll:Bool) {
        initialKanaData(flagAll)
    }
    
    // ひらがな、カタカナ、空白のデータ
    func initialKanaData(flagAll:Bool) {
        // フラグが立っている場合、ひらがなもカタカナも取得する
        if flagAll {
        // ひらがな
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
        }
        
        // カタカナ
        knDt.append(kanaData(code: "0x30A1", character: "ァ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A2", character: "ア", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A3", character: "ィ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A4", character: "イ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A5", character: "ゥ", vowel: "2", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A6", character: "ウ", vowel: "2", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30A7", character: "ェ", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30A8", character: "エ", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30A9", character: "ォ", vowel: "4", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30AA", character: "オ", vowel: "4", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30AB", character: "カ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30AC", character: "ガ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30AD", character: "キ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30AE", character: "ギ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30AF", character: "ク", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B0", character: "グ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B1", character: "ケ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30B2", character: "ゲ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30B3", character: "コ", vowel: "4", plot: ["1", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30B4", character: "ゴ", vowel: "4", plot: ["1", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30B5", character: "サ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B6", character: "ザ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B7", character: "シ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B8", character: "ジ", vowel: "1", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30B9", character: "ス", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30BA", character: "ズ", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30BB", character: "セ", vowel: "3", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30BC", character: "ゼ", vowel: "3", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30BD", character: "ソ", vowel: "4", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30BE", character: "ゾ", vowel: "4", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30BF", character: "タ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30C0", character: "ダ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30C1", character: "チ", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30C2", character: "ヂ", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30C3", character: "ッ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30C4", character: "ツ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30C5", character: "ヅ", vowel: "2", plot: ["1", "0", "1", "0", "1", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30C6", character: "テ", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30C7", character: "デ", vowel: "3", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30C8", character: "ト", vowel: "4", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30C9", character: "ド", vowel: "4", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30CA", character: "ナ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30CB", character: "ニ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30CC", character: "ヌ", vowel: "2", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30CD", character: "ネ", vowel: "3", plot: ["0", "1", "0", "1", "0", "1", "0", "1"]))
        knDt.append(kanaData(code: "0x30CE", character: "ノ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30CF", character: "ハ", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D0", character: "バ", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D1", character: "パ", vowel: "0", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D2", character: "ヒ", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D3", character: "ビ", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D4", character: "ピ", vowel: "1", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D5", character: "フ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D6", character: "ブ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D7", character: "プ", vowel: "2", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D8", character: "ヘ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30D9", character: "ベ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30DA", character: "ペ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30DB", character: "ホ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30DC", character: "ボ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30DD", character: "ポ", vowel: "4", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30DE", character: "マ", vowel: "0", plot: ["0", "0", "1", "0", "0", "0", "1", "0"]))
        knDt.append(kanaData(code: "0x30DF", character: "ミ", vowel: "1", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30E0", character: "ム", vowel: "2", plot: ["0", "0", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30E1", character: "メ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30E2", character: "モ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30E3", character: "ャ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30E4", character: "ヤ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "1"]))
        knDt.append(kanaData(code: "0x30E5", character: "ュ", vowel: "2", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30E6", character: "ユ", vowel: "2", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30E7", character: "ョ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30E8", character: "ヨ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30E9", character: "ラ", vowel: "0", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30EA", character: "リ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30EB", character: "ル", vowel: "2", plot: ["1", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30EC", character: "レ", vowel: "3", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30ED", character: "ロ", vowel: "4", plot: ["0", "1", "0", "0", "0", "1", "0", "0"]))
        knDt.append(kanaData(code: "0x30EE", character: "ヮ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30EF", character: "ワ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F0", character: "ヰ", vowel: "1", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F1", character: "ヱ", vowel: "3", plot: ["0", "1", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F2", character: "ヲ", vowel: "4", plot: ["0", "0", "0", "1", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F3", character: "ン", vowel: "2", plot: ["0", "0", "0", "0", "1", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F4", character: "ヴ", vowel: "2", plot: ["0", "0", "1", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F5", character: "ヵ", vowel: "0", plot: ["1", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x30F6", character: "ヶ", vowel: "3", plot: ["0", "0", "0", "1", "0", "0", "0", "1"]))
        // 全角、半角空白
        knDt.append(kanaData(code: "0xFF5A", character: "　", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        knDt.append(kanaData(code: "0x0020", character: " ", vowel: "0", plot: ["0", "0", "0", "0", "0", "0", "0", "0"]))
        //        let params = [
        //            "knDt": knDt.map{e in e.toDictionary()}
        //        ]
        //print(knDt)
        //        print(params)
    }
    
    // 引数に渡した文字コード（例：0x3041）に対応するプロットデータを返す
    func getPlotData(code: String) -> [String!] {
        let sPlot: [String!]=["","","","","","","",""]
        for chara in knDt {
            if code == chara.code {
                //print(chara.character)
                return chara.plot
            }
        }
        return sPlot
    }
    
    // 引数に渡したプロットの位置（0～7）に丸が付く（1が入っている）文字列を取得し、
    // ランダムに一文字を返却する
    func getListPlotData(index: Int) -> String {
        var charaList = [kanaData]()
        for chara in knDt {
            if 0 < Int(chara.plot[index]) {
                charaList.append(chara)
            }
        }
        // ランダムに一文字を返却する
        let d = Int(arc4random_uniform(UInt32(charaList.count)))
        return charaList[d].character
    }
}
