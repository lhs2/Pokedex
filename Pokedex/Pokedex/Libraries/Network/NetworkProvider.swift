//
//  NetworkProvider.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

public protocol NetworkProvider {
    func request<Request: NetworkProviderRequest, Response: Decodable>(_ request: Request) -> Result<Response, NetworkProviderError>
    func piu()
}

public protocol NetworkProviderRequest {
    associatedtype Body: Encodable
    var serviceName: String { get }
    var method: NetworkProviderMethod { get }
    var serviceUrl: String { get }
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var jsonBody: Body? { get }
}

public enum NetworkProviderMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public enum NetworkProviderError: LocalizedError {
    case unauthorized
    case other
    case parsing
    case noConnection
    
}

public struct NetworkProviderResponseError {
    let code: Int
    let data: Data?
    let error: Error?
    
    public init(code: Int, data: Data?, error: Error?) {
        self.code = code
        self.data = data
        self.error = error
    }
}

struct NetworkProviderRequestBodyEmpty: Encodable { }

