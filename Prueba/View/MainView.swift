//
//  ContentView.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    @State private var selectedProduct: Producto?
    
    init(viewModel: MainViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let selectedProduct = selectedProduct {
                    VStack {
                        if let image = selectedProduct.urlImagenes.first {
                            AsyncImage(url: URL(string: image)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        Text("\(selectedProduct.nombre)")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        Text("Categoría: \(selectedProduct.codigoCategoria)")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        Text("$\(String(format: "%.2f", selectedProduct.precioRegular))")
                            .font(.title)
                            .foregroundColor(.green)
                            .padding(.top, 5)
                    }
                    .padding() // Espaciado interno
                    .background(Color.white) // Fondo de la tarjeta
                    .cornerRadius(15) // Bordes redondeados
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Sombra para dar efecto elevado
                    .padding(.horizontal) // Margen horizontal                    
                }
                
                Spacer()
                
                
                Button(action: {
                    viewModel.didTapFetchProducts()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Buscar Productos")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
                
                NavigationLink(
                    destination: ProductListView(
                        products: $viewModel.products,
                        selectedProduct: $selectedProduct),
                    isActive: $viewModel.shouldNavigate
                ) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Inicio")
        }
    }
}
