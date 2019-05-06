//
//  DarkSkyError.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import Foundation


enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}
