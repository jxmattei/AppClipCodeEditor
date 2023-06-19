//
//  ContentManager.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import Foundation
import Combine
import UIKit

@MainActor
class ContentManager: ObservableObject {

    var currentSVG: CurrentValueSubject<UIImage?,Never> = .init(nil)

    init() {
    }
    
}
