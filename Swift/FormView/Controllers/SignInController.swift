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
                Row<InputCell>(viewData: InputCellItem(placeholder: "请输入账号"), tag: "phoneNumber"),
                Row<InputCell>(viewData: InputCellItem(placeholder: "请输入密码"), tag: "password"),
                Row<ButtonCell>(viewData: ButtonCellItem(title: "sign in", normalState: (.white, .normal), highlightState: (.lightGray, .highlighted))),
                Row<LicenseCell>(viewData: NoneItem())
            ]
        ]
    }
}

extension SignInController: ButtonCellActionable {
    func buttonAction(_ sender: UIButton) {
        let phoneNumberCell: InputCell = cellBy(tag: "phoneNumber")
        let phoneNumber = phoneNumberCell.inputText
        if phoneNumber.isEmpty {
            showAlert(message: "请输入手机号")
            return
        }

        let passWordCell: InputCell = cellBy(tag: "password")
        let password = passWordCell.inputText
        if password.isEmpty {
            showAlert(actionTitle: "取消", message: "请输入密码") { (action) in
                print("选择了\(action)")
            }.action("不想输入") { (action) in
                print("选择了\(action)")
            }
            return
        }
    }
}
