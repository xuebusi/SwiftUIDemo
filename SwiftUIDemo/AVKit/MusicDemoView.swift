//
//  MusicDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/18.
//
//
//import SwiftUI
//
//struct MusicDemoView: View {
//    @State private var lyrics: [LrcLine2] = [
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//        LrcLine2(content: "There's a fire starting in my heart"),
//        LrcLine2(content: "Reaching a fever pitch, and it's bringing me out the dark"),
//        LrcLine2(content: "Finally I can see you crystal clear"),
//        LrcLine2(content: "Go ahead and sell me out and I'll lay your ship bare"),
//    ]
//
//    @State private var highlightedLineIndex = 0
//    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
//
//    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView {
//                VStack(alignment: .leading, spacing: 30) {
//                    ForEach(lyrics.indices) { index in
//                        Text(lyrics[index].content)
//                            .font(.system(.largeTitle, design: .rounded))
//                            .padding()
//                            .lineLimit(1)
//                            .foregroundColor(highlightedLineIndex == index ? .red : .black)
//                    }
//                }
//                .padding()
//                .onAppear {
//                    proxy.scrollTo(highlightedLineIndex, anchor: .center)
//                }
//                .onReceive(timer) { _ in
//                    if highlightedLineIndex == lyrics.count - 1 {
//                        highlightedLineIndex = 0
//                    } else {
//                        highlightedLineIndex += 1
//                    }
//                    proxy.scrollTo(highlightedLineIndex, anchor: .top)
//                }
//            }
//        }
//    }
//}
//
//struct LrcLine2: Identifiable {
//    var id = UUID()
//    var content: String
//}
//
//struct MusicDemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicDemoView()
//    }
//}


import SwiftUI
struct LyricsView: View {
    let lyrics: [String] = Array(0...10).map({String($0)})
    
    @State private var current = 0
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(lyrics.indices, id: \.self) { index in
                        Text("Hello World: " + lyrics[index])
                            .padding()
                            .font(.system(.largeTitle))
                            .foregroundColor(index == current ? .blue : .black)
                            .id(index)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onAppear {
                                if index == 0 {
                                    proxy.scrollTo(index, anchor: .center)
                                    current = index
                                }
                            }
                            .onChange(of: current) { value in
                                if index == value {
                                    proxy.scrollTo(index, anchor: .center)
                                }
                            }
                    }
                }
                .padding()
                .onReceive(timer) { _ in
                    if current == lyrics.count - 1 {
                        current = 0
                    } else {
                        current += 1
                    }
                }
            }
        }
    }
    
    private func getIndex(for time: Double) -> Int {
        var index = 0
        var totalTime = 0.0
        for i in 0..<lyrics.count {
            let lineDuration = getDuration(for: lyrics[i])
            totalTime += lineDuration
            if totalTime > time {
                index = i
                break
            }
        }
        return index
    }
    
    private func getDuration(for line: String) -> Double {
        // 计算每行歌词的持续时间
        return Double(line.count) / 10.0
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
