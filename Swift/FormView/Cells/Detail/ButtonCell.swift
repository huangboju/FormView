//
//  ButtonCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

struct ButtonCellItem {
    let title: String
    let normalState: (UIColor, UIControlState)
    let highlightState: (UIColor, UIControlState)
}

@objc
protocol ButtonCellActionable {
    func buttonAction(_ sender: UIButton, cell: UITableViewCell)
}

class ButtonCell: UITableViewCell {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: 0xFF2238)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        // 这里传nil会走响应链
        // https://www.jianshu.com/p/fcb8bdd5078f
//        button.addTarget(nil, action: #selector(ButtonCellActionable.buttonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        let layoutGuide = UILayoutGuide()
        contentView.addLayoutGuide(layoutGuide)
        layoutGuide.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        layoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalToConstant: 44).isActive = true

        contentView.addSubview(button)
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        (self.viewController as? ButtonCellActionable)?.buttonAction(sender, cell: self)
    }
}

extension ButtonCell: Updatable {
    func update(viewData: ButtonCellItem) {
        button.setTitle(viewData.title, for: .normal)
        button.setTitleColor(viewData.normalState.0, for: viewData.normalState.1)
        button.setTitleColor(viewData.highlightState.0, for: viewData.highlightState.1)
    }
}
