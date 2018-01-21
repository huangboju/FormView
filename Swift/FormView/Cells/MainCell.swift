//
//  MainCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import UIKit

struct MainCellItem {
    let title: String
    let dest: Dest
}

class MainCell: UITableViewCell {}

extension MainCell: Updatable {
    func update(viewData: MainCellItem) {
        textLabel?.text = viewData.title
        accessoryType = .disclosureIndicator
    }
}
