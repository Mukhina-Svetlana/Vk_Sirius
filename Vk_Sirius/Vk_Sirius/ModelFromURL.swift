//
//  ModelFromURL.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import Foundation

struct ModelFromURL: Decodable {
    let body: Body
}

struct Body: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let name, serviceDescription: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case serviceDescription = "description"
        case link
        case iconURL = "icon_url"
    }
}
