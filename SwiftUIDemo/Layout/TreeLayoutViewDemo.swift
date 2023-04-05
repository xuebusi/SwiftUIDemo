// Author: SwiftUI-Lab (swiftui-lab.com)
// Description: A Tree Layout example
// blog article: https://swiftui-lab.com/layout-protocol-part-2

import SwiftUI

// 树形布局
struct TreeLayoutViewDemo: View {
    @State var nodeSeparation: CGFloat = 10.0
    @State var rowSeparation: CGFloat = 60.0
    
    @State var path: Path = Path()
    
    var body: some View {
        let dash = StrokeStyle(lineWidth: 2, dash: [3, 3], dashPhase: 0)
        
        VStack(spacing: 0) {
            ScrollView([.vertical, .horizontal]) {
                TreeLayout(nodeSeparation: nodeSeparation, rowSeparation: rowSeparation, linesPath: $path) {
                    ForEach(tree.flattenNodes) { node in
                        Text(node.name)
                            .padding(20)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(node.color.gradient)
                                    .shadow(radius: 3.0)
                            }
                            .node(node.id, parentId: node.parentId)
                    }
                }
                .background {
                    path.stroke(.gray, style: dash)
                }
                .padding(30)
                .background { Color.white }
                .border(.black)
                .padding(.bottom, 30)
                .bold()
                .foregroundColor(.white)
            }
            
            Slider(value: $nodeSeparation, in: 0...100) { Text("Node Separation: \(Int(nodeSeparation))")}.frame(width: 300)
            Slider(value: $rowSeparation, in: 0...100) { Text("Row Separation: \(Int(rowSeparation))")}.frame(width: 300)
                .padding(.bottom, 20)
        }
    }
    
}

struct TreeLayoutViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TreeLayoutViewDemo()
    }
}
struct TreeNode: Identifiable {
    var parentId: UUID? = nil
    let id: UUID = UUID()
    let name: String
    let color: Color
    
    var children: [TreeNode] = []
    
    var flattenNodes: [TreeNode] {
        var all = [self]
        
        for c in children {
            all.append(contentsOf: c.flattenNodes)
        }
        
        return all
    }
    
    mutating func populateParentNodeIds() {
        for idx in children.indices {
            children[idx].parentId = self.id
            children[idx].populateParentNodeIds()
        }
    }
}

let tree = {
    var root = TreeNode(name: "Animal Kingdom", color: .green, children: [
        TreeNode(name: "Arthropods", color: .blue, children: [
            TreeNode(name: "Arachnids", color: .cyan),
            TreeNode(name: "Crustaceans", color: .cyan),
            TreeNode(name: "Insects", color: .cyan),
            TreeNode(name: "Myriapods", color: .cyan),
            
        ]),
        TreeNode(name: "Vertebrates", color: .yellow, children: [
            TreeNode(name: "Amphibians", color: .red),
            TreeNode(name: "Birds", color: .red),
            TreeNode(name: "Fish", color: .red),
            TreeNode(name: "Mammals", color: .red, children: [
                TreeNode(name: "Canines", color: .orange),
                TreeNode(name: "Felines", color: .orange),
            ]),
            TreeNode(name: "Reptiles", color: .red),
        ]),
    ])
    
    root.populateParentNodeIds()
    
    return root
}()

struct ParentNodeId: LayoutValueKey {
    static var defaultValue: UUID? = nil
}

struct NodeId: LayoutValueKey {
    static var defaultValue: UUID? = nil
}

extension View {
    func node(_ id: UUID, parentId: UUID?) -> some View {
        self
            .layoutValue(key: NodeId.self, value: id)
            .layoutValue(key: ParentNodeId.self, value: parentId)
    }
}

extension LayoutSubview {
    var parentId: UUID? { self[ParentNodeId.self] }
    var nodeId: UUID? { self[NodeId.self] }
}

struct TreeLayout: Layout {
    var nodeSeparation: CGFloat = 5
    var rowSeparation: CGFloat = 40
    
