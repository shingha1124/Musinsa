//
//  MusinsaRepository.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol MusinsaRepository {
    func requestHome()
}

class MusinsaRepositoryImpl: NetworkRepository<MusinsaAPI>, MusinsaRepository {
    func requestHome() {
        request(.requestHome) { result in
            let ttt = result.decode(HomeModel.self)
            print(ttt)
            guard let data = result.data else {
                return
            }
//
//            let string = String.init(data: data, encoding: .utf8)
//
////           print(result)
////            if result.e
//            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//
////            JSONSerialization.
//            let sss = json?["data"] as? [[String: Any]]
//            
//            
////            let section = String(
////            print(json?["data"])
        }
    }
}
