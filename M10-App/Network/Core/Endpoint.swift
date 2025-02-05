//
//  Resources.swift
//  Atl_task
//
//  Created by Kamal Abdullayev on 12.01.25.
//

import Foundation

enum EncodingType {
    case url
    case json
}

enum Endpoint: String {
    case login = "auth/sign-in"
    case refreshToken = "auth/refresh-token"

    case initialReservation = "reservation/initial"
    case locationSearch = "location/search"
    case reservation = "reservation"
    case reservationNow = "reservation/reserve"
    case approveReservation = "reservation/approve-reservation"
    case addMoreTime = "reservation/add-time"
}
