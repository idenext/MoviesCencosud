//
//  PopularMoviesViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

class PopularMoviesViewController:BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = PopularMoviesPresenter(delegate: self)
    private var listPopularMovies : [ItemMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        Task{
            await presenter.getPopularMovies()
        }
    }
    
    private func setupTableView(){
        tableView.register(cell: MovieCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
}

extension PopularMoviesViewController: PopularMoviesViewProtocol {
    func getData(listPopularMovies : [ItemMovieModel]){
        self.listPopularMovies = listPopularMovies
        self.tableView.reloadData()
    }
}
extension PopularMoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPopularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(for: MovieCell.self, for: indexPath)
        movieCell.configCell(movie: listPopularMovies[indexPath.row])
        return movieCell
    }
    
}

extension PopularMoviesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailMovie(movie: listPopularMovies[indexPath.row])
    }
}
