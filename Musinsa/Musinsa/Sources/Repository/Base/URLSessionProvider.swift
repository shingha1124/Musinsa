//
//  URLSessionProvider.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

class URLSessionProvider {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func dataTask(request: URLRequest) async throws -> NetworkResult {
        let (data, response) = try await session.dataTask(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkResult(.unknownError)
        }

        if (200..<300).contains(httpResponse.statusCode) {
            return NetworkResult(data)
        }
        
        return NetworkResult(.unknownError)
    }
}
