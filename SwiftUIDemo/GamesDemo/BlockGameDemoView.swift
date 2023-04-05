//
//  BlockGameDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/13.
//
import SwiftUI
import AVFoundation


struct BlockGameDemoView: View {
    let images = ["🍎", "🍐", "🍊", "🍇", "🍉", "🍌", "🍅", "🍆"]
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .gray]
    
    // 存储所有方块的数组
    @State var blocks: [Block] = []
    // 存储选择的方块的数组
    @State var selectedBlocks: [Block] = []
    // 存储当前得分
    @State var score = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            // 显示当前得分
            Text("得分: \(score)")
                .font(.system(.largeTitle))
                .foregroundColor(.cyan)
                .fontWeight(.light)
            
            // 展示所有方块
            GridStack(rows: 5, columns: 5) { row, col in
                ZStack {
                    // 获取方块数据
                    if let block = self.getBlock(at: row * 5 + col) {
                        
                        // 绘制方块
                        Rectangle()
                            .fill(block.color.opacity(0.8))
                            .padding(1)
                            .cornerRadius(10)
                            .overlay(
                                Text(block.image)
                                    .font(.largeTitle)
                            )
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                self.selectBlock(block)
                            }
                            .opacity(block.opacity)
                    }
                }
            }
            
            Spacer()
            
            // 展示已选择的方块
            HStack(spacing: 20) {
                ForEach(selectedBlocks, id: \.id) { block in
                    ZStack {
                        Rectangle()
                            .fill(block.color)
                            .cornerRadius(10)
                            .overlay(
                                Text(block.image)
                                    .font(.largeTitle)
                            )
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "xmark.circle")
                            .onTapGesture {
                                self.removeBlock(block)
                            }
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding(10)
        .onAppear {
            for _ in 0..<25 {
                let image = images.randomElement()!
                let color = colors.randomElement()!
                self.blocks.append(Block(image: image, color: color, opacity: 1, selected: false))
                print(">>> blocks:\(self.blocks.count)")
            }
        }
    }
    
    
    
    
    struct Block: Identifiable, Equatable {
        let id = UUID()
        let image: String
        let color: Color
        var opacity: Double
        var selected: Bool
    }
    
    
    
    struct GridStack<Content: View>: View {
        let rows: Int
        let columns: Int
        let content: (Int, Int) -> Content
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(row, column)
                        }
                    }
                }
            }
        }
        
        init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
            self.rows = rows
            self.columns = columns
            self.content = content
        }
    }
    
    // 获取某一位置上的方块
    func getBlock(at index: Int) -> Block? {
        return !self.blocks.isEmpty ? self.blocks[index] : nil
    }
    
    // 选择方块
    func selectBlock(_ block: Block) {
        var block = block
        // 如果当前已选择的方块少于 3 个，将该方块加入已选择区域中
        if selectedBlocks.count < 3 {
            block.opacity = 0.5
            block.selected = true
            self.selectedBlocks.append(block)
        }
        // 如果选择的方块数量为 3 个，判断是否可以消除
        if selectedBlocks.count == 3 {
            if isMatched() {
                // 消除已选择方块
                removeSelectedBlocks()
                self.score += 10
            } else {
                // 未匹配，重置所有已选择方块
                resetSelectedBlocks()
            }
        }
    }
    
    // 移除方块
    func removeBlock(_ block: Block) {
        if let index = self.selectedBlocks.firstIndex(of: block) {
            self.selectedBlocks.remove(at: index)
            self.blocks[index].opacity = 1
            self.blocks[index].selected = false
        }
    }
    
    // 判断所选方块是否可以消除
    func isMatched() -> Bool {
        return self.selectedBlocks[0].image == self.selectedBlocks[1].image && self.selectedBlocks[1].image == self.selectedBlocks[2].image
    }
    
    // 移除已选择的方块
    func removeSelectedBlocks() {
        for block in self.selectedBlocks {
            if let index = self.blocks.firstIndex(of: block) {
                self.blocks.remove(at: index)
            }
        }
        self.selectedBlocks.removeAll()
    }
    
    // 重置所有已选择方块
    func resetSelectedBlocks() {
        for index in self.blocks.indices {
            self.blocks[index].opacity = 1
            self.blocks[index].selected = false
        }
        self.selectedBlocks.removeAll()
    }
    
}

struct BlockGameDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BlockGameDemoView()
    }
}
