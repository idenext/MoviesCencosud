//
//  TopRatedPresenter.swift
//  Movies
//
//  Created by Pierre Nestor Chamorro Rojas on 2/05/22.
//

import Foundation

protocol TopRatedMoviesViewProtocol: AnyObject , BaseViewProtocol{
    func getData(listTopRatedMovies : [ItemMovieModel])
}

class TopRatedPresenter{
    var provider : TopRatedMoviesProviderProtocol
    weak var delegate : TopRatedMoviesViewProtocol?
    private var objectList : [ItemMovieModel] = []
    
    init(delegate: TopRatedMoviesViewProtocol,
         provider: TopRatedMoviesProviderProtocol = TopRatedMoviesProvider()){
        self.delegate = delegate
        self.provider = provider
    }
    
    func getTopratedMovies() async{
        delegate?.loadingView(.show)
        do{
            defer{
                delegate?.loadingView(.hide)
            }
            let topRatedMovies = try await provider.getTopRatedMovies()
            objectList = topRatedMovies.results
            delegate?.getData(listTopRatedMovies: objectList)
        }catch{
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getTopratedMovies()
                }
            })
        }
    }
}
