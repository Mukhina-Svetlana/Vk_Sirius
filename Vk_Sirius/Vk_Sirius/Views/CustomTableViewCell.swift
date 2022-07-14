//
//  CustomTableViewCell.swift
//  Vk_Sirius
//
//  Created by Светлана Мухина on 13.07.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy private var labelNameService: UILabel = {
       let label = UILabel()
        label.layer.cornerRadius = 10
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy private var labelDescriptionService: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        //label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var imageViewService: CustomImageViewAPI = {
        let image = CustomImageViewAPI()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 13
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textForEachCell(nameService: String, descriptionService: String) {
        labelNameService.text = nameService
        labelDescriptionService.text = descriptionService
    }

}
extension CustomTableViewCell {
    private func configuration() {
        contentView.addSubview(labelNameService)
        contentView.addSubview(labelDescriptionService)
        contentView.addSubview(imageViewService)
        
        NSLayoutConstraint.activate([
            imageViewService.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageViewService.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageViewService.heightAnchor.constraint(equalToConstant: 70),
            imageViewService.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            imageViewService.widthAnchor.constraint(equalTo: imageViewService.heightAnchor),
            
            labelNameService.topAnchor.constraint(equalTo: imageViewService.topAnchor),
            labelNameService.leadingAnchor.constraint(equalTo: imageViewService.trailingAnchor, constant: 15),
            labelNameService.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            labelNameService.heightAnchor.constraint(equalToConstant: 19),
            
            
            labelDescriptionService.topAnchor.constraint(equalTo: labelNameService.bottomAnchor, constant: 3),
            labelDescriptionService.leadingAnchor.constraint(equalTo: labelNameService.leadingAnchor),
            labelDescriptionService.trailingAnchor.constraint(equalTo: labelNameService.trailingAnchor),
        ])
    }
}

