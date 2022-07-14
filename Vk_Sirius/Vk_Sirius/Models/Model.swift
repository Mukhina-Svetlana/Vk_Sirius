//
//  Model.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import Foundation
import UIKit

struct Model {
    var labelService: String
    var descriptionService: String
    var imageServiceUrl: String
    var link: String
    
    init (data: Service) {
        labelService = data.name
        descriptionService = data.serviceDescription
        imageServiceUrl = data.iconURL
        link = data.link
    }
}
