//
//  Row.swift
//  FormView
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import UIKit

struct NoneItem {}

protocol Updatable: class {
    
    associatedtype ViewData
    
    func update(viewData: ViewData)
}

extension Updatable {
    func update(viewData: NoneItem) {}
}

protocol RowType {
    
    var tag: String { get }
    
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }

    func update(cell: UITableViewCell)

    func cell<C: UITableViewCell>() -> C
    func cellItem<M>() -> M
}

class Row<Cell> where Cell: Updatable, Cell: UITableViewCell {

    let tag: String
    
    let viewData: Cell.ViewData
    let reuseIdentifier = "\(Cell.classForCoder())"
    let cellClass: AnyClass = Cell.self
    
    init(viewData: Cell.ViewData, tag: String = "") {
        self.viewData = viewData
        self.tag = tag
    }

    func cell<C: UITableViewCell>() -> C {
        guard let cell = _cell as? C else {
            fatalError("cell 类型错误")
        }
        return cell
    }
    
    func cellItem<M>() -> M {
        guard let cellItem = viewData as? M else {
            fatalError("cellItem 类型错误")
        }
        return cellItem
    }

    private var _cell: Cell?

    func update(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            self._cell = cell
            cell.update(viewData: viewData)
        }
    }
}

extension Row: RowType {}


