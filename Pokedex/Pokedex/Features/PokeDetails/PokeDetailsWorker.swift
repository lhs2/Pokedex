//
//  PokeDetailsWorker.swift
//  Pokedex
//
//  Created by Luiz Henrique on 31/05/2024.
//

import Foundation
import Swinject

protocol PokeDetailsWorkerProtocol {
    func postFavoritePokemon(pokemon: PKMPokemon)
}

final class PokeDetailsWorker: PokeDetailsWorkerProtocol {
    let baseURL = "https://webhook.site/fb51a0f3-59ce-4f8a-8419-65648d910e46"
    var resolver: Resolver?
    
    init(resolver: Resolver? = nil) {
        self.resolver = resolver
    }
    
    // MARK: Requests
    
    func postFavoritePokemon(pokemon: PKMPokemon) {
        let request = createRequestFavoritePokemon(pokemon: pokemon)
        guard let provider = getNetworkProvider() else {
            return
        }
        let result: Result<String, NetworkProviderError> = provider.request(request)
        switch result {
        case .success:
            print(200)
            return
        case .failure(let err):
            print(err)
            return
        }
    }
        
    // MARK: Creation URL Request
    
        
    func createRequestFavoritePokemon(pokemon: PKMPokemon) -> PokeDetailsWorkerRequest<PKMPokemon> {
        let absoluteURL = self.baseURL
        return PokeDetailsWorkerRequest(serviceName: "Favorite Pokemon", serviceUrl: absoluteURL, method: .post, headers: nil, queryParams: nil, jsonBody: pokemon)
    }
}

extension PokeDetailsWorker {
    func getNetworkProvider() -> NetworkProvider? {
        return resolver?.resolve(NetworkProvider.self)
    }
}

struct PokeDetailsWorkerRequest<T: Encodable>: NetworkProviderRequest {
    typealias Body = T
    let serviceName: String
    let serviceUrl: String
    let method: NetworkProviderMethod
    let headers: [String : String]?
    let queryParams: [String : String]?
    let jsonBody: T?
    
    init(serviceName: String, serviceUrl: String, method: NetworkProviderMethod, headers: [String : String]?, queryParams: [String : String]?, jsonBody: T? = nil) {
        self.serviceName = serviceName
        self.serviceUrl = serviceUrl
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
        self.jsonBody = jsonBody
    }
}
