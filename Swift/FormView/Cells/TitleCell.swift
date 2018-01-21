//
//  AccountTitleCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import UIKit

struct TitleCellItem {
    let title: String
}

class TitleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleCell: Updatable {
    func update(viewData: TitleCellItem) {
        textLabel?.text = viewData.title
    }
}
