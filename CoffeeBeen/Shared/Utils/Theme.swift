//
//  Theme.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 23/4/25.
//

import SwiftUI

enum Theme {
    // Colors
    static let primary = Color(red: 28/255, green: 149/255, blue: 102/255)
    static let secondary = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let background = Color(red: 250/255, green: 250/255, blue: 250/255)
    static let text = Color(red: 51/255, green: 51/255, blue: 51/255)
    static let textSecondary = Color(red: 102/255, green: 102/255, blue: 102/255)
    static let accent = Color(red: 255/255, green: 184/255, blue: 0/255)
    
    // Fonts
    static let titleFont = Font.custom("Poppins-Bold", size: 24)
    static let subtitleFont = Font.custom("Poppins-SemiBold", size: 18)
    static let bodyFont = Font.custom("Poppins-Regular", size: 16)
    static let captionFont = Font.custom("Poppins-Light", size: 14)
    
    // Spacing
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    
    // Corner Radius
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
}
