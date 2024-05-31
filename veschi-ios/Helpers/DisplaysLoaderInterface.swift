//
//  DisplayLoaderInterface.swift
//  
//
//  Created by  Ivan B  on 16.05.23.
//

import UIKit

protocol DisplaysLoaderInterface {
    func displayLoader()
    func hideLoader(completion: (() -> Void)?)
}

extension DisplaysLoaderInterface where Self: UIViewController {
    func displayLoader() {
        let loadingView = view?.findSubview(ofType: LoadingView.self) ?? LoadingView()
        if !view.subviews.contains(loadingView) {
            loadingView.hide(animated: false)
            view.addSubview(loadingView)
            loadingView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        loadingView.show(animated: true)
    }

    func hideLoader(completion: (() -> Void)? = nil) {
        if let loadingView = view?.findSubview(ofType: LoadingView.self) {
            loadingView.hide(animated: true) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}
