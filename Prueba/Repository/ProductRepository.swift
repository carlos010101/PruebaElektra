//
//  ProductRepository.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import Foundation

protocol ProductRepositoryDelegate: AnyObject {
    func didFetchProductsWithSuccess(_ products: [Producto])
    func didFailFetchProducts(with error: Error)
}

protocol ProductRepositoryProtocol {
    var delegate: ProductRepositoryDelegate? { get set }
    var network: NetworkProtocol { get }
    func fetchProducts()
}

class ProductRepository: ProductRepositoryProtocol {
    weak var delegate: ProductRepositoryDelegate?
    var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchProducts() {
        network.fetchProductos { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.delegate?.didFetchProductsWithSuccess(products)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.delegate?.didFailFetchProducts(with: error)
                }
            }
        }
    }
}
