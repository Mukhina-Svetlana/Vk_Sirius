//
//  CustomImageViewAPI.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import UIKit

class CustomImageViewAPI: UIImageView  {
    
    func set(imageURL: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        let tast = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self!.image = UIImage(data: data)
                    completion((self?.image)!)
                }
            }
        }
        tast.resume()
    }
}
