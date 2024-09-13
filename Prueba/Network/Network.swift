//
//  Network.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import Foundation

protocol NetworkProtocol {
    func fetchProductos(completion: @escaping (Result<[Producto], NetworkError>) -> Void)
}

class Network: NetworkProtocol {

    func fetchProductos(completion: @escaping (Result<[Producto], NetworkError>) -> Void) {
        // Configura la URL de la petición
        guard let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a") else {
            completion(.failure(.badURL))
            return
        }

        
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Verifica si hubo un error en la petición
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(.success(response.resultado.productos))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }

}

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}
