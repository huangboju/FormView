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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)

        for i in 0 ..< 20 {
            let row: RowType
            if i & 1 == 0 {
                row = generatTwoImageRow()
            } else {
                row = generatImageRow()
            }
            tableView.register(row.cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            viewModel.rows.append(row)
        }
    }
    
    func generatTwoImageRow() -> Row<TwoImageCell> {
        let row = Row<TwoImageCell>(viewData: NoneItem())
        return row
    }

    func generatImageRow() -> Row<ImageCell> {
        let row = Row<ImageCell>(viewData: NoneItem())
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
