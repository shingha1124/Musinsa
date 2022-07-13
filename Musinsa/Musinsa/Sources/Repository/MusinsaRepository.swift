//
//  MusinsaRepository.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol MusinsaRepository {
    func requestHome() async throws -> ApiResult<HomeModel, SessionError>
}

class MusinsaRepositoryImpl: NetworkRepository<MusinsaAPI>, MusinsaRepository {
    func requestHome() async throws -> ApiResult<HomeModel, SessionError> {
        let recive = try await request(.requestHome)
        let apiResult = recive?.decode(HomeModel.self)
        
        return apiResult ?? ApiResult(value: nil, error: .unknownError)
    }
}
