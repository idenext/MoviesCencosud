//
//  RootPageViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

protocol RootPageDelegate {
    func currentPage(_ index : Int)
}

class RootPageViewController: UIPageViewController {
    
    var subViewController = [UIViewController]()
    var curremtIndex : Int = 0
    var delegaRoot : RootPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupViewController()
    }
    
    private func setupDelegate() {
        delegate = self
        dataSource = self
    }
    
    private func setupViewController() {
        subViewController = [
            PopularMoviesViewController(),
            TopRatedMoviesViewController(),
            UpcomingMoviesViewController()
        ]
        _ = subViewController.enumerated().map({$0.element.view.tag = $0.offset})
        setViewControllerFromIndex(index: 0, direction: .forward)
    }
    
    func setViewControllerFromIndex(index: Int, direction: NavigationDirection, animateds: Bool = true){
        setViewControllers([subViewController[index]], direction: direction, animated: animateds)
    }
    
}

//MARK: - UIPageViewControllerDataSource
extension RootPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = subViewController.firstIndex(of: viewController) ?? 0
        return index <= 0 ? nil:subViewController[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = subViewController.firstIndex(of: viewController) ?? 0
        return index >= (subViewController.count-1) ? nil:subViewController[index+1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }

}

//MARK: - UIPageViewControllerDelegate
extension RootPageViewController : UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag{
            curremtIndex = index
            delegaRoot?.currentPage(index)
        }
    }
    
}
