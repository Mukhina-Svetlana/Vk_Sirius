//
//  NetworkServices.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import Foundation

class NetworkServices {
    private init() {}
    static let shared = NetworkServices()
    var alert: (() -> Void)?
    
    func getData(completion: @escaping ([Model]) -> Void) {
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else { return }
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let currentModel = self.parsJson(withData: data) {
                        completion(currentModel)
                    }
                } else if error != nil {
                    self.alert!()
                }
            }
        }
        task.resume()
    }
    
    private func parsJson(withData data: Data) -> [Model]? {
        let decoder = JSONDecoder()
        do {
            let currentData = try decoder.decode(ModelFromURL.self, from: data)
            let currentDataModelServices = currentData.body.services
            var arrayInfoData = [Model]()
            for i in currentDataModelServices{
                arrayInfoData.append(Model(data: i))
            }
            return arrayInfoData
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
}

