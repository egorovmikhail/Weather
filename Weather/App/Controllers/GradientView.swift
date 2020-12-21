//
//  GradientView.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit

class GradientView: UIView {
  
  override static var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  var gradientLayer: CAGradientLayer {
      return self.layer as! CAGradientLayer
  }
  
//  MARK: - @IBDesignable и @IBInspectable
  
  // Начальный цвет градиента
  @IBInspectable var startColor: UIColor = .white {
      didSet {
          self.updateColors()
      }
  }
  // Конечный цвет градиента
  @IBInspectable var endColor: UIColor = .black {
      didSet {
          self.updateColors()
      }
  }
  // Начало градиента
  @IBInspectable var startLocation: CGFloat = 0 {
      didSet {
          self.updateLocations()
      }
  }
  // Конец градиента
  @IBInspectable var endLocation: CGFloat = 1 {
      didSet {
          self.updateLocations()
      }
  }
  // Точка начала градиента
  @IBInspectable var startPoint: CGPoint = .zero {
      didSet {
          self.updateStartPoint()
      }
  }
  // Точка конца градиента
  @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
      didSet {
          self.updateEndPoint()
      }
  }
  
//  MARK: - методы, которые будут обновлять параметры слоя с градиентом

  func updateLocations() {
      self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
  }
      
  func updateColors() {
      self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
  }

  func updateStartPoint() {
      self.gradientLayer.startPoint = startPoint
  }

  func updateEndPoint() {
      self.gradientLayer.endPoint = endPoint
  }
  
//  атрибуты  для поддержки редактирования и визуализации view в storyboard
  
  
      
  
  
      
  
  

}
