//
//  MyQrViewNativeView.swift
//  Runner
//
//  Created by Nobody on 17/02/23.
//


import Flutter
import UIKit

class MyQrViewNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        
        if let args = args as? Dictionary<String, Any>,
           let textValue = args["text"] as? String, let widthValue = args["width"] as? Double, let heightValue = args["height"] as? Double {
            createNativeView(view: _view,text: textValue,width: widthValue,height: heightValue)
        }
        
        
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView,text: String,width: Double,height: Double){
        let imageView = UIImageView()
        
        imageView.frame = CGRect(x: 0, y: 0,width: width,height: height)
        imageView.image = generateQRCode(from: text)
        _view.addSubview(imageView)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
