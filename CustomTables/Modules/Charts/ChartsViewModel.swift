//
//  ChartsViewModel.swift
//  CustomTables
//
//  Created by Arturo Ventura on 13/10/22.
//

import Foundation
import FacilCustomApp

struct SurveyChart {
    var title: String
    var content: [SurveyToTable]
}

protocol SurveyToTable {
    var name: String? {get}
    var value: Int? {get}
}

extension ReporteModel: SurveyToTable {
    var name: String? {
        get {valor}
    }
    var value: Int? {
        get {cantidad}
    }
}

extension EmpresaModel: SurveyToTable {
    var name: String? {
        get {nombre}
    }
    var value: Int? {
        get {porcentaje}
    }
}

extension SurveyModel {
    var toTable: [SurveyChart] {
        get { [
            SurveyChart(title: SurveyModel.CodingKeys.reporte.rawValue, content: reporte ?? []),
            SurveyChart(title: SurveyModel.CodingKeys.empresas.rawValue, content: empresas ?? [])
        ] }
    }
}

class ChartsViewModel {
    
    private(set) var surveyChart: [SurveyChart]?
    
    func updateData(_ completion: @escaping ()->Void) {
        RequestManager.shared.getCharts(good: { surveryModel in
            self.surveyChart = surveryModel.toTable
            completion()
        }, bad: onError(code:error:))
    }
    func onError(code: Int?, error: String?) {
        print(code ?? 0 , error ?? "NULL")
    }
}
