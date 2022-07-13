//
//  ViewController.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import UIKit

class MainViewController: UIViewController {
//    var models: [Model] = [ Model(labelService: "Vk", descriptionService: "gggbgbgvfvfv vffvf", imageService: "vk"), Model(labelService: "Ula", descriptionService: "ggbfvfvfv  bbfbfvdcdcdvbb vggvggvfh hvhfvfhv vhfvbfhv hvujbfjvb hvfjvbfjv gtvghjgbvgjvbgv vngjbn", imageService: "ula")
//    ]
    var models = [Model]()
    var images = [UIImage]()
    private lazy var cellIdentity = "cell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
      //  tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 85
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentity)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        

    }
}

extension MainViewController {
    private func configuration() {
        title = "Сервисы VK"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NetworkServices.shared.getData(completion: { model in
            self.models = model
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.textForEachCell(nameService: models[indexPath.row].labelService, descriptionService: models[indexPath.row].descriptionService, imageService: models[indexPath.row].imageService)
        cell.imageViewService.set(imageURL: models[indexPath.row].imageService) { [weak self] image in
            self?.images.append(image)
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
   
    
}

