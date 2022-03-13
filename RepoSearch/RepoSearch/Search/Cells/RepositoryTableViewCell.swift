//
//  RepositoryTableViewCell.swift
//  RepoSearch
//
//  Created by Sun Bin Kim on 13.03.22.
//

import UIKit
import DomainLayer

final class RepositoryTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint
        ])
        
        return imageView
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var repoURLLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var repoTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with repository: Repository) {
        if let avatarImageData = repository.avatarImageData {
            avatarImageView.image = UIImage(data: avatarImageData)
        }
        
        ownerNameLabel.text = repository.ownerName
        repoNameLabel.text = repository.name
        repoTitleLabel.text = repository.title
        repoURLLabel.text = repository.url.absoluteString
        repoDescriptionLabel.text = repository.description ?? "No Description"
    }
    
}

private extension RepositoryTableViewCell {
    
    func layout() {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.spacing = 4
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            createInformationStackView(with: "Owner", informationLabel: ownerNameLabel),
            createInformationStackView(with: "Name", informationLabel: repoNameLabel),
            createInformationStackView(with: "Title", informationLabel: repoTitleLabel),
        ].forEach(informationStackView.addArrangedSubview)
        
        let imageStackView = UIStackView()
        imageStackView.axis = .vertical
        
        [
            avatarImageView
        ].forEach(imageStackView.addArrangedSubview)
        imageStackView.alignment = .center
        
        let informationView = UIView()
        informationView.addSubview(informationStackView)
        
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: informationView.trailingAnchor),
            informationStackView.centerYAnchor.constraint(equalTo: informationView.centerYAnchor)
        ])
        
        let upperStackView = UIStackView()
        upperStackView.axis = .horizontal
        upperStackView.spacing = 4
        
        [
            imageStackView,
            informationView
        ].forEach(upperStackView.addArrangedSubview)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .boldSystemFont(ofSize: 15)
        
        let urlLabel = UILabel()
        urlLabel.text = "URL"
        urlLabel.font = .boldSystemFont(ofSize: 15)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        
        [
            upperStackView,
            urlLabel,
            repoURLLabel,
            descriptionLabel,
            repoDescriptionLabel
        ].forEach(mainStackView.addArrangedSubview)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func createInformationStackView(with title: String, informationLabel: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .top
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = title
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        [
            titleLabel,
            informationLabel,
            UIView()
        ].forEach(stackView.addArrangedSubview)
        
        return stackView
    }
    
}
