import SwiftUI
import AVFoundation




struct ContentView: View {
    @State var showSheet : Bool = false
    private var backgroundSound : BackgroundSoundPlayer = BackgroundSoundPlayer()
    @StateObject var jyanken : Jyanken = Jyanken()

    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack{
            Color(jyanken.playerWonLastTime ? .red : .white)
                .ignoresSafeArea()
            Image(jyanken.playerWonLastTime ? "angry" : "bossy")
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                
                .frame(height: 200)
                .cornerRadius(30)
                .opacity(0.4)
                .offset(y:-55)
                
            
            VStack {
                Text("24cm0138 ラワンアウンピョウ")
                    .padding(.bottom)
                
                
                BoardView
                    .onAppear {
                        jyanken.checkWinningRate()
                        backgroundSound.playSound(FileName: "backgroundSound", FileType: "mp3",loop: true,volume: 0.3)
                    }
                
                
                ButtonView
                    .alert(isPresented: $jyanken.showAlert) {
                        Alert(title: Text(jyanken.alertTitle), message: Text(jyanken.alertMessage),
                              primaryButton:.destructive(Text("次回は手を抜いてくれ"), action: {
                                  jyanken.playerWonLastTime = false
                                  jyanken.resetGame()
                              }),
                              secondaryButton: .default(Text("リセット"), action: jyanken.resetGame) )
                    }
                Button {
                    showSheet.toggle()
                } label: {
                    HStack{
                        Image("book.pages.fill")
                            .foregroundColor(.white)
                        Text("スコアを見る")
                            .font(.title2)
                            .bold()
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()

                }
    
                


            }
            

        }
        .fullScreenCover(isPresented: $showSheet, content: {
            ScoreView()
                .environmentObject(jyanken)
        })
        
    }
  
        
    

}


extension ContentView{
    private var BoardView : some View{
        VStack {
            Text("❤️: \(jyanken.pcLife) ")
                .font(.system(size: 30))
            
            Text("相手")
                .font(.largeTitle)
                .frame(width: 350)
                .background(Color.black)
                .cornerRadius(10.0)
                .foregroundColor(.white)
            Text("\(jyanken.pcChoice)")
                .font(.system(size: 100))
                .frame(height:100)
            

            
            Text("\(jyanken.playerChoice)")
                .font(.system(size: 100))
                .frame(height:100)
            Text("プレーヤ")
                .font(.largeTitle)
                .frame(width: 350)
                .background(Color.black)
                .cornerRadius(10.0)
                .foregroundColor(.white)
            
            Text("❤️: \(jyanken.playerLife) ")
                .font(.system(size: 30))
            
        }
    }
    private var ButtonView: some View {
        HStack {
            ForEach(0..<3) { index in
                Button(action: {
                    
                        jyanken.PlayerMakeChoice(i: index + 1)
                        jyanken.PcMakeChoice(jyanken.playerChoice)
                        jyanken.checkWinOrLose(n: jyanken.playerChoice, m: jyanken.pcChoice)
                    
                }, label: {
                    Text(jyanken.choices[index])
                        .font(.system(size: 50))
                        .frame(width: 100)
                        .background(Color.black)
                        .cornerRadius(50)
                        .foregroundColor(.white)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
