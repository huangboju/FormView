//
//  MarkdownCell.swift
//  FormView
//
//  Created by 黄伯驹 on 2025/6/6.
//  Copyright © 2025 黄伯驹. All rights reserved.
//

import UIKit
import SnapKit
import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    @State var markdownString: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Markdown {
                markdownString
            }
            .textSelection(.enabled)
            .markdownTheme(.gitHub)
            Spacer()
        }
    }
}

class MarkdownCell: UITableViewCell, Updatable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGreen
        
        let markdownString = """
            You can make an unordered list by preceding one or more lines of text with `-`, `*`, or `+`.

            ```
            - George Washington
            - John Adams
            - Thomas Jefferson
            ```

            - George Washington
            - John Adams
            - Thomas Jefferson

            To order your list, precede each line with a number.

            ```
            1. James Madison
            2. James Monroe
            3. John Quincy Adams
            ```

            1. James Madison
            2. James Monroe
            3. John Quincy Adams

            ## Nested Lists

            You can create a nested list by indenting one or more list items below another item.

            ```
            1. First list item
               - First nested list item
                 - Second nested list item
            ```

            1. First list item
               - First nested list item
                 - Second nested list item

            ## Task lists

            To create a task list, preface list items with a hyphen and space followed by [ ].
            To mark a task as complete, use [x].

            ```
            - [x] Markdown rendering and styling
            - [ ] Documentation and sample code
            - [ ] Release MarkdownUI 2.0
            ```

            - [x] Markdown rendering and styling
            - [ ] Documentation and sample code
            - [ ] Release MarkdownUI 2.0

            Note that the `DocC` theme doesn't have a task list marker style and uses simple
            bullets.
            """

        // Create the SwiftUI view and pass the markdown content
        let markdownView = MarkdownView(markdownString: markdownString)


        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: markdownView)
        
        // https://medium.com/arcush-tech/two-pitfalls-to-avoid-when-working-with-uihostingcontroller-534d1507563e
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .intrinsicContentSize
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 16.4, *) {
            hostingController.safeAreaRegions = []
        } else {
            // Fallback on earlier versions
        }
        
        let panelView = UIView()
        contentView.addSubview(panelView)
        panelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        panelView.addSubview(hostingController.view)
        hostingController.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
