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
    private var filteredMovies: [ItemMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
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
    @objc func methodOfReceivedNotification(notification: Notification){
        let userInfo = notification.userInfo! as NSDictionary
        let textSearch = userInfo["search"] as! String
        let auxList: [ItemMovieModel] = self.listPopularMovies.filter{
            $0.title.lowercased().contains(textSearch.lowercased())
        }
        self.listPopularMovies = textSearch.count == 0 ? filteredMovies:auxList
        tableView.reloadData()
    }
}

extension PopularMoviesViewController: PopularMoviesViewProtocol {
    func getData(listPopularMovies : [ItemMovieModel]){
        self.listPopularMovies = listPopularMovies
        self.filteredMovies = listPopularMovies
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
