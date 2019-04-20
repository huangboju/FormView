//
//  AccountTitleCell.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

struct Queue<T> {
    private var arr: [T?] = []
    private var head = 0
    
    var isEmpty: Bool {
        return arr.isEmpty
    }
    
    var count: Int {
        return arr.count - head
    }
    
    mutating func enqueue(_ elemet: T) {
        arr.append(elemet)
    }
    
    mutating func dequeue() -> T? {
        guard arr.count > head, let element = arr[head] else {
            return nil
        }
        arr[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(arr.count)
        if arr.count > 50 && percentage > 0.25 {
            arr.removeFirst(head)
            head = 0
        }
        return element
    }
}



struct TitleCellItem {
    let title: String
}

class TitleCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
