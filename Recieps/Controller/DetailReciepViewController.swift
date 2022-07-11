//
//  DetailReciepViewController.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import UIKit


class DetailReciepViewController: UIViewController {
    var meal: Meals? {
        didSet {
            if let meal = meal {
                self.meal = meal
            }
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemPink
        self.setupNavigationBar(title: "Reciep Details", image: "searchIcon")
        print(meal)
    }
}
