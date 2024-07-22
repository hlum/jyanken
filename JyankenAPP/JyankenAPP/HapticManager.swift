//
//  HapticManager.swift
//  JyankenAPP
//
//  Created by Hlwan Aung Phyo on 2024/07/16.
//

import Foundation
import UIKit


class HapticManager{
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(type)
        
        
    }
    func impact(style : UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style:style)
        
        generator.impactOccurred()
        
    }
    
}
