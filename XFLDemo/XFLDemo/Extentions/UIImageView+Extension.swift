//
//  UIImageView+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

extension UIImageView {
    
    func downloaded(url: String, mode: UIView.ContentMode = .scaleAspectFit) {
        DispatchQueue.main.async() {
            self.image = UIImage(named: "image_placeholder")
        }
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
            
        }.resume()
    }
}
