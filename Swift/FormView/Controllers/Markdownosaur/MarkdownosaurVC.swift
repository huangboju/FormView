//
//  MarkdownosaurVC.swift
//  FormView
//
//  Created by 黄伯驹 on 2025/6/27.
//  Copyright © 2025 黄伯驹. All rights reserved.
//

import UIKit
import SnapKit
import Markdown

class MarkdownosaurVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBlue
        
        let markdownString = """
            You ^[**这是一段加粗自定义颜色文字**](Color#FFFF4500) can make an unordered list by preceding one or more lines of text with `-`, `*`, or `+`.

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
        textView.attributedText = attributedText(from: markdownString)
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(600)
        }
    }
    
    private func attributedText(from markdown: String) -> NSAttributedString {
        let document = Document(parsing: markdown, options: .parseBlockDirectives)

        var markdownosaur = Markdownosaur()
        return markdownosaur.attributedString(from: document)
    }

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 12
        return textView
    }()
}
