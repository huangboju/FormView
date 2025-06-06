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
          ## Try MarkdownUI

          **MarkdownUI** is a native Markdown renderer for SwiftUI
          compatible with the
          [GitHub Flavored Markdown Spec](https://github.github.com/gfm/).
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
