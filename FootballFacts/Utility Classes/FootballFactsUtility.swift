//
//  FootballFactsUtility.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 22/12/20.
//

import Foundation
import Alamofire
import SDWebImageSVGCoder

class FootballFactsUtility{
    
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func mainWindow() -> UIWindow {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!
    }
    
    class func isNetworkReachable() -> Bool{
        if (NetworkReachabilityManager()?.isReachable)!{
            return true
        }
        return false
    }
    
    class func getSvgImage(_ urlString: String) -> UIImage{
        let imageView = UIImageView()
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        let url = URL(string: urlString)
        imageView.sd_setImage(with: url!, placeholderImage: UIImage(named: "img_background"), completed: nil)
        return imageView.image!
    }
    
    class func addBlurToImage(image: UIImage) -> UIImage{
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: image)
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter?.setValue(10, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let outputImage = cropFilter!.outputImage
        let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        let processedImage = UIImage(cgImage: cgImage!)
        return processedImage
        
    }
    
}

