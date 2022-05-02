//
//  TopRatedMoviesProvider.swift
//  Movies
//
//  Created by Pierre Nestor Chamorro Rojas on 2/05/22.
//

import Foundation

protocol TopRatedMoviesProviderProtocol {
    func getTopRatedMovies()  async throws -> MovieModel
}

class TopRatedMoviesProvider: TopRatedMoviesProviderProtocol {
    func getTopRatedMovies()  async throws -> MovieModel {
        let requestModel = RequestModel(endPoint: .topRatedMovie)
        do{
            let result = try await Network.callService(requestModel, MovieModel.self)
            return result
        }catch{
            throw error
        }
    }
}
