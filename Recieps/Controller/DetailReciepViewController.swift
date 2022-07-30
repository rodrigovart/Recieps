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

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewDetails: DetailReciepView = {
        let view = DetailReciepView()
        view.meals = meal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.size(size: CGSize(width: UIScreen.main.bounds.width, height: 0))
        view.sizeToFit()
        return view
    }()

    override func viewDidLoad() {
        showLoader()
        setupUI()
    }
    
    func setupUI() {
        setupNavigationBar(title: "Recieps Detail", image: "")
        
        viewDetails.setupUI()

        view.addSubview(scrollView)
        
        scrollView.fillView(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        
        scrollView.addSubview(viewDetails)
        
        viewDetails.fillView(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )

        dissmisLoader()
    }
}
