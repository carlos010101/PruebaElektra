//
//  ResponseModel.swift
//  Prueba
//
//  Created by Administrador on 12/09/24.
//

import Foundation

struct ResponseModel: Codable {
    let codigo: String
    let mensaje: String
    let folio: String
    let advertencia: String
    let resultado: Resultado
}

struct Resultado: Codable {
    let paginacion: Paginacion
    let categoria: String
    let productos: [Producto]
}

struct Paginacion: Codable {
    let pagina: Int
    let totalPaginas: Int
    let totalRegistros: Int
    let totalRegistrosPorPagina: Int
}

struct Producto: Codable, Identifiable {
    let id: String
    let idLinea: Int
    let codigoCategoria: String
    let idModalidad: Int
    let relevancia: Int
    let lineaCredito: String
    let pagoSemanalPrincipal: Int
    let plazoPrincipal: Int
    let disponibleCredito: Bool
    let abonosSemanales: [AbonoSemanal]
    let sku: String
    let nombre: String
    let urlImagenes: [String]
    let precioRegular: Double
    let precioFinal: Double
    let porcentajeDescuento: Double
    let descuento: Bool
    let precioCredito: Double
    let montoDescuento: Double
}

struct AbonoSemanal: Codable {
    let plazo: Int
    let montoAbono: Int
    let montoDescuentoAbono: Int
    let montoUltimoAbono: Int
    let montoFinalCredito: Int
    let idPromocion: Int
    let montoDescuentoElektra: Int
    let montoDescuentoBanco: Int
    let precio: Double
    let montoAbonoDigital: Int
}
