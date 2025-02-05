//
//  SvgImageLoader.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 04.02.25.
//
import UIKit
import SwiftSVG

final class SVGImageLoader {
    static func loadSVG(named name: String, width: CGFloat, height: CGFloat,cornerRadius: CGFloat?) -> UIView {
        let svgView = UIView(svgNamed: name) { svg in
            svg.resizeToFit(CGRect(x: 0, y: 0, width: width, height: height))
        }
        svgView.layer.cornerRadius = cornerRadius ?? 0
        svgView.layer.masksToBounds = true
        svgView.translatesAutoresizingMaskIntoConstraints = false
        return svgView
    }
}
