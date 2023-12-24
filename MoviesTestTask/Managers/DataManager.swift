//
//  DataManager.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private init() { }
    
    func getMovies() -> [MovieModel] {
        Bundle.main.decode(file: "moviesJson")
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = url(forResource: file, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else { fatalError("Failed to decode data from provided file") }
        
        return decodedData
    }
}
