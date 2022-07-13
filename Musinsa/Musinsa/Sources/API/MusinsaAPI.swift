//
//  MusinsaAPI.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

enum MusinsaAPI {
    case requestHome
}

extension MusinsaAPI: BaseAPI {
    var parameter: [String: Any]? {
        switch self {
        case .requestHome:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .requestHome:
            return "/interview/list.json"
        }
    }
    
    var method: String {
        switch self {
        case .requestHome:
            return "GET"
        }
    }
}
