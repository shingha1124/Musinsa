//
//  NetworkRepository.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

class NetworkRepository<API: BaseAPI> {
    private var provider: URLSessionProvider?
    
    func request(_ target: API, session: URLSessionProtocol = URLSession.shared, complate: @escaping (NetworkResult) -> Void) {
        
        provider = URLSessionProvider(session: session)
        
        let url = target.path.isEmpty ? target.baseURL : target.baseURL.appendingPathComponent(target.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method
        
        provider?.dataTask(request: urlRequest) { result in
            complate(result)
        }
    }
}
