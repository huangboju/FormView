//
//  Row.swift
//  FormView
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

struct NoneItem {}

protocol Updatable: class {
    
    associatedtype ViewData
    
    func update(viewData: ViewData)
}

extension Updatable {
    func update(viewData: NoneItem) {}
}

protocol RowType {
    
    var tag: RowTag { get }

    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }

    func update(cell: UITableViewCell)

    func cell<C: UITableViewCell>() -> C
    func cellItem<M>() -> M
}

class Row<Cell> where Cell: Updatable, Cell: UITableViewCell {

    let tag: RowTag

    let viewData: Cell.ViewData
    let reuseIdentifier = "\(Cell.classForCoder())"
    let cellClass: AnyClass = Cell.self
    
    init(viewData: Cell.ViewData, tag: RowTag = .none) {
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

public class RowTags {
    fileprivate init() {}
}

public class RowTag: RowTags {
    public let _key: String
    
    public init(_ key: String) {
        self._key = key
        super.init()
    }
}

extension RowTag: Hashable {
    public static func ==(lhs: RowTag, rhs: RowTag) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_key)
    }
}

extension RowTags {
    static let none = RowTag("")
}

