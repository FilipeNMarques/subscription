//
//  NetworkManager.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
}

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetch() async throws -> SubscriptionPayload {
        guard let url = URL(string: "https://api.jsonbin.io/v3/qs/66a950f0e41b4d34e41961f8") else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        let subscriptionData = try JSONDecoder().decode(SubscriptionPayload.self, from: data)

        return subscriptionData
    }
}
