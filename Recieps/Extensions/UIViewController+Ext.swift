//
//  UIViewController+Ext.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import ProgressHUD

extension UIViewController {
    func showLoader() {
        ProgressHUD.show("Loading")
    }
    
    func dissmisLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ProgressHUD.dismiss()
        }
    }

    func setupNavigationBar(title: String, image: String) {
        let img = UIImage(named: image)!.withRenderingMode(.alwaysTemplate)
        let image = UIBarButtonItem(image: img, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = image
        navigationItem.title = title
    }
}