    @Binding var linesPath: Path
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let root = subviews.first(where: { $0.parentId == nil }) else { return .zero }
        
        return computeSizeForTreeBranch(branchView: root, subviews: subviews)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        if let root = subviews.first(where: { $0.parentId == nil }) {
            var rects: [UUID:CGRect] = [:]
            
            _ = placeTree(in: bounds, view: root, subviews: subviews, rects: &rects)
            
            let newPath = buildLinesPath(in: bounds, view: root, subviews: subviews, rects: rects)
            
            // To avoid a layout loop, we only update the path, if it is
            // different than the current one.
            if newPath.description != linesPath.description {
                DispatchQueue.main.async {
                    linesPath = newPath
                }
            }
        }
    }
}

extension TreeLayout {
    func childViews(parentId: UUID?, subviews: LayoutSubviews) -> [LayoutSubview] {
        subviews.filter { $0.parentId == parentId }
    }
    
    func computeSizeForTreeBranch(branchView: LayoutSubview, subviews: LayoutSubviews) -> CGSize {
        let sizes = childViews(parentId: branchView.nodeId, subviews: subviews).map { v in
            computeSizeForTreeBranch(branchView: v, subviews: subviews)
        }
        
        let widthsSum = sizes.map { $0.width }.reduce(0) { $0 + $1 }
        let maxHeight = sizes.map { $0.height }.reduce(0) { max($0, $1) }
        
        let vSize = branchView.sizeThatFits(.unspecified)
        let w = max(vSize.width, widthsSum + nodeSeparation * max(CGFloat(sizes.count - 1), 0))
        let h = vSize.height + maxHeight + (sizes.count > 0 ? rowSeparation : 0)
        
        return CGSize(width: w, height: h)
    }
    
    func placeTree(in bounds: CGRect, view: LayoutSubview, subviews: LayoutSubviews, rects: inout [UUID:CGRect]) -> CGSize {
        let vsize = view.sizeThatFits(.unspecified)
        
        let pt = CGPoint(x: bounds.midX, y: bounds.minY)
        
        view.place(at: pt, anchor: .top, proposal: .unspecified)
        
        if let nodeId = view.nodeId {
            rects[nodeId] = CGRect(origin: CGPoint(x: bounds.midX - vsize.width / 2.0, y: bounds.minY),
                                   size: view.sizeThatFits(.unspecified))
        }
        
        let size = computeSizeForTreeBranch(branchView: view, subviews: subviews)
        
        let y = bounds.minY + view.sizeThatFits(.unspecified).height + rowSeparation
        
        let children = childViews(parentId: view.nodeId, subviews: subviews)
        
        var offset: CGFloat = 0
        
        for v in children {
            let r = CGRect(origin: CGPoint(x: bounds.minX + offset, y: y),
                           size: computeSizeForTreeBranch(branchView: v, subviews: subviews))
            
            let s = placeTree(in: r, view: v, subviews: subviews, rects: &rects)
            
            offset += s.width + nodeSeparation
        }
        
        return size
    }
    
    func buildLinesPath(in bounds: CGRect, view: LayoutSubview, subviews: LayoutSubviews, rects: [UUID:CGRect]) -> Path {
        
        var path = Path()
        
        guard let fromNodeId = view.nodeId else { return path }
        
        guard let fromRect = rects[fromNodeId] else { return path }
        
        for v in childViews(parentId: view.nodeId, subviews: subviews) {
            if let toNodeId = v.nodeId {
                
                if let toRect = rects[toNodeId] {
                    path.move(to: CGPoint(x: fromRect.midX, y: fromRect.midY))
                    path.addLine(to: CGPoint(x: toRect.midX, y: toRect.minY))
                }
                
                path.addPath(buildLinesPath(in: .zero, view: v, subviews: subviews, rects: rects))
            }
            
        }
        
        // Make sure the path has a (0,0) origin
        return path.offsetBy(dx: -bounds.minX, dy: -bounds.minY)
    }
}
