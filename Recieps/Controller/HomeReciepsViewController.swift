//
//  HomeReciepsViewController.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import RxSwift

class HomeReciepsViewController: UIViewController {
    
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    var meals: [Meals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoader()
        
        setupTableView()

        loadMeals()
    }
    
    override func loadView() {
        tableView = UITableView(frame: .zero)
        self.view = tableView
    }
    
    func setupTableView() {
        tableView.register(HomeReciepsView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadMeals() {
        APIClient.shared.rx_GetAllMeals { [weak self] result in
            guard let self = self else { return }
            result.subscribe(onNext: { meals in
                self.meals = meals
                self.setupNavigationBar(title: "Foods Recieps", image: "searchIcon")
                self.tableView.reloadData()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeReciepsView else { return UITableViewCell() }
        cell.meals = meals[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailReciep = DetailReciepViewController()
        detailReciep.meal = meals[indexPath.item]
        detailReciep.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(detailReciep, animated: true)
    }
}
