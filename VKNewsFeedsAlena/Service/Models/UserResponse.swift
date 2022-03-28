//
//  UserResponse.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 18.03.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response : [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
