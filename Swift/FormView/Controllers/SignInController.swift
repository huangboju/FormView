//
//  SignInController.swift
//  FormView
//
//  Created by 黄伯驹 on 21/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

class SignInController: GroupTableController {
    override func initSubviews() {
        form = [
            [
                Row<TitleCell>(viewData: TitleCellItem(title: "Sign In")),
                Row<InputCell>(viewData: InputCellItem(placeholder: "请输入账号")),
                Row<InputCell>(viewData: InputCellItem(placeholder: "请输入密码")),
                Row<ButtonCell>(viewData: ButtonCellItem(title: "sign in", normalState: (.white, .normal), highlightState: (.lightGray, .highlighted))),
                Row<LicenseCell>(viewData: NoneItem())
            ]
        ]
    }
}

extension SignInController: ButtonCellActionable {
    func buttonAction(_ sender: UIButton) {
        
    }
}
