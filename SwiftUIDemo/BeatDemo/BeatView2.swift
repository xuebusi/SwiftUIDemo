//
//  BeatView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//
import AVFoundation
import SwiftUI

// 节拍器2
struct BeatView2: View {
    @State var tempo: Int = 60   // 默认的节拍速度为60BPM
    
    // AVPlayer用于播放声音
    var player: AVPlayer = {
        guard let path = Bundle.main.path(forResource: "click", ofType: "mp3") else { return AVPlayer() }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 1.0
        return player
    }()
    
    var beatsPerBar = 4   // 每小节的节拍数
    
    // 计算每拍所需要的时间
    var beatTime: Double {
        return 60.0 / Double(tempo)
    }
    
    // 根据设置的时间间隔和速度生成一个节拍序列
    var beatSequence: [String] {
        var sequence = [String]()
        let totalBeatsCount = beatsPerBar * 4   // 一小节的总拍数
        for beat in 1...totalBeatsCount {
            if beat % beatsPerBar == 1 {
                sequence.append("大拍")
            } else {
                sequence.append("小拍")
            }
        }
        return sequence
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("节拍速度：\(tempo)BPM")
                Slider(value: Binding(get: {
                    Double(self.tempo)
                }, set: { (newVal) in
                    self.tempo = Int(newVal)
                }), in: 30...300, step: 1)
            }.padding()
            
            // 显示节拍序列，点击按钮播放对应的声音
            List(beatSequence, id: \.self) { beat in
                Button(action: {
                    self.playSound()
                }) {
                    Text(beat)
                }
            }
        }
    }
    
    // 播放声音
    func playSound() {
        player.seek(to: CMTime.zero)
        player.play()
    }
}

struct BeatView2_Previews: PreviewProvider {
    static var previews: some View {
        BeatView2()
    }
}
