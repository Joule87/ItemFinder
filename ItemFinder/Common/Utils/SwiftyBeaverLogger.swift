//
//  SwiftyBeaverLogger.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/17/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import SwiftyBeaver
let Logger = SwiftyBeaver.self

///Customize the Logger
class SwiftyBeaverLogger {
    
     ///Set Logger initial configuration
     static func setupLogger() {
        let console = ConsoleDestination()
        let logFormat = "$Dyyyy-MM-dd HH:mm:ss$d $N.$F:$l $C $L: - $M"
        console.levelColor.verbose = "📣"
        console.levelColor.debug = "🛠️"
        console.levelColor.info = "ℹ️"
        console.levelColor.warning = "⚠️"
        console.levelColor.error = "💥"
        console.format = logFormat
        Logger.addDestination(console)
    }
}
