//
//  TopRatedMoviesViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

class TopRatedMoviesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = TopRatedPresenter(delegate: self)
    private var listTopRatedMovies : [ItemMovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        Task{
            await presenter.getTopratedMovies()
        }
    }
    
    private func setupTableView(){
        tableView.register(cell: MovieCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
}
extension TopRatedMoviesViewController: TopRatedMoviesViewProtocol {
    func getData(listTopRatedMovies : [ItemMovieModel]){
        self.listTopRatedMovies = listTopRatedMovies
        self.tableView.reloadData()
    }
}
extension TopRatedMoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(for: MovieCell.self, for: indexPath)
        movieCell.configCell(movie: listTopRatedMovies[indexPath.row])
        return movieCell
    }
    
    
}

extension TopRatedMoviesViewController: UITableViewDelegate{
    
}
