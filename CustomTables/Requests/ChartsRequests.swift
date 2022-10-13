//
//  ChartsRequest.swift
//  CustomTables
//
//  Created by Arturo Ventura on 13/10/22.
//

import Foundation
import FacilCustomApp

extension RequestManager {
    func getCharts(good: SuccessClosure<SurveyModel>, bad: ErrorClosure<String>) {
        make(url: Constants.ChartsGet, method: .get, headers: nil, body: RequestManagerNulo, shouldBeToken: false, successClosure: good, errorClosure: bad)
    }
}
