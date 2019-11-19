//
//  extension.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit
import SDWebImage
var vSpinner : UIView?
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
            let url = URL(string: imageUrlString)
            self.sd_setImage(with: url, placeholderImage: placeHolder, options: .continueInBackground, completed: nil)
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
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

