//
//  PopularMoviesPresenter.swift
//  Movies
//
//  Created by Pierre Chamorro on 1/05/22.
//

import Foundation

protocol PopularMoviesViewProtocol: AnyObject , BaseViewProtocol{
    func getData(listPopularMovies : [ItemMovieModel])
}

class PopularMoviesPresenter{
    var provider : PopularMoviesProviderProtocol
    weak var delegate : PopularMoviesViewProtocol?
    private var objectList : [ItemMovieModel] = []
    
    init(delegate: PopularMoviesViewProtocol,
         provider: PopularMoviesProviderProtocol = PopularMoviesProvider()){
        self.delegate = delegate
        self.provider = provider
    }
    
    func getPopularMovies() async{
        delegate?.loadingView(.show)
        do{
            defer{
                delegate?.loadingView(.hide)
            }
            let popularMovies = try await provider.getPopularMovies()
            objectList = popularMovies.results
            delegate?.getData(listPopularMovies: objectList)
        }catch{
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getPopularMovies()
                }
            })
        }
    }
}
