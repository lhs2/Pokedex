//
//  BaseNetworkProviderRequest.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

struct BaseNetworkProviderRequest: NetworkProviderRequest {
    typealias Body = String
    var serviceName: String
    var method: NetworkProviderMethod
    var serviceUrl: String
    var jsonBody: String?
    var headers: [String : String]?
    var queryParams: [String : String]?
    
    init(request: NetworkRequest) {
        self.serviceName = request.serviceName
        self.method = NetworkProviderMethod(rawValue: request.method.rawValue) ?? .get
        self.serviceUrl = request.url
        self.headers = request.headers
        self.jsonBody = request.body
    }
}

struct BaseNetworkResponse: NetworkResponse {
    var body: String
    var data: Data
    var status: Int = 200
    var headers: [AnyHashable : Any]?
}
