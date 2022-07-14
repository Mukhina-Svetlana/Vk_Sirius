//
//  ViewController.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var models = [Model]()
    private lazy var cellIdentity = "cell"
    
    private lazy var actyvityIndicator: UIActivityIndicatorView = {
        let activ = UIActivityIndicatorView()
        activ.translatesAutoresizingMaskIntoConstraints = false
        return activ
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 75
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentity)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        actyvityIndicator.hidesWhenStopped = true
        actyvityIndicator.startAnimating()
        configuration()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NetworkServices.shared.alert = {
            let alert = UIAlertController(title: "Ошибка!", message: "Запрос не может быть выполнен. Проверьте соединение!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            self.present(alert, animated: false, completion: nil)
        }
    }
}

extension MainViewController {
    private func configuration() {
        title = "Сервисы VK"
        view.addSubview(tableView)
        view.addSubview(actyvityIndicator)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            actyvityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actyvityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        actyvityIndicator.stopAnimating()
        cell.imageViewService.downloadImage(from: (URL(string: models[indexPath.row].imageServiceUrl) ?? URL(string: "https://proprikol.ru/wp-content/uploads/2020/08/krasivye-kartinki-kotov-46.jpg"))!)
        cell.textForEachCell(nameService: models[indexPath.row].labelService, descriptionService: models[indexPath.row].descriptionService)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let application = UIApplication.shared
        if let url = URL(string: "\(models[indexPath.row].labelService)://"), application.canOpenURL(url) {
                    application.open(url, options: [:], completionHandler: nil)
                } else if let itunesUrl = URL(string: models[indexPath.row].link), application.canOpenURL(itunesUrl) {
                   application.open(itunesUrl, options: [:], completionHandler: nil)
                }
    }
}

