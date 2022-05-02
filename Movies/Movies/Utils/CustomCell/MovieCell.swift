//
//  MovieCell.swift
//  Movies
//
//  Created by Pierre Chamorro on 1/05/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var imagePosterMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(movie:ItemMovieModel){
        lblMovieTitle.text = movie.title
        lblOverview.text = movie.overview
        lblVoteAverage.text = "\(movie.voteAverage)"
        let baseUrl: RequestModel.URLInitial = .imagePoster
        let url = URL(string: "\(baseUrl.rawValue)\(movie.posterPath)")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
