//
//  UpcomingMoviesProvider.swift
//  Movies
//
//  Created by Pierre Nestor Chamorro Rojas on 2/05/22.
//

import Foundation

protocol UpcomingMoviesProviderProtocol {
    func getUpcomingMovies()  async throws -> MovieModel
}

class UpcomingMoviesProvider: UpcomingMoviesProviderProtocol {
    func getUpcomingMovies()  async throws -> MovieModel {
        let requestModel = RequestModel(endPoint: .upcomingMovie)
        do{
            let result = try await Network.callService(requestModel, MovieModel.self)
            return result
        }catch{
            throw error
        }
    }
}
