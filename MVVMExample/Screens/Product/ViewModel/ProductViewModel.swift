//
//  ProductViewModel.swift
//  MVVMExample
//
//  Created by WhyQ on 21/03/24.
//

import Foundation


final class ProductViewModel {
    var products:[Product] = []
    var eventHandler: ((_ event: Event) -> Void)? //for data binding
    func fatchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error)
            }
            
        }
    }
}

extension ProductViewModel {
        enum Event {
            case loading
            case stopLoading
            case dataLoaded
            case error(_ error:Error?)
        }
    }
