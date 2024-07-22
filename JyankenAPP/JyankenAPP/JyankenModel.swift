//
//  JyankenClass.swift
//  JyankenAPP
//
//  Created by Hlwan Aung Phyo on 2024/06/03.
//




//アラートと勝負の判定をするクラス

import Foundation
import AVFoundation
import SwiftUI


class Jyanken : ObservableObject{
    
    
    @AppStorage("playedCount") var playedCount = 0
    @AppStorage("playerWonLastTime")var playerWonLastTime = false
    @Published var winningRate = 0
    
    @AppStorage("playerWinningCount") var playerWinningCount = 0
    @AppStorage("pcWinningCount") var pcWinningCount = 0
    
    private var soundPlayer = SoundPlayer()
    
    
    @Published private var soundEffectPlayer: AVAudioPlayer?
    @Published var choices : [String] = ["👊", "✌️", "✋"]
    
    @Published var playerLife: Int = 3
    @Published var pcLife: Int = 3
    
    @Published var pcChoice: String = ""
    @Published var playerChoice: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    
    func resetGame() {
        self.playerLife = 3
        self.pcLife = 3
        self.pcChoice = ""
        self.playerChoice = ""
        self.playedCount += 1
        self.checkWinningRate()
    }
    
    func scoreReset(){
        self.playerWinningCount = 0
        self.pcWinningCount = 0
        self.playedCount = 0
        self.winningRate = 0
    }
    
    func PcMakeChoice(_ playerChoice : String) {
        if playerWonLastTime{
            switch playerChoice{
            case "👊":
                pcChoice = "✋"
            case "✌️":
                pcChoice = "👊"
            case "✋":
                pcChoice = "✌️"
            default:
                pcChoice = ""
            }
        }else{
            pcChoice = choices.randomElement()!
        }
        
    }
    
    
    func PlayerMakeChoice(i: Int)  {
        
        switch i {
        case 1:
            playerChoice = "👊"
        case 2:
            playerChoice = "✌️"
        case 3:
            playerChoice = "✋"
        default:
            playerChoice = ""
        }
        HapticManager.instance.impact(style: .soft)
    }
    func checkWinningRate(){
        if playedCount != 0 {
            winningRate = Int((Double(playerWinningCount) / Double(playedCount) * 100.0)+0.5)
        }else{
            winningRate = 0
        }
        
    }
    func checkWinOrLose(n: String, m: String)  {
        if (n == "👊" && m == "✌️") || (n == "✌️" && m == "✋") || (n == "✋" && m == "👊") {//won
            pcLife -= 1
            
            soundPlayer.playSound(FileName: "lose", FileType: "mp3")
        }else if(n == m){
            soundPlayer.playSound(FileName: "ha", FileType: "mp3")
        } else {
            playerLife -= 1
            
            soundPlayer.playSound(FileName: "orenokachi", FileType: "mp3")
        }
        
        checkLife()
    }
    
    func checkLife(){
        if playerLife < 1 {
            alertTitle = "負け"
            alertMessage = "ゲームをリセットしますか？"
            pcWinningCount += 1
            for i in 0..<200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    HapticManager.instance.notification(type: .error)
                }
            }
            soundPlayer.playSound(FileName: "sonoteido", FileType: "mp3")
            showAlert = true
            
        } else if pcLife < 1 {
            alertTitle = "プレーヤーの勝ち"
            alertMessage = "ゲームをリセットしますか？"
            showAlert = true
            playerWonLastTime = true
            playerWinningCount += 1
            
            //            playSoundEffect(FileName: "tsuyoina", FileType: "mp3")過去のコード
            
            soundPlayer.playSound(FileName: "tsuyoina", FileType: "mp3")
        }
    }
    
    
    
    
    
    
}
