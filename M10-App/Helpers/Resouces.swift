//
//  Resources.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 12.01.25.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let greenlightColor = UIColor(hexString: "#6CE9C5")
        static let bluedarkColor = UIColor(hexString: "#02174D")
        static let redColor = UIColor(hexString: "#EA3325")
        static let greyColor = UIColor(hexString: "#F0F0F0")
        static let greyTextColor = UIColor(hexString: "#BBBBBB")
    }
    enum AssetConstant {
            static let vectorIcon = "Assets/logo10lar.pdf"
            static let personIcon = "Icons/person.pdf"
            static let lockIcon = "Assets/Icons/lock.pdf"
            static let searchIcon = "Assets/Icons/search.pdf"
            static let mapIcon = "Assets/Icons/map.pdf"
            static let metroIcon = "Assets/Icons/metro.pdf"
            static let storeIcon = "Assets/Icons/store.pdf"
            static let clockIcon = "Assets/Icons/clock.pdf"
            static let historyIcon = "Assets/Icons/history.pdf"
            static let treeDotIcon = "Assets/Icons/3dot.pdf"
            static let backButton = "Assets/Icons/back_button.pdf"
            static let noInternetIcon = "Assets/Icons/no_internet.pdf"
        }
//    enum Fonts {
//        static func helveticaRegular(width size: CGFloat) -> UIFont {
//            UIFont(name: "Helvetica", size: size) ?? UIFont()
//
//        }
//    }
//    struct TextStyles {
//        static let largeTextStyle = UIFont.systemFont(ofSize: 28)
//        static let mediumTextStyle = UIFont.systemFont(ofSize: 17)
//        static let smallTextStyle = UIFont.systemFont(ofSize: 12)
//    }
    struct MainConst {
        static let regions: [String] = [
            "Binəqədi rayonu", "Qaradağ rayonu", "Xəzər rayonu", "Səbail rayonu",
            "Sabunçu rayonu", "Suraxanı rayonu", "Nərimanov rayonu", "Nəsimi rayonu",
            "Nizami rayonu", "Xətai rayonu", "Yasamal rayonu", "Xırdalan Sumqayıt"
        ]
        
        static let stores: [String] = [
            "Bravo", "Rahat", "Tamstore", "Grandmart",
            "Bolmart", "Bizim", "Megastore", "Baqqal"
        ]
        
        static let metroStations: [String] = [
            "Dərnəgül", "Azadlıq prospekti", "Nəsimi", "Memar Əcəmi", "20 Yanvar",
            "İnşaatçılar", "Elmlər Akademiyası", "Nizami", "28 May", "Gənclik",
            "Nəriman Nərimanov", "Ulduz", "Koroğlu", "Qara Qarayev", "Neftçilər",
            "Xalqlar Dostluğu", "Əhmədli", "Həzi Aslanov", "Sahil", "İçərişəhər",
            "Bakmil", "Avtovağzal", "8 Noyabr", "Xocasən"
        ]
        
//        static var getModel: GetModel = GetModel(range: "")
//        static var reservation: ReservationModel?
//        static var profileImage: String = ""
    }
}
