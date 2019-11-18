//
//  extension.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UILabel {
    func setText(_ title : String? , _ heading : String){
        if let lableText = title {
            self.isHidden = false
            self.text = "\(heading) : \(lableText)"
        } else {
            self.isHidden = true
        }
    }
}

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String?, placeHolder: UIImage?) {
        if let imageUrlString = URLString {
            self.isHidden = false
            self.image = nil
            if let cachedImage = imageCache.object(forKey: NSString(string: imageUrlString)) {
                self.image = cachedImage
                return
            }
                DispatchQueue.global(qos: .background).async {
                if let url = URL(string: imageUrlString) {
                    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                        
                        //print("RESPONSE FROM API: \(response)")
                        if error != nil {
                            print("ERROR LOADING IMAGES FROM URL: \(error!.localizedDescription) \(imageUrlString)")
                            DispatchQueue.main.async {
                                self.image = placeHolder
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data {
                                if let downloadedImage = UIImage(data: data) {
                                    imageCache.setObject(downloadedImage, forKey: NSString(string: imageUrlString))
                                    self.image = downloadedImage
                                }
                            }
                        }
                    }).resume()
                }
            }

        } else {
            self.isHidden = true
        }
    }
}
extension UIViewController {
    func showAlert(_ errorMessage : String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
