//
//  SoundPlayer.swift
//  JyankenAPP
//
//  Created by Hlwan Aung Phyo on 2024/06/03.
//

import Foundation
import AVFoundation

class SoundPlayer {
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(FileName: String, FileType: String, loop: Bool = false, volume: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: FileName, withExtension: FileType) else {
//            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = loop ? -1 : 0
            audioPlayer?.volume = volume
            audioPlayer?.play()
        } catch let error {
//            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}
