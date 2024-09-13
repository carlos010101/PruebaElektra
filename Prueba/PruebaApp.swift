//
//  PruebaApp.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import SwiftUI

@main
struct PruebaApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: MainViewModel(
                    repository: ProductRepository(
                        network: Network()
                    )
                )
            )
            .preferredColorScheme(.light)
        }
    }
}
