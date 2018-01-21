//
//  InputCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

struct InputCellItem {
    let placeholder: String
    let inputText: String
    
    init(placeholder: String, inputText: String = "") {
        self.placeholder = placeholder
        self.inputText = inputText
    }
}

class InputCell: UITableViewCell {

    public var inputText: String {
        set {
            textField.text = inputText
        }
        get {
            return textField.text ?? ""
        }
    }

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputCell: Updatable {
    func update(viewData: InputCellItem) {
        textField.placeholder = viewData.placeholder
    }
}
