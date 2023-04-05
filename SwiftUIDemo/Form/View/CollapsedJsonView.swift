//
//  CollapsedJsonView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/28.
//
import SwiftUI

struct CollapsedJsonView: View {
    // 树形结构的根节点
    let rootNode: TheTreeNode
    
    init() {
        // 待展示的JSON数据
        let jsonData = """
            {
                "store": {
                    "book": [
                        {
                            "category": "reference",
                            "author": "Nigel Rees",
                            "title": "Sayings of the Century",
                            "price": 8.95
                        },
                        {
                            "category": "fiction",
                            "author": "Evelyn Waugh",
                            "title": "Sword of Honour",
                            "price": 12.99
                        },
                        {
                            "category": "fiction",
                            "author": "Herman Melville",
                            "title": "Moby Dick",
                            "isbn": "0-553-21311-3",
                            "price": 8.99
                        },
                        {
                            "category": "fiction",
                            "author": "J. R. R. Tolkien",
                            "title": "The Lord of the Rings",
                            "isbn": "0-395-19395-8",
                            "price": 22.99
                        }
                    ],
                    "bicycle": {
                        "color": "red",
                        "price": 19.95
                    }
                },
                "expensive": 10
            }
            """
        let data = jsonData.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        self.rootNode = TheTreeNode(name: "root", value: jsonObject)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollView {
                // 展示树形结构
                TreeView(root: rootNode)
            }
            .padding()
        }
    }
}

struct TreeView: View {
    @State var collapsed: Bool = false
    
    let root: TheTreeNode
    
    var body: some View {
        VStack {
            // 节点名称和类型
            HStack {
                Button(action: {
                    // 点击按钮折叠或展开节点
                    withAnimation(.default) {
                        collapsed.toggle()
                    }
                }, label: {
                    Image(systemName: collapsed ? "arrowtriangle.forward.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 8, height: 8)
                        .padding(5)
                        .foregroundColor(.gray)
                    Text("\(root.name):")
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                    // Text("\(root.valueTypeName)").foregroundColor(.secondary)
                })
                Spacer()
            }
            .padding(.leading, 10)
            
            if !collapsed {
                VStack(spacing: 0) {
                    // 如果节点未折叠，则递归展示子节点
                    ForEach(root.children) { child in
                        if child.isLeaf {
                            // 如果节点是叶子节点，则展示节点名称和值
                            HStack {
                                Text("\(child.name):")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.purple)
                                Text("\(child.value as! NSObject)")
                                    .foregroundColor(getValueColor(value: child.value))
                                    .lineLimit(1)
                                // Text("\(child.valueTypeName)")
                                Spacer()
                            }
                            .padding(.leading, 30)
                            
                        } else {
                            // 如果节点不是叶子节点，则使用递归方法展示子节点
                            TreeView(root: child)
                                .padding(.leading, 10)
                        }
                    }
                }
                .dashedLine()
                .padding(.leading, 18.5)
            }
        }
    }
}

func getValueColor(value: Any?) -> Color {
    if value is NSNull {
        return .orange
    } else if value is Bool {
        return .pink
    } else if value is Double || value is Int || value is Float {
        return .cyan
    } else if value is String {
        return .green
    } else {
        return .gray
    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

struct DashedLineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            DashedLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
                .foregroundColor(.gray)
        )
    }
}

extension View {
    func dashedLine() -> some View {
        self.modifier(DashedLineModifier())
    }
}

// 代表树形结构的节点
class TheTreeNode: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let value: Any?
    
    init(name: String, value: Any?) {
        self.name = name
        self.value = value
    }
    
    // 是否是叶子节点
    var isLeaf: Bool {
        value is NSNull || value == nil || isPrimitive(value)
    }
    
    // 如果是NSDictionary或NSArray，则返回子节点数组
    var children: [TheTreeNode] {
        if let dict = value as? NSDictionary {
            return dict.map { k, v in TheTreeNode(name: k as! String, value: v) }.sorted { $0.name < $1.name }
        } else if let array = value as? [Any] {
            return array.enumerated().map { index, value in TheTreeNode(name: "[\(index)]", value: value) }
        } else {
            return []
        }
    }
    
    // 值的类型名称
    var valueTypeName: String {
        if value == nil {
            return "nil"
        } else if value is NSNull {
            return "null"
        } else {
            return String(describing: Mirror(reflecting: value!).subjectType)
        }
    }
    
    // 是否是原始数据类型
    private func isPrimitive(_ value: Any?) -> Bool {
        if let value = value {
            switch value {
            case is Bool, is Int, is Double, is Float, is String:
                return true
            default:
                return false
            }
        }
        return false
    }
}

struct CollapsedJsonView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsedJsonView()
    }
}
