//
//  NetworkError.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

public enum NetworkError: LocalizedError {
    case unknown
    case error(Error)
    
    public struct ErrorData {
        public let statusCode: Int
        public let urlSessionError: Error?
        
        public init(statusCode: Int, urlSessionError: Error?) {
            self.statusCode = statusCode
            self.urlSessionError = urlSessionError
        }
    }
}


