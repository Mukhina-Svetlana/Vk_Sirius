//
//  ImageFromUrl.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 14.07.2022.
//

import Foundation
import UIKit

class ImageFromUrl: UIImageView {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self!.image = UIImage(data: data)
            }
        }
    }
}
