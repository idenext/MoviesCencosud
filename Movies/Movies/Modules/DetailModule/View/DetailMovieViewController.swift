//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Pierre Nestor Chamorro Rojas on 2/05/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    var movie:ItemMovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        lbltitle.text = movie.title
        lblReleaseDate.text = movie.releaseDate
        lblDescription.text = movie.overview
        let baseUrl: RequestModel.URLInitial = .imagePoster
        let url = URL(string: baseUrl.rawValue + movie.backdropPath!)
        imagePoster.kf.setImage(with: url)
    }
    
}
