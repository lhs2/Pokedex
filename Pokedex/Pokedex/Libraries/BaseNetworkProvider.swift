//
//  BaseNetworkProvider.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

public class BaseNetworkProvider: NetworkProvider, NetworkClient {
    public func piu() {
        print(2)
    }
    
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider = URLSessionNetworkProvider()) {
        self.networkProvider = networkProvider
    }
}

extension BaseNetworkProvider {
    public func request<Request, Response>(_ request: Request) -> Result<Response, NetworkProviderError> where Request : NetworkProviderRequest, Response : Decodable {
        let result: Result<Response, NetworkProviderError> = networkProvider.request(request)
        switch result {
        case .failure:
            return .failure(.unauthorized)
        case .success:
            return result
        }
     }
    
    public func request(_ request: any NetworkRequest) throws -> Result<any NetworkResponse, NetworkError> {
        fatalError("Not implemented")
    }

}
