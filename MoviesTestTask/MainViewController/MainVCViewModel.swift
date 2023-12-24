//
//  MainVCViewModel.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import Foundation

final class MainVCViewModel {
    enum SortType {
        case title, releaseDate
    }
    
    var movies: [MovieModel] = DataManager.shared.getMovies() {
        didSet { moviesDidChange?() }
    }
    var moviesDidChange: (() -> Void)?
    
    func sortMovies(by sortType: SortType) {
        switch sortType {
        case .title: movies.sort(by: { $0.title < $1.title })
        case .releaseDate: movies.sortByDate()
        }
    }
    
    func getDetailViewModel(with indexPath: IndexPath) -> DetailVCViewModel {
        let movieModel = movies[indexPath.row]
        return DetailVCViewModel(movieModel: movieModel)
    }
    
    func updateWatchList(with updatedMovieModel: MovieModel) {
        guard let index = movies.firstIndex(where: { $0 == updatedMovieModel }) else { return }
        movies[index] = updatedMovieModel
    }
}
