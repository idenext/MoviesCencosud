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
    private var filteredMovies: [ItemMovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
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
    
    @objc func methodOfReceivedNotification(notification: Notification){
        let userInfo = notification.userInfo! as NSDictionary
        let textSearch = userInfo["search"] as! String
        let auxList: [ItemMovieModel] = self.listTopRatedMovies.filter{
            $0.title.lowercased().contains(textSearch.lowercased())
        }
        self.listTopRatedMovies = textSearch.count == 0 ? filteredMovies:auxList
        tableView.reloadData()
    }
}
extension TopRatedMoviesViewController: TopRatedMoviesViewProtocol {
    func getData(listTopRatedMovies : [ItemMovieModel]){
        self.listTopRatedMovies = listTopRatedMovies
        self.filteredMovies = listTopRatedMovies
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailMovie(movie: listTopRatedMovies[indexPath.row])
    }
}
