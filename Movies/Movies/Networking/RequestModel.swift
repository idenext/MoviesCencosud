//
//  RequestModel.swift
//  Movies
//
//  Created by Pierre Chamorro on 1/05/22.
//

import Foundation

struct RequestModel {
    
    let endPoint : EndPoints
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLInitial = .movies
    var queryItems : [String:String] = ["":""]
    
    func getURL() -> String{
        return baseUrl.rawValue + endPoint.rawValue
    }
    
    enum HttpMethod : String{
        case GET
        case POST
    }
    
    enum EndPoints : String{
        case popularMovie = "popular"
        case topRatedMovie = "top_rated"
        case upcomingMovie = "upcoming"
        case empty = ""
    }
    
    enum URLInitial : String{
        case movies = "https://api.themoviedb.org/3/movie/"
        case imagePoster = "https://image.tmdb.org/t/p/w500"
    }
}
