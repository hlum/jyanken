import Foundation
import AVFoundation

class BackgroundSoundPlayer{
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(FileName: String, FileType: String, loop: Bool = false, volume: Float = 0.3) {
        guard let url = Bundle.main.url(forResource: FileName, withExtension: FileType) else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = loop ? -1 : 0
            audioPlayer?.volume = volume
            audioPlayer?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}
