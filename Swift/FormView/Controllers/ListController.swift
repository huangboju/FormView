//
//  ListController.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import UIKit
import GameplayKit

class ListController: UIViewController {
    
    let viewModel = ListViewModel()

    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = viewModel
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)

        initData()
    }

    func initData() {
        for _ in 0 ..< 20 {
            let row: RowType
            let i = arc4random_uniform(3)
            if i == 0 {
                row = generateTwoImageRow()
            } else if i == 1 {
                row = generateImageTextCellRow()
            } else {
                row = generateImageRow()
            }
            tableView.register(row.cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            viewModel.rows.append(row)
        }
    }
    
    func generateTwoImageRow() -> XYRow<TwoImageCell> {
        let row = XYRow<TwoImageCell>(viewData: NoneItem())
        return row
    }
    
    func generateImageTextCellRow() -> XYRow<ImageTextCell> {
        let item = ImageTextCellItem(imageName: "flappy", text: "Pablo Ruiz y Picasso (25 October 1881 – 8 April 1973), also known as Pablo Picasso, was a Spanish painter, sculptor, printmaker, ceramicist, stage designer, poet and playwright who spent most of his adult life in France.")
        let row = XYRow<ImageTextCell>(viewData: item)
        return row
    }

    func generateImageRow() -> XYRow<ImageCell> {
        let row = XYRow<ImageCell>(viewData: NoneItem())
        return row
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

class ListViewModel: NSObject, UITableViewDataSource {
    public var rows: [RowType] = []

    public func row(at indexPath: IndexPath) -> RowType {
        return rows[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
        cellConfigurator.update(cell: cell)
        return cell
    }
}
