//
//  CustomDropdownPair.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/13.
//

import SwiftUI

struct HeaderPairDropdownView: View {
    @State var params: [HeaderParam] = [/*HeaderParam(key: "", value: "")*/]
    
    @State var keys: [String] = ["Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language"]
    @State var keyPlacehoder: String = "Key"
    
    @State var values: [String] = ["1", "2", "3", "4"]
    @State var valuePlacehoder: String = "Value"
    
    @State var showDisplay: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button(action: {
                params.append(HeaderParam(key: "", value: ""))
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill").foregroundColor(.green)
                    Text("添加路径参数")
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(params.indices, id: \.self) { index in
                HStack {
                    CustomDropdownPairView(
                        keys: $keys,
                        selectedKey: self.$params[index].key,
                        keyPlacehoder: $keyPlacehoder,
                        values: $values,
                        selectedValue: self.$params[index].value,
                        valuePlacehoder: $valuePlacehoder
                    )
                    
                    Button {
                        params.remove(at: index)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                    }
                    .foregroundColor(.red)
                    .frame(width: 20, height: 20)
                    .opacity(params.count == 1 ? 0 : 1)
                }
            }
            
            /**
             Button(action: {
             showDisplay.toggle()
             }, label: {
             Text("显示输入的参数")
             })
             
             if showDisplay {
             if !params.isEmpty {
             VStack(alignment: .leading) {
             ForEach(params) { param in
             if !param.key.isEmpty {
             Text("\(param.key)=\(param.value)")
             }
             }
             }
             }
             }
             */
            Spacer()
        }
        .padding()
    }
}

struct CustomDropdownPairView: View {
    // ["Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language"]
    @Binding var keys: [String]
    @Binding var selectedKey: String
    // "key"
    @Binding var keyPlacehoder: String
    
    // ["1", "2", "3", "4"]
    @Binding var values: [String]
    @Binding var selectedValue: String
    // "value"
    @Binding var valuePlacehoder: String
    
    var body: some View {
        CustomDropdownPair(keys: $keys, selectedKey: $selectedKey, keyPlacehoder: $keyPlacehoder, values: $values, selectedValue: $selectedValue, valuePlacehoder: $valuePlacehoder)
    }
}

struct CustomDropdownPair: View {
    @Binding var keys: [String]
    @Binding var selectedKey: String
    @Binding var keyPlacehoder: String
    
    @Binding var values: [String]
    @Binding var selectedValue: String
    @Binding var valuePlacehoder: String
    
    var body: some View {
        HStack {
            CustomDropdown(items: $keys, selectedItem: $selectedKey, placeholder: $keyPlacehoder)
            CustomDropdown(items: $values, selectedItem: $selectedValue, placeholder: $valuePlacehoder)
        }
    }
}

struct CustomDropdown: View {
    @Binding var items: [String]
    @Binding var selectedItem: String
    @Binding var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $selectedItem)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(alignment: .trailing) {
                if selectedItem.isEmpty {
                    Menu {
                        ForEach(items, id: \.self) { item in
                            Button(item) {
                                self.selectedItem = item
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.down.circle")
                            .foregroundColor(.cyan)
                    }
                    .padding(.trailing, 10)
                    // .opacity(selectedItem.isEmpty ? 1 : 0)
                    
                } else {
                    Button {
                        selectedItem = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                        // .opacity(selectedItem.isEmpty ? 0 : 1)
                            .background(
                                Circle()
                                    .fill(.white), alignment: .leading
                            )
                    }
                    .padding(.trailing, 10)
                }
                
            }
    }
}

struct HeaderParam: Identifiable, Hashable, Codable {
    var id = UUID()
    var key: String = ""
    var value: String = ""
}

struct CustomDropdownPairView_Previews: PreviewProvider {
    static var previews: some View {
        //        CustomDropdownPairView()
        HeaderPairDropdownView()
    }
}
