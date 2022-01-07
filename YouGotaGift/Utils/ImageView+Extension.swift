//
//  ImageView+Extension.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    @discardableResult
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return nil
        }
        guard let url = URL(string: urlString) else {
            return nil
        }
        if let placeholder = placeholder {
            self.image = placeholder
            self.tintColor = .black
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
