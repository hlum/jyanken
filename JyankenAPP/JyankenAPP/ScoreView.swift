//
//  ScoreView.swift
//  JyankenAPP
//
//  Created by Hlwan Aung Phyo on 2024/07/12.
//

import SwiftUI
import Charts
struct ScoreView: View {
    @EnvironmentObject var jyanken : Jyanken
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                }
                )
                .font(.title)
                .padding()
                Spacer()
            }

            Text("合計：\(jyanken.playedCount)")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            
            if(jyanken.playedCount != 0){
                ChartView
            }else{
                Spacer()
                Text("スコアはまだありません！！")
                    .font(.title)
            }
            
            Spacer()
            
            Button {
                jyanken.scoreReset()
            } label: {
                Image(systemName:"arrowshape.turn.up.backward.2.circle")
                Text("スコアリセット")
            }
            .frame(height:20)
            .padding()
            .background(.orange)
            .cornerRadius(10)
            .foregroundColor(.white)
            
        }
    }
    
}

extension ScoreView{
    private var ChartView : some View{
        Chart {
            SectorMark(
                angle: .value("負け", jyanken.pcWinningCount),
                innerRadius: .ratio(0.5),
                angularInset: 1.5)
            .foregroundStyle(.red)
            .annotation(position: .overlay, alignment: .center) {
                Text("負け: \(jyanken.pcWinningCount)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                
            }
            
            SectorMark(
                angle: .value("勝ち", jyanken.playerWinningCount),
                innerRadius: .ratio(0.5),
                angularInset: 1.5)
            .foregroundStyle(.green)
            .annotation(position: .overlay, alignment: .center) {
                Text("勝ち: \(jyanken.playerWinningCount)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .padding()
        
    }
}

#Preview {
    ScoreView()
}
