//
//  MainViewController.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private var moviesTableView: UITableView!
    
    private var viewModel: MainVCViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViewModel()
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let senderTuple = sender as? (detailViewModel: DetailVCViewModel, delegate: Self) else { return }
        detailVC.viewModel = senderTuple.detailViewModel
        detailVC.delegate = senderTuple.delegate
    }
    
    @IBAction private func sortButtonPressed(_ sender: UIBarButtonItem) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let titleSortAction: UIAlertAction = UIAlertAction(title: "Title", style: .default) { [weak self] _ in
            self?.viewModel.sortMovies(by: .title)
        }
        let releaseDateSortAction: UIAlertAction = UIAlertAction(title: "Release Date", style: .default) { [weak self] _ in
            self?.viewModel.sortMovies(by: .releaseDate)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }

        [titleSortAction, releaseDateSortAction, cancelAction].forEach {
            actionSheetController.addAction($0)
        }

        present(actionSheetController, animated: true)
    }
    
    private func setupViewModel() {
        viewModel = MainVCViewModel()
        viewModel.moviesDidChange = { [weak self] in
            self?.moviesTableView.reloadData()
        }
    }
    
    private func setupTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier, for: indexPath) as? MovieTableViewCell else { fatalError("An error occured while creating a cell, check implementation") }
        let movieModel = viewModel.movies[indexPath.row]
        cell.configure(with: movieModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = viewModel.getDetailViewModel(with: indexPath)
        performSegue(withIdentifier: "detailSegue", sender: (detailViewModel, self))
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - ReviewTableViewCellDelegate
extension MainViewController: ReviewTableViewCellDelegate {
    func didRequestToUpdateWatchList(with updatedMovieModel: MovieModel?) {
        guard let updatedMovieModel else { return }
        viewModel.updateWatchList(with: updatedMovieModel)
    }
}
