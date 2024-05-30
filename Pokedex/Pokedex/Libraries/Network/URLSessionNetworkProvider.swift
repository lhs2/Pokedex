//
//  URLSessionNetworkProvider.swift
//  Pokedex
//
//  Created by Luiz Henrique on 28/05/2024.
//

import Foundation

public final class URLSessionNetworkProvider {
    private let urlSession: URLSession
    
    public init() {
        self.urlSession = URLSession(configuration: .ephemeral)
    }
}

extension URLSessionNetworkProvider {
    func createRequest<Request: NetworkProviderRequest>(_ request: Request) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: request.serviceUrl) else {
            throw NetworkProviderError.other
        }
        if let queryParams = request.queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else {
            throw NetworkProviderError.other
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if request.method != .get,
            let data = try? JSONEncoder().encode(request.jsonBody) {
            urlRequest.httpBody = data
        }
        return urlRequest
    }
    
}

extension URLSessionNetworkProvider: NetworkProvider {
    public func piu() {
        print(1)
    }
    public func request<Request: NetworkProviderRequest, Response: Decodable>(_ request: Request) -> Result<Response, NetworkProviderError> {
        do {
            let urlRequest = try self.createRequest(request)
            let response = self.executeURLRequest(urlRequest)
            return self.checkRequestDataResponse(response)
        } catch {
            return .failure(.other)
        }
    }
    
    func executeURLRequest(_ urlRequest: URLRequest) -> Result<Data, NetworkProviderError> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Data, NetworkProviderError> = .failure(.other)
        self.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            result = self.checkResponse(data, response, error)
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return result
    }
    
    func checkResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data, NetworkProviderError> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.noConnection)
        }
        let statusCode = httpResponse.statusCode
        switch statusCode {
        case 204:
            return .success(Data())
        case 200...203, 205...299:
            guard let data = data else {
                return .failure(.other)
            }
            return .success(data)
        case 401:
            return .failure(.unauthorized)
        default:
            return .failure(.other)
        }
    }
    
    
    func checkRequestDataResponse<Response: Decodable>(_ response: Result<Data, NetworkProviderError>) -> Result<Response, NetworkProviderError> {
        switch response {
        case .success(let data):
            do {
                let dataBytes = [UInt8](data)
                let encodedData = dataBytes.count > 0 ? data : Data("()".utf8)
                let result = try JSONDecoder().decode(Response.self, from: encodedData)
                return .success(result)
            } catch {
                return .failure(NetworkProviderError.parsing)
            }
        case .failure:
            return .failure(.other)
        }
    }
}
