//
//  NetworkError.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodeError
    case unknownError
    case invalidURL
}
