//
//  SplashPresenter.swift
//  
//
//  Created by  Ivan B  on 27.05.22.
//  
//

import Foundation

protocol SplashViewModelProtocol: AnyObject {
    func viewDidLoad()
}

final class SplashViewModel {
    private let sceneOutput: SplashSceneOutput?
    
    init(sceneOutput: SplashSceneOutput?) {
        self.sceneOutput = sceneOutput
    }
    
    private func displayDesiredFlow() {
            self.sceneOutput?.proceedFromSplash()
    }
    
}

extension SplashViewModel: SplashViewModelProtocol {
    func viewDidLoad() {
        displayDesiredFlow()
    }
}
