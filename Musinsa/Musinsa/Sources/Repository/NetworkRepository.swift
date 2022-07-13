//
//  NetworkRepository.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

class NetworkRepository<API: BaseAPI> {
    private var provider: URLSessionProvider?
    
    func request(_ target: API, session: URLSessionProtocol = URLSession.shared) async throws -> NetworkResult? {
        
        provider = URLSessionProvider(session: session)
        
        let url = target.path.isEmpty ? target.baseURL : target.baseURL.appendingPathComponent(target.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method
        
        return try await provider?.dataTask(request: urlRequest)
    }
}
