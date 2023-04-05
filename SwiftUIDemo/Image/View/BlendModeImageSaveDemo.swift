//
//  BlendModeImageSaveDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/9.
//

import SwiftUI
import UIKit

struct BlendModeImageSaveDemo: View {
    var body: some View {
        VStack {
            BlendModeImageView()
            Button {
                let view = AnyView(BlendModeImageView())
                saveViewAsImage(view)
            } label: {
                Text("保存到相册")
            }
            
        }
    }
    
    func saveViewAsImage(_ view: AnyView) {
        let image = viewToImage(view: view)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    private func viewToImage(view: AnyView) -> UIImage {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let hosting = UIHostingController(rootView: view)
        hosting.view.frame = viewToCGRect(view: view)
        window.addSubview(hosting.view)
        
        var image: UIImage!
        
        UIGraphicsBeginImageContextWithOptions(hosting.view.frame.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            hosting.view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        hosting.view.removeFromSuperview()
        
        return image
    }
    
    private func viewToCGRect<V: SwiftUI.View>(view: V) -> CGRect {
        let controller = UIHostingController(rootView: view)
        controller.view.layoutIfNeeded()
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        return CGRect(origin: .zero, size: size)
    }
}


struct BlendModeImageView: View {
    var body: some View {
        ZStack {
            Image("TT")
                .resizable()
                .scaledToFit()
            
            Image("MyImg")
                .resizable()
                .scaledToFit()
                .blendMode(.colorDodge)
        }
    }
}

struct BlendModeImageSaveDemo_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeImageSaveDemo()
    }
}
