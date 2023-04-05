//
//  AVAudioDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/2.
//

import SwiftUI
import AVKit

struct AVAudioDemoView: View {
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            Text("Play").font(.system(size: 45)).font(.largeTitle)
            HStack {
                Spacer()
                Button(action: {
                    self.audioPlayer.play()
                    self.audioPlayer.numberOfLoops = 10
                }) {
                    Image(systemName: "play.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
                Button(action: {
                    self.audioPlayer.pause()
                }) {
                    Image(systemName: "pause.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "chenmoshijin", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        }
    }
}

struct AVAudioDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AVAudioDemoView()
    }
}
