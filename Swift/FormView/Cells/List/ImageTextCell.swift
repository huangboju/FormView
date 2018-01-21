//
//  ImageTextCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

class ImageTextCell: UITableViewCell {
    private lazy var firstImageView: UIImageView = {
        let imageView = UIHelper.generateImageView()
        imageView.backgroundColor = UIColor(hex: 0x4169E1)
        return imageView
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(firstImageView)
        firstImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        firstImageView.widthAnchor.constraint(equalTo: firstImageView.heightAnchor).isActive = true
        firstImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        firstImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        contentView.addSubview(contentLabel)
        contentLabel.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 15).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
