//
//  Beer.swift
//  Beer Book
//
//  Created by Ilnur on 14.05.2023.
//

import Foundation

struct Beer: Decodable {
    let name: String
    let abv: Double
    let imageUrl: URL
    let tagline: String
    let description: String
}

