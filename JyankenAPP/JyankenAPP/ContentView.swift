import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var backgroundPlayer: AVAudioPlayer?
    @State private var soundEffectPlayer: AVAudioPlayer?
    
    @State var playerLife: Int = 3
    @State var pcLife: Int = 3
    
    @State var pcChoice: String = ""
    @State var playerChoice: String = ""
    
    @State var choices: [String] = ["👊", "✌️", "✋"]
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("❤️: \(pcLife) ")
                .font(.system(size: 30))
            
            Text("相手")
                .font(.largeTitle)
                .frame(width: 350)
                .background(Color.red)
                .cornerRadius(10.0)
                .foregroundColor(.white)
            Text("\(pcChoice)")
                .font(.system(size: 100))
            
            Spacer()
            
            Text("\(playerChoice)")
                .font(.system(size: 100))
            Text("プレーヤ")
                .font(.largeTitle)
                .frame(width: 350)
                .background(Color.blue)
                .cornerRadius(10.0)
                .foregroundColor(.white)
            
            Text("❤️: \(playerLife) ")
                .font(.system(size: 30))
            
            Spacer()
            
            ButtonView
        }
        .onAppear {
            playBackgroundSound(FileName: "backgroundSound", FileType: "mp3")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("リセット"), action: resetGame)
            )
        }
        .padding(70)
    }
    
    func PcMakeChoice() {
        pcChoice = choices.randomElement() ?? ""
    }
    
    func PlayerMakeChoice(i: Int) {
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
    }
    
    func checkWinOrLose(n: String, m: String) {
        if (n == "👊" && m == "✌️") || (n == "✌️" && m == "✋") || (n == "✋" && m == "👊") {
            pcLife -= 1
            playSoundEffect(FileName: "lose", FileType: "mp3")
        }else if(n == m){
            
        } else {
            playerLife -= 1
            playSoundEffect(FileName: "orenokachi", FileType: "mp3")
        }
        
        if playerLife < 1 {
            alertTitle = "お前は死んだわ"
            alertMessage = "ゲームをリセットしますか？"
            playSoundEffect(FileName: "sonoteido", FileType: "mp3")
            showAlert = true
        } else if pcLife < 1 {
            alertTitle = "次回は勝ってみせる"
            alertMessage = "ゲームをリセットしますか？"
            showAlert = true
            playSoundEffect(FileName: "tsuyoina", FileType: "mp3")
        }
    }
    
    func playBackgroundSound(FileName: String, FileType: String) {
        guard let url = Bundle.main.url(forResource: FileName, withExtension: FileType) else {
            print("Sound file not found")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.2
            backgroundPlayer?.play()
        } catch let error {
            print("Error playing background sound: \(error.localizedDescription)")
        }
    }
    
    func playSoundEffect(FileName: String, FileType: String) {
        guard let url = Bundle.main.url(forResource: FileName, withExtension: FileType) else {
            print("Sound file not found")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.play()
        } catch let error {
            print("Error playing sound effect: \(error.localizedDescription)")
        }
    }
    
    func resetGame() {
        playerLife = 3
        pcLife = 3
        pcChoice = ""
        playerChoice = ""
    }
    
    var ButtonView: some View {
        HStack {
            ForEach(0..<3) { index in
                Button(action: {
                    PcMakeChoice()
                    PlayerMakeChoice(i: index + 1)
                    playSoundEffect(FileName: "ha", FileType: "mp3")
                    checkWinOrLose(n: playerChoice, m: pcChoice)
                }, label: {
                    Text(choices[index])
                        .font(.system(size: 50))
                        .frame(width: 100)
                        .background(Color.black)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
