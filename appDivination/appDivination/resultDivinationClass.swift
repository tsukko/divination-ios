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
    
    func getMessage(plotCount:[Int]) -> String {
        var index:Int = 0
        var msgTotal:String = ""
        var fortuneWordTotal:String = ""
        for msg in retDivination {
            if plotCount[index] >= 3 {
                msgTotal += msg.message[2]
            } else if plotCount[index] < 3 && plotCount[index] >= 1 {
                msgTotal += msg.message[1]
            } else  {
                msgTotal += msg.message[0]
                // TODO 乱数
                fortuneWordTotal += msg.fortuneWord[0]
            }
            index++
        }
        return msgTotal + "\n\n" + fortuneWordTotal
    }
}
