//
//  ImageCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

class ImageCell: UITableViewCell, Updatable {
    private var imageViews: [UIImageView] = []
    
    private let max = 2
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUIWithDummyView()
//        setupUIWithStackView()
    }
    
    func setupUIWithStackView() {
        imageViews = (0..<max).map { _ in UIHelper.generatImageView() }
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    func setupUIWithDummyView() {

        let containerLayout = UILayoutGuide()
        contentView.addLayoutGuide(containerLayout)
        containerLayout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerLayout.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        containerLayout.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerLayout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        for i in 0 ..< max {
            let layoutGuide = UILayoutGuide()
            contentView.addLayoutGuide(layoutGuide)

            let imageView = UIHelper.generatImageView()
            contentView.addSubview(imageView)

            imageView.topAnchor.constraint(equalTo: containerLayout.topAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: containerLayout.centerYAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            if i == 0 {
                layoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                layoutGuide.widthAnchor.constraint(equalToConstant: 15).isActive = true
                layoutGuide.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            } else {
                layoutGuide.leadingAnchor.constraint(equalTo: imageViews[i - 1].trailingAnchor).isActive = true
                layoutGuide.widthAnchor.constraint(equalToConstant: 15).isActive = true
                layoutGuide.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true

                if i == max - 1 {
                    // 最后一个
                    let lastGuide = UILayoutGuide()
                    contentView.addLayoutGuide(lastGuide)
                    lastGuide.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
                    lastGuide.widthAnchor.constraint(equalToConstant: 15).isActive = true
                    layoutGuide.trailingAnchor.constraint(equalTo: containerLayout.trailingAnchor).isActive = true
                }
            }

            imageViews.append(imageView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
