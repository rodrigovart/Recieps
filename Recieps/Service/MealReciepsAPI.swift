//
//  MealReciepsAPI.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import RxSwift
import RxCocoa
import Alamofire

struct Resource<T>{
    let url: URL
}

enum MealServiceError: Error {
    case offline
    case error
    case networkError
}

//MARK: RequestObservable class
class APIClient {
    public static var shared = APIClient()
    
    //MARK: function for URLSession takes
    public func rx_GetAllMeals(completion: @escaping (Observable<[Meals]>) -> Void) {
        AF.request(SEARCH_ALL_MEALS).responseDecodable(of: MealsResult.self) { result in
            guard let meals: [Meals] = result.value?.meals else { return }
            completion(Observable.just(meals))
        }
    }
}
