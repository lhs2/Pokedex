//
//  PokeListWorker.swift
//  Pokedex
//
//  Created by Luiz Henrique on 29/05/2024.
//

import Foundation
import Swinject

protocol PokeListWorkerProtocol {
    func requestList(offset: Int, limit: Int) -> [PKMPokemonList]
    func requestPokemonBy(input: String) -> PKMPokemon?
}

final class PokeListWorker: PokeListWorkerProtocol {
    let baseURL = "https://pokeapi.co/api/v2/"
    var resolver: Resolver?
    
    init(resolver: Resolver? = nil) {
        self.resolver = resolver
    }
    
    // MARK: Requests
    func requestList(offset: Int, limit: Int) -> [PKMPokemonList] {
        let request = createRequestList(offset: offset, limit: limit)
        guard let provider = getNetworkProvider() else {
            return []
        }
        let result: Result<Pagination<PKMPokemonList>, NetworkProviderError> = provider.request(request)
        switch result {
        case .success(let pokemonList):
            return pokemonList.results ?? []
        case .failure:
            return []
        }
    }
    
    func requestPokemonBy(input: String) -> PKMPokemon? {
        let request = createRequestPokemon(input: input)
        guard let provider = getNetworkProvider() else {
            return nil
        }
        let result: Result<PKMPokemon, NetworkProviderError> = provider.request(request)
        switch result {
        case .success(let pokemon):
            return pokemon
        case .failure:
            return nil
        }

    }
    
    // MARK: Creation URL Request
    
    func createRequestList(offset: Int, limit: Int) -> PokeListWorkerRequest<NetworkProviderRequestBodyEmpty> {
        let absoluteURL = baseURL + "pokemon?"
        let query = [
            "offset": "\(offset)",
            "limit": "\(limit)"
        ]
        return PokeListWorkerRequest(serviceName: "PokemonList", serviceUrl: absoluteURL, method: .get, headers: nil, queryParams: query)
    }
    
    func createRequestPokemon(input: String) -> PokeListWorkerRequest<NetworkProviderRequestBodyEmpty> {
        let absoluteURL = baseURL + "pokemon/\(input)"
        return PokeListWorkerRequest(serviceName: "Pokemon", serviceUrl: absoluteURL, method: .get, headers: nil, queryParams: nil)
    }
}

extension PokeListWorker {
    func getNetworkProvider() -> NetworkProvider? {
        return resolver?.resolve(NetworkProvider.self)
    }
}

struct PokeListWorkerRequest<T: Encodable>: NetworkProviderRequest {
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
