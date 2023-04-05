//
//  BeatView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//
import SwiftUI
import AVFoundation

// 节拍器
struct BeatView: View {
    @State var isPlaying = false
    @State var currentBeat = 0
    @State var tempo: Double = 120.0    // 初始速度为 120 BPM
    @State var timeSignature = 4
    
    @State var timer: Timer?
    
    let audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!))

    var beatsPerBar: Double {
        return Double(timeSignature)
    }

    var beatsPerMinute: Double {
        return tempo
    }

    var millisecondsPerBeat: Double {
        return 60_000.0 / beatsPerMinute
    }

    var totalBeats: Int {
        return Int(beatsPerBar * 4)
    }

    var body: some View {
        VStack {
            Spacer()
            
            Text("\(currentBeat % totalBeats + 1)")
                .font(.system(size: 72))
                .fontWeight(.bold)
                .frame(width: 200, height: 200)
            
            Text("\(Int(tempo)) BPM")
                .font(.system(size: 24))
                .padding()
            
            HStack {
                Text("BPM")
                Slider(value: $tempo, in: 30...300, step: 1)
            }
            .padding()
            
            HStack(spacing: 8) {
                ForEach(1..<9) { index in
                    Button(action: {
                        self.timeSignature = index
                    }) {
                        Text("\(index)/4")
                            .font(.system(size: 16))
                            .foregroundColor(self.timeSignature == index ? .white : .primary)
                    }
                    .padding()
                    .background(self.timeSignature == index ? Color.blue : Color.green)
                    .cornerRadius(6.0)
                }
            }
            .padding(.bottom, 16)
            
            HStack {
                Spacer()
                
                Button(action: togglePlay) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 64, height: 64)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            try? AVAudioSession.sharedInstance().setCategory(.playback)
        }
    }

    func togglePlay() {
        if timer == nil || timer?.isValid == false {
            startPlaying()
        } else {
            stopPlaying()
        }

        withAnimation {
            isPlaying.toggle()
        }
    }
    
    func startPlaying() {
        timer = Timer.scheduledTimer(withTimeInterval: millisecondsPerBeat / 1000, repeats: true) {_ in
            self.currentBeat += 1
            
            if self.currentBeat >= self.totalBeats {
                self.currentBeat = 0
            }
            
            if self.currentBeat % Int(self.beatsPerBar) == 0 {
                self.audioPlayer.play()
            } else {
                self.audioPlayer.currentTime = 0
                self.audioPlayer.play()
            }
        }
    }
    
    func stopPlaying() {
        timer?.invalidate()
        timer = nil
        currentBeat = 0
        audioPlayer.stop()
    }
}


struct BeatView_Previews: PreviewProvider {
    static var previews: some View {
        BeatView()
    }
}
