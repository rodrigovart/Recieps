//
//  HomeReciepsViewController.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import RxSwift
import ZKCarousel
import Kingfisher
import UIKit

class HomeReciepsViewController: UIViewController {

    let disposeBag = DisposeBag()
    var meals: [Meals] = []
    var filteredMeals: [Meals] = []
    var slide: [ZKCarouselSlide] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.fillSuperView()
        return tableView
    }()
    
    lazy var carousel: ZKCarousel = {
        let carousel = ZKCarousel()
        carousel.size(size: CGSize(width: view.frame.width, height: 300))
        return carousel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        showLoader()
        loadMeals()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupCarousel() {
        view.addSubview(carousel)
        carousel.fillView(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil
        )
    }

    func setupTableView() {
        tableView.register(HomeReciepsView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.fillView(
            top: carousel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
    }
    
    func loadMeals() {
        APIClient.shared.rx_GetAllMeals { [weak self] result in
            guard let self = self else { return }
            result.subscribe(onNext: { meals in
                self.meals = meals
                self.setupNavigationBar(title: "Foods Recieps", image: "")
                self.setupCarousel()
                self.setupTableView()
                self.tableView.reloadData()
                self.carousel.slides = self.slide
                self.dissmisLoader()
            }, onError: { error in
                print(error)
            }).disposed(by: self.disposeBag)
        }
    }
}

extension HomeReciepsViewController: UITableViewDelegate {}

extension HomeReciepsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMeals.count
        }
        
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeReciepsView else { return UITableViewCell() }
        
        if isFiltering {
            cell.meals = filteredMeals[indexPath.item]
        } else {
            cell.meals = meals[indexPath.item]
        }
        
  
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailReciep = DetailReciepViewController()
        
        if isFiltering {
            detailReciep.meal = filteredMeals[indexPath.item]
        } else {
            detailReciep.meal = meals[indexPath.item]
        }
        
        detailReciep.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailReciep, animated: true)
    }
}

extension HomeReciepsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMeals = meals.filter { $0.strMeal.lowercased().prefix(searchText.count) == searchText.lowercased() }
        tableView.reloadData()
    }
}
