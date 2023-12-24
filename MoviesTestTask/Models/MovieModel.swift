//
//  MovieModel.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

struct MovieModel: Decodable, Equatable {
    enum CodingKeys: CodingKey {
        case title
        case description
        case rating
        case duration
        case genre
        case releasedDate
        case trailerLink
    }
    
    let title: String
    let description: String
    let rating: Double
    let duration: String
    let genre: String
    let releasedDate: String
    let trailerLink: String
    
    var isInWatchList: Bool = false
    var imagePreview: UIImage? {
        let components = title.components(separatedBy: ":")
        guard let imagePreviewName = components.first else { return UIImage(systemName: "close") }
        let adjustedImagePreviewName = imagePreviewName.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "-", with: " ")
        return UIImage(named: adjustedImagePreviewName)
    }
    var previewDescription: String {
        [duration, genre].joined(separator: " - ")
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.releasedDate = try container.decode(String.self, forKey: .releasedDate)
        self.trailerLink = try container.decode(String.self, forKey: .trailerLink)
    }
    
    static func==(lhs: MovieModel, rhs: MovieModel) -> Bool {
        lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.rating == rhs.rating
        && lhs.duration == rhs.duration
        && lhs.genre == rhs.genre
        && lhs.releasedDate == rhs.releasedDate
        && lhs.trailerLink == rhs.trailerLink
    }
}
