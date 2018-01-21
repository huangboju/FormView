//
//  ViewController.swift
//  FormView
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import UIKit

class ViewController: GroupTableController {

    override func initSubviews() {
        form = [
            [
                Row<MainCell>(viewData: MainCellItem(title: "SignInController", dest: .dest(SignInController.self)))
            ]
        ]
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let row = self.row(at: indexPath)
        let item: MainCellItem = row.cellItem()
        transion(to: item.dest)
    }
}

