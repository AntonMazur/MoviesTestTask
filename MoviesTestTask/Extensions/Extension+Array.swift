//
//  Extension+Array.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import Foundation

extension Array where Element == MovieModel {
    mutating func sortByDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        sort(by: { (firstMovie, secondMovie) -> Bool in
            guard let firstDate = dateFormatter.date(from: firstMovie.releasedDate),
                  let secondDate = dateFormatter.date(from: secondMovie.releasedDate)
            else { return false }
            
            return firstDate < secondDate
        })
    }
}
