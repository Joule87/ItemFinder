//
//  Debouncer.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
///Object to ensure that time-consuming tasks do not fire so often
class Debouncer {
  
    typealias Handler = () -> Void
    
    private let timeInterval: TimeInterval
    private var timer: Timer?
        var handler: Handler?
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    ///Invalidate existing timer if there is one and begin a new timer
    func renewTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }
    
    ///Invalidate existing timer
    func invalidateTimer() {
        timer?.invalidate()
    }
    
    /// Execute the handler if the given timer is valid
    /// - Parameters:
    ///   - timer: If  the timer is invalidated the handler won't be executed
    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }
}
