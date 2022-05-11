//
//  UIViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 11/5/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showToast(message : String, seconds: Double){
        let toastLabel = UILabel(frame: CGRect(x: 8, y: self.view.frame.size.height-80, width: self.view.frame.size.width-16, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: seconds, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func alertView(description: String){
        let ac = UIAlertController(title: "ERROR", message: description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(ac, animated: true)
    }
}
