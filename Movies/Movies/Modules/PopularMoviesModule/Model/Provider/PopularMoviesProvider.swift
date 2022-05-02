//
//  PopularMoviesProvider.swift
//  Movies
//
//  Created by Pierre Chamorro on 1/05/22.
//

import Foundation

protocol PopularMoviesProviderProtocol {
    func getPopularMovies()  async throws -> MovieModel
}

class PopularMoviesProvider: PopularMoviesProviderProtocol {
    func getPopularMovies()  async throws -> MovieModel {
        let requestModel = RequestModel(endPoint: .popularMovie)
        do{
            let result = try await Network.callService(requestModel, MovieModel.self)
            return result
        }catch{
            throw error
        }
    }
}
