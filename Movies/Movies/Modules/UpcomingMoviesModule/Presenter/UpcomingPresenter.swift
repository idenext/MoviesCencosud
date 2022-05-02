//
//  UpcomingPresenter.swift
//  Movies
//
//  Created by Pierre Nestor Chamorro Rojas on 2/05/22.
//

import Foundation

protocol UpcomingMoviesViewProtocol: AnyObject , BaseViewProtocol{
    func getData(listUpcomingMovies : [ItemMovieModel])
}

class UpcomingPresenter{
    var provider : UpcomingMoviesProviderProtocol
    weak var delegate : UpcomingMoviesViewProtocol?
    private var objectList : [ItemMovieModel] = []
    
    init(delegate: UpcomingMoviesViewProtocol,
         provider: UpcomingMoviesProviderProtocol = UpcomingMoviesProvider()){
        self.delegate = delegate
        self.provider = provider
    }
    
    func getUpcomingMovies() async{
        delegate?.loadingView(.show)
        do{
            defer{
                delegate?.loadingView(.hide)
            }
            let popularMovies = try await provider.getUpcomingMovies()
            objectList = popularMovies.results
            delegate?.getData(listUpcomingMovies: objectList)
        }catch{
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getUpcomingMovies()
                }
            })
        }
    }
}
