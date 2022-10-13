//
//  SignUpModel.swift
//  CustomTables
//
//  Created by Arturo Ventura on 13/10/22.
//

import Foundation

// MARK: - Survey
class SurveyModel: Codable {
    var reporte: [ReporteModel]?
    var empresas: [EmpresaModel]?

    enum CodingKeys: String, CodingKey {
        case reporte = "reporte"
        case empresas = "empresas"
    }

    init(reporte: [ReporteModel]?, empresas: [EmpresaModel]?) {
        self.reporte = reporte
        self.empresas = empresas
    }
}

// MARK: - Empresa
class EmpresaModel: Codable {
    var nombre: String?
    var porcentaje: Int?

    enum CodingKeys: String, CodingKey {
        case nombre = "nombre"
        case porcentaje = "porcentaje"
    }

    init(nombre: String?, porcentaje: Int?) {
        self.nombre = nombre
        self.porcentaje = porcentaje
    }
}

// MARK: - Reporte
class ReporteModel: Codable {
    var valor: String?
    var cantidad: Int?

    enum CodingKeys: String, CodingKey {
        case valor = "valor"
        case cantidad = "cantidad"
    }

    init(valor: String?, cantidad: Int?) {
        self.valor = valor
        self.cantidad = cantidad
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        valor = try container.decode(String.self, forKey: .valor)
        let cantidadString = try container.decode(String.self, forKey: .cantidad)
        cantidad = Int(cantidadString)
    }
}
