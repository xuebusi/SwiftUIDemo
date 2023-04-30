//
//  UIImagePickerControllerPresentableView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/24.
//

import Foundation
import SwiftUI

// 使用SwiftUI+UIKit实现图片选择
struct UIImagePickerControllerPresentableView: View {
    @State var showSheet: Bool = false
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(
                        Circle()
                    )
            } else {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }
            Button {
                showSheet.toggle()
            } label: {
                Text("选择相册图片")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                    .background(.cyan)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showSheet) {
                UIImagePickerControllerPresentable(image: $image, showScreen: $showSheet)
            }
            Spacer()
        }
        .padding()
    }
}

// 预览
struct UIViewControllerPresentableView_Previews: PreviewProvider {
    static var previews: some View {
        UIImagePickerControllerPresentableView()
    }
}

// 使用UIKit实现图片选择器
struct UIImagePickerControllerPresentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}


//struct UIViewControllerPresentableExample: UIViewControllerRepresentable {
//    let lableText: String
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let vc = MyFirstUIViewController()
//        vc.lableText = lableText
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//}
//
//class MyFirstUIViewController: UIViewController {
//    var lableText: String = "Startting value..."
//    override func viewDidLoad() {
//        view.backgroundColor = UIColor(.cyan)
//
//        let lable = UILabel()
//        lable.text = lableText
//        lable.textColor = UIColor(.black)
//
//        view.addSubview(lable)
//        lable.frame = view.frame
//    }
//}
