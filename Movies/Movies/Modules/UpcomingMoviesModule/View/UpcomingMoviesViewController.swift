//
//  UpcomingMoviesViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

class UpcomingMoviesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = UpcomingPresenter(delegate: self)
    private var listUpcomingMovies : [ItemMovieModel] = []
    private var filteredMovies: [ItemMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        Task{
            await presenter.getUpcomingMovies()
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
        let auxList: [ItemMovieModel] = self.listUpcomingMovies.filter{
            $0.title.lowercased().contains(textSearch.lowercased())
        }
        self.listUpcomingMovies = textSearch.count == 0 ? filteredMovies:auxList
        tableView.reloadData()
    }

}
extension UpcomingMoviesViewController: UpcomingMoviesViewProtocol {
    func getData(listUpcomingMovies : [ItemMovieModel]){
        self.listUpcomingMovies = listUpcomingMovies
        self.filteredMovies = listUpcomingMovies
        self.tableView.reloadData()
    }
}
extension UpcomingMoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUpcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(for: MovieCell.self, for: indexPath)
        movieCell.configCell(movie: listUpcomingMovies[indexPath.row])
        return movieCell
    }
}

extension UpcomingMoviesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailMovie(movie: listUpcomingMovies[indexPath.row])
    }
}
