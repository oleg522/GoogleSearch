//
//  UIImageView.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 17.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
