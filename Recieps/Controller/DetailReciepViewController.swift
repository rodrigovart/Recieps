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
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewDetails: DetailReciepView = {
        let view = DetailReciepView()
        view.meals = meal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        showLoader()
        setupUI()
    }
    
    func setupUI() {
//        let margins = view.layoutMarginsGuide
        
        setupNavigationBar(title: "Recieps Detail", image: "")
        
        viewDetails.meals = meal
        viewDetails.setupUI()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewContainer)
        
        scrollView.fillView(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        
        stackViewContainer.fillView(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        stackViewContainer.addArrangedSubview(viewDetails)
  
        dissmisLoader()
    }
}
