//
//  AppDependencies.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation
import Swinject

final class AppDependencies {
    let container = Container()
    var resolver: Resolver {
        return container.synchronize()
    }
    
    private lazy var networkProvider: NetworkProvider & NetworkClient = {
        return BaseNetworkProvider(networkProvider: URLSessionNetworkProvider())
    }()
    
    init() {
        registerDependencies()
    }
    
    func registerDependencies() {
        container.register(NetworkProvider.self) { _ in
            self.networkProvider
        }
        
        container.register(NetworkClient.self) { _ in
            self.networkProvider
        }

    }
    
}
