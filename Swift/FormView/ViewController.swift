//
//  ViewController.swift
//  FormView
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

class ViewController: GroupTableController {

    override func initSubviews() {
        form = [
            [
                XYRow<MainCell>(viewData: MainCellItem(dest: .dest(DetailController.self)))
            ],
            
            [
                XYRow<MainCell>(viewData: MainCellItem(dest: .dest(ListController.self)))
            ],
            [
                XYRow<MainCell>(viewData: MainCellItem(dest: .dest(EventController.self)))
            ]
        ]
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let item: MainCellItem = row(at: indexPath).cellItem()
        transion(to: item.dest)
    }
}

