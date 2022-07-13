//
//  URLSessionProtocol.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func dataTask(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func dataTask(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await self.data(for: request)
    }
}
