//
//  NetworkClient.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

public protocol NetworkClient {
    func request(_ request: NetworkRequest) throws -> Result<NetworkResponse, NetworkError>
}

public protocol NetworkRequest {
    var method: NetworkRequestMethod { get }
    var serviceName: String { get }
    var url: String { get }
    var headers: [String: String] { get }
    var body: String? { get }
}

public enum NetworkRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public protocol NetworkResponse {
    var body: String { get }
    var data: Data { get }
    var status: Int { get }
    var headers: [AnyHashable: Any]? { get }
}
