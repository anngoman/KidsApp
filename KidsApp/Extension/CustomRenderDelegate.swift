//
//  CustomRenderDelegate.swift
//  KidsApp
//
//  Created by Anna Goman on 31.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

/*
in viewDidLoad
s
let arena = I3DragArena(superview: view, containingCollections:  [taskCollectionView, userTaskCollectionView])
dragCoordinator = I3GestureCoordinator(dragArena: arena, withGestureRecognizer: UIPanGestureRecognizer())
dragCoordinator.renderDelegate = CustomRenderDelegate(views: [taskCollectionView, userTaskCollectionView,view], deleteArea: view)
dragCoordinator.dragDataSource = self
*/

import UIKit
import BetweenKit
import Foundation

class HighlightedViewModel {
  var dstView: UIView?
  var isHighlighted = false {
    didSet {
      if let dstView = dstView {
        dstView.alpha = isHighlighted ? 1 : 0.2;
      }
    }
  }
  
}

let PulseKey = "pulse"
let ShakeKey = "shake"

class CustomRenderDelegate: I3BasicRenderDelegate {
  let potentialDestinations: [HighlightedViewModel]
  let deleteArea: UIView
  
  // MARK: - Getters
  
  lazy var pulse: CABasicAnimation = {
    var pulse = CABasicAnimation(keyPath: "transform.scale")
    pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    pulse.duration = 0.35
    pulse.repeatCount = Float.infinity
    pulse.autoreverses = true
    pulse.fromValue = NSNumber(float: 1.05)
    pulse.toValue = NSNumber(float: 0.86)
    return pulse
  }()
  
  lazy var shake: CABasicAnimation = {
    var shake = CABasicAnimation(keyPath: "transform.rotation.z")
    shake.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    shake.duration = 0.1
    shake.repeatCount = Float.infinity
    shake.autoreverses = true
    shake.fromValue = NSNumber(float: (-7).degreesToRadians)
    shake.toValue = NSNumber(float: 7.degreesToRadians)
    return shake
    }()
  
  lazy var destroyScale: CABasicAnimation = {
    var destroyScale = CABasicAnimation(keyPath: "transform.scale")
    destroyScale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    destroyScale.duration = 0.2
    destroyScale.removedOnCompletion = false
    destroyScale.fromValue = NSNumber(float: 1)
    destroyScale.toValue = NSNumber(float: 0)
    destroyScale.fillMode = kCAFillModeBoth
    return destroyScale
    }()
  
  lazy var destroyRotate: CABasicAnimation = {
    var destroyRotate = CABasicAnimation(keyPath: "transform.rotation.z")
    destroyRotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    destroyRotate.duration = 0.2
    destroyRotate.removedOnCompletion = false
    destroyRotate.fromValue = NSNumber(float: 0.degreesToRadians)
    destroyRotate.toValue = NSNumber(float: -360.degreesToRadians)
    destroyRotate.fillMode = kCAFillModeBoth
    return destroyRotate
    }()
  
  required init(views: [UIView], deleteArea: UIView) {
    self.deleteArea = deleteArea
    
    var potentialDsts = [HighlightedViewModel]()
    for view in views {
      let viewModel = HighlightedViewModel()
      viewModel.dstView = view
      viewModel.isHighlighted = true
      potentialDsts.append(viewModel)
    }
    self.potentialDestinations = potentialDsts
    super.init()
  }
  
  // MARK: - Animation
  
  func startPulse() {
    draggingView.layer.addAnimation(pulse, forKey: PulseKey)
  }
  
  func invalidateShaking(globalPoint: CGPoint, coordinator: I3GestureCoordinator) {
    let localPoint = deleteArea.convertPoint(globalPoint, fromView: coordinator.arena.superview)
    let isDeleteArea = deleteArea.pointInside(localPoint, withEvent: nil)
    let hasAnimation = (draggingView.layer.animationForKey(ShakeKey) != nil)
    if isDeleteArea == true && hasAnimation == false {
      draggingView.layer.addAnimation(shake, forKey: ShakeKey)
    } else if isDeleteArea == false && hasAnimation == true {
      draggingView.layer.removeAnimationForKey(ShakeKey)
    }
  }
  
  func invalidatedHightlightedDst(globalPoint: CGPoint, coordinator: I3GestureCoordinator) {
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(0.4)
    
    for viewModel in potentialDestinations {
      let localCollectionPoint = viewModel.dstView?.convertPoint(globalPoint, fromView: coordinator.arena.superview)
      let pointInside = viewModel.dstView?.pointInside(localCollectionPoint!, withEvent: nil)
      
      if viewModel.isHighlighted == false && pointInside == true {
        viewModel.isHighlighted = true
      } else if viewModel.isHighlighted == true && pointInside == false {
        viewModel.isHighlighted = false
      }
    }
    UIView.commitAnimations()
  }
  
  func highlightAll() {
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(0.4)
    for viewModel in potentialDestinations {
      viewModel.isHighlighted = true
    }
    UIView.commitAnimations()
  }

  // MARK: - I3DragRenderDelegate
  
  override func renderDragStart(coordinator: I3GestureCoordinator!) {
    super.renderDragStart(coordinator)
    startPulse()
  }
  
  override func renderDraggingFromCoordinator(coordinator: I3GestureCoordinator!) {
    let globalPoint = coordinator.gestureRecognizer.locationInView(coordinator.arena.superview)
    super.renderDraggingFromCoordinator(coordinator)
    invalidatedHightlightedDst(globalPoint, coordinator: coordinator)
    invalidateShaking(globalPoint, coordinator: coordinator)
  }
  
  override func renderDeletionAtPoint(at: CGPoint, fromCoordinator coordinator: I3GestureCoordinator!) {
    let DestroyRotateKey = "destroy.rotate"
    let DestroyScaleKey = "destroy.scale"
    CATransaction.begin()
    CATransaction.setCompletionBlock { () -> Void in
      self.draggingView.removeFromSuperview()
      self.draggingView = nil
      self.highlightAll()
    }
    draggingView.layer.addAnimation(destroyRotate, forKey: DestroyRotateKey)
    draggingView.layer.addAnimation(destroyScale, forKey: DestroyScaleKey)
    CATransaction.commit()
  }
  
  override func renderDropOnCollection(dstCollection: UIView!, atPoint at: CGPoint, fromCoordinator coordinator: I3GestureCoordinator!) {
    super.renderDropOnCollection(dstCollection, atPoint: at, fromCoordinator: coordinator)
    highlightAll()
  }
  
  override func renderRearrangeOnPoint(at: CGPoint, fromCoordinator coordinator: I3GestureCoordinator!) {
    super.renderRearrangeOnPoint(at, fromCoordinator: coordinator)
    highlightAll()
  }
  
  override func renderResetFromPoint(at: CGPoint, fromCoordinator coordinator: I3GestureCoordinator!) {
    super.renderResetFromPoint(at, fromCoordinator: coordinator)
    highlightAll()
  }


}