//
//  CALayerShadow.swift
//  evshelemekhPW2
//
//  Created by Lisa Shell on 23.09.2022.
//
import UIKit

extension CALayer {
    
    func applyShadow(){
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 1.0
        self.shadowRadius = 9.0
        self.masksToBounds = false
    }
}
