//
//  ProductListView.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import SwiftUI

struct ProductListView: View {
    @Binding var products: [Producto]
    @Binding var selectedProduct: Producto?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(products) { product in
            VStack(alignment: .leading) {
                
                Text(product.nombre)
                    .font(.headline)
                
                Text("$\(String(format: "%.2f", product.precioRegular))")
                    .font(.subheadline)
                    .foregroundColor(.green)

            }
            .onTapGesture {
                selectedProduct = product
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Productos")
    }
}
