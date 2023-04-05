//
//  AudioPlayerDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/13.
//

import SwiftUI
import AVFoundation

struct AudioPlayerDemo: View {
    var body: some View {
        ZStack {
            AudioPlayerBgView()
            AVPlayerView()
        }
    }
}

struct AudioPlayerBgView: View {
    var body: some View {
        Image("zgr")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

// 使用AVPlayer播放音频
struct AVPlayerView: View {
    // 是否播放中
    @State private var isPlaying: Bool = false
    @State private var songs = ["别怕我伤心", "沉默是金"]
    @State private var current = 0
    @State private var currentLine = 0
    @State private var lyrics: [LrcLine] = []
    // 播放器实例
    @State private var player: AVAudioPlayer?
    @State private var progress: Double = 0
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(self.songs[self.current])
                    .padding()
                    .foregroundColor(.white)
                    .font(.title2)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            }
            HStack {
                Text(formatTime(self.player?.currentTime ?? 0))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                
                Slider(value: $progress, in: 0...1) { newValue in
                    let dutation = self.player?.duration
                    self.player?.currentTime = self.progress * dutation!
                }
                
                Text(formatTime(self.player?.duration ?? 0))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            }
            .padding(.horizontal, 30)
            
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center) {
                        ForEach(lyrics.indices, id: \.self) { index in
                            Text(lyrics[index].content)
                                .padding()
                                .font(.system(size: 20))
                                .foregroundColor(currentLine == index ? .orange : .white)
                                .cornerRadius(20)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .id(index)
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                .onAppear {
                                    proxy.scrollTo(0, anchor: .center)
                                }
                                .onChange(of: currentLine) { value in
                                    withAnimation {
                                        proxy.scrollTo(currentLine, anchor: .center)
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(20)
            }
            HStack(spacing: 35) {
                Button {
                    if current > 0 {
                        current -= 1
                        changeMusic(fileName: self.songs[current])
                    }
                } label: {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                
                Button(action: {
                    if player == nil {
                        return
                    }
                    if isPlaying {
                        // 暂停
                        player?.pause()
                    } else {
                        // 播放
                        player?.play()
                    }
                    // 更新播放状态
                    isPlaying.toggle()
                }) {
                    // 根据播放状态展示暂停按钮或播放按钮
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.white)
                    
                }
                
                Button {
                    if current < self.songs.count - 1 {
                        current += 1
                        changeMusic(fileName: self.songs[current])
                    }
                } label: {
                    Image(systemName: "forward.fill")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.5))
        }
        .accentColor(.orange)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            changeMusic(fileName: self.songs[self.current])
            lyrics = parseLrcFile(lrcFileName: self.songs[self.current])
        }
        .onDisappear {
            self.player?.stop()
            isPlaying = false
            progress = 0
        }
        .onReceive(timer) { _ in
            if let currentTime = self.player?.currentTime,
               let duration = self.player?.duration {
                self.progress = currentTime/duration
                if self.progress > 0 {
                    print(">>> progress:\(progress), currentTime:\(currentTime), duration:\(duration)")
                }
                
                for index in self.lyrics.indices {
                    let line = lyrics[index]
                    if shouldHighlight(line: line, index: index) {
                        withAnimation {
                            currentLine = index
                        }
                    }
                }
                
                if player!.duration - player!.currentTime <= 1 {
                    if current < self.songs.count - 1 {
                        current += 1
                    } else {
                        current = 0
                    }
                    changeMusic(fileName: self.songs[current])
                }
            }
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func shouldHighlight(line: LrcLine, index: Int) -> Bool {
        return self.player!.currentTime >= Double(line.startTime) && self.player!.currentTime <= Double(line.endTime!)
    }
    
    func changeMusic(fileName: String) {
        self.player?.stop()
        self.isPlaying = false
        // 加载本地音频
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print(">>> 播放失败，请检查音乐文件是否存在！")
            return
        }
        // 初始化AVAudioPlayer
        self.player = try? AVAudioPlayer(contentsOf: url)
        if self.player == nil {
            print(">>> 播放失败，请检查音乐文件是否存在！")
        }
        self.player?.play()
        self.isPlaying = true
        lyrics = parseLrcFile(lrcFileName: self.songs[self.current])
    }
    
    func parseLrcFile(lrcFileName: String) -> [LrcLine] {
        var lrcLines: [LrcLine] = []
        guard let lrcPath = Bundle.main.path(forResource: lrcFileName, ofType: "txt") else {
            return []
        }
        
        guard let lrcContent = try? String(contentsOfFile: lrcPath, encoding: String.Encoding.utf8) else {
            return []
        }
        let lrcComponents = lrcContent.components(separatedBy: .newlines)
        
        for lrcComponent in lrcComponents {
            if lrcComponent.hasPrefix("[") {
                let timeIndex = lrcComponent.index(lrcComponent.startIndex, offsetBy: 9)
                let timeString = String(lrcComponent[lrcComponent.startIndex...timeIndex])
                let minutes = Double(timeString.prefix(3).dropFirst()) ?? 0
                let seconds = Double(timeString.suffix(6).dropLast()) ?? 0
                let milliseconds = Double(timeString.suffix(3).dropFirst()) ?? 0
                let time = minutes * 60 + seconds + milliseconds / 1000.0
                let content = String(lrcComponent[timeIndex...].dropFirst())
                lrcLines.append(LrcLine(startTime: time, content: content))
            }
        }
        
        var newLrcLines: [LrcLine] = []
        for index in lrcLines.indices {
            let line = lrcLines[index]
            if index != lrcLines.count - 1 {
                let nextLine = lrcLines[index + 1]
                newLrcLines.append(LrcLine(startTime: line.startTime, endTime: nextLine.startTime, content: line.content))
            } else {
                newLrcLines.append(LrcLine(startTime: line.startTime, endTime: self.player?.duration, content: line.content))
            }
            
        }
        return newLrcLines
    }
}

//struct LyricLine: Hashable {
//    var seconds: Double
//    var line: String
//}

struct LrcLine: Hashable {
    var id = UUID()
    var startTime: TimeInterval
    var endTime: TimeInterval?
    var content: String
}

// 使用AVAudioPlayer播放音频
struct AVAudioPalyerView: View {
    // 是否播放中
    @State private var isPlaying: Bool = false
    // 播放器实例
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        VStack {
            Button(action: {
                if isPlaying {
                    // 暂停
                    player?.pause()
                } else {
                    // 播放
                    player?.play()
                }
                // 更新播放状态
                isPlaying.toggle()
            }) {
                // 根据播放状态展示暂停按钮或播放按钮
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.black.opacity(0.6))
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 2)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                    }
            }
        }
        .onAppear {
            // 加载本地音频
            guard let url = Bundle.main.url(forResource: "chenmoshijin", withExtension: "mp3") else { return }
            // 初始化AVAudioPlayer
            player = try? AVAudioPlayer(contentsOf: url)
        }
    }
}

struct SoundPlayerDemo_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerDemo()
    }
}
