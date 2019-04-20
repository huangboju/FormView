//
//  LicenseCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

class LicenseCell: UITableViewCell, Updatable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        textLabel?.textColor = UIColor(white: 0.8, alpha: 1)
        textLabel?.font = UIFont.systemFont(ofSize: 14)
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.text = "By signing up, you agree to the Terms & Privacy Policy."
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
