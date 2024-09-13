//
//  MainViewModel.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var products: [Producto] = []
    @Published var shouldNavigate: Bool = false
    @Published var isLoading: Bool = false
    
    private var repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
        self.repository.delegate = self
    }
    
    func didTapFetchProducts() {
        
        if products.isEmpty {
                
            if !isLoading {
                self.isLoading = true
                self.repository.fetchProducts()
            }
        } else {
            self.shouldNavigate = true 
        }
    }
}

extension MainViewModel: ProductRepositoryDelegate {
    func didFetchProductsWithSuccess(_ products: [Producto]) {
        self.products = products
        self.shouldNavigate = true
        self.isLoading = false
    }
    
    func didFailFetchProducts(with error: Error) {
        self.isLoading = false 
        debugPrint("FAILED FETCH PRODUCTS", error.localizedDescription)
    }
}
