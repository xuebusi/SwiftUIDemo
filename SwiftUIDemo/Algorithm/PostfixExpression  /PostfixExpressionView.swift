//
//  PostfixExpressionView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/8.
//

import SwiftUI

struct PostfixExpressionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景颜色
                Color.purple.ignoresSafeArea()
                CalculatorView()
            }
            .navigationTitle("简易计算器")
        }
    }
}

// MARK: 使用后缀表达式实现简单的算术表达式运算
struct CalculatorView: View {
    /// 合法的字符数组，用于校验输入的字符是否在合法范围内
    let legalChars: [String] = ["+", "-", "*", "/", "(", ")", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    /// 表达式
    @State var expression = ""
    /// 计算结果
    @State var result = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("支持小括号优先级运算，暂不支持小数和负数")
                    .font(.system(.callout))
                TextField("输入算术表达式", text: $expression, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(3)
                
                HStack {
                    /// 开始计算按钮
                    Button {
                        self.expression.replace(" ", with: "")
                        if self.expression.isEmpty {
                            self.result = "表达式不能为空"
                            return
                        }
                        let arr = expression.split(separator: "")
                        for c in arr {
                            if !legalChars.contains(String(c)) {
                                self.result = "表达式非法"
                                return
                            }
                        }
                        if arr.first == "-" {
                            self.result = "暂不支持输入负数"
                            return
                        }
                        
                        self.result = String(evaluate(self.expression))
                        // 除数为0的时候，给出提示
                        self.result = self.result == "inf" ? "除数不能为0" : self.result
                    } label: {
                        Text("开始计算")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.primary)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    /// 清空按钮
                    Button {
                        self.expression = ""
                        self.result = ""
                    } label: {
                        Text("清空")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.primary)
                    .cornerRadius(10)
                    
                }
                
                // 显示计算结果区域
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .cornerRadius(10)
                    .overlay(alignment: .top) {
                        Text("\(self.result.isEmpty ? "计算结果" : self.result)")
                            .padding()
                            .foregroundColor(.purple)
                    }
            }
            .padding()
            .font(.system(size: 25))
            .fontWeight(.light)
            .animation(Animation.default, value: self.result)
        }
    }
}

// MARK: 以下是实现后缀表达式运算的算法，支持小括号优先级运算，暂不支持小数和负数：

/// 该函数的功能是将中缀表达式转换为后缀表达式
/// 在转换时，使用栈来保存运算符，如果是数字则直接加入后缀表达式中。
/// 如果当前处理的字符是运算符，那么查看栈顶的运算符的优先级，
/// 如果当前运算符的优先级小于等于栈顶元素的优先级，则将栈顶元素弹出并加入后缀表达式中，
/// 直到栈顶元素优先级小于当前运算符或栈为空。
/// 如果当前运算符是左括号，则将其入栈；如果是右括号，
/// 则将栈顶元素弹出并加入后缀表达式中，直到遇到左括号为止。
func evaluate(_ s: String) -> Double {
    var stack = [Character]()
    var postfix = [String]()
    let operators = ["+", "-", "*", "/", "(", ")"]
    var num = ""
    
    for c in s {
        if operators.contains(String(c)) {
            if !num.isEmpty {
                postfix.append(num)
                num = ""
            }
            if c == "(" {
                stack.append(c)
            } else if c == ")" {
                while let top = stack.last, top != "(" {
                    postfix.append(String(stack.removeLast()))
                }
                stack.removeLast()
            } else {
                while let top = stack.last, top != "(", getPriority(c) <= getPriority(top) {
                    postfix.append(String(stack.removeLast()))
                }
                stack.append(c)
            }
        } else {
            num.append(c)
        }
    }
    
    if !num.isEmpty {
        postfix.append(num)
    }
    
    while stack.last != nil {
        postfix.append(String(stack.removeLast()))
    }
    
    return calculate(postfix.joined(separator: " "))
}

// MARK: 该函数的功能是对后缀表达式执行运算，得到最终结果
func calculate(_ s: String) -> Double {
    print(">>>> \(s)")
    var stack = [Double]()
    let tokens = s.split(separator: " ")
    
    for token in tokens {
        if let num = Double(token) {
            stack.append(Double(num))
        } else {
            let b = stack.removeLast()
            let a = stack.removeLast()
            switch token {
            case "+":
                stack.append(a + b)
            case "-":
                stack.append(a - b)
            case "*":
                stack.append(a * b)
            case "/":
                stack.append(a / b)
            default:
                break
            }
        }
    }
    
    return stack.last!
}

// MARK: 获取操作符优先级
func getPriority(_ c: Character) -> Int {
    switch c {
    case "*", "/":
        return 2
    case "+", "-":
        return 1
    default:
        return 0
    }
}

struct PostfixExpressionView_Previews: PreviewProvider {
    static var previews: some View {
        PostfixExpressionView()
    }
}
