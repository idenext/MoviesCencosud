//
//  RootPageViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

enum ScrollDirection{
    case goingLeft
    case goingRight
}

protocol RootPageDelegate {
    func currentPage(_ index : Int)
    func scrollDetails(direction: ScrollDirection, percent: CGFloat, index: Int)
}

class RootPageViewController: UIPageViewController {
    
    var subViewController = [UIViewController]()
    var curremtIndex : Int = 0
    var delegaRoot : RootPageDelegate?
    var currentPage : Int = 0
    var startOffset : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegaRoot?.currentPage(0)
        setupDelegate()
        setupViewController()
        setScrollViewDelegate()
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
    
    private func setScrollViewDelegate(){
        guard let scrollView = view.subviews.filter({$0 is UIScrollView}).first as? UIScrollView else {return}
        scrollView.delegate = self
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
extension RootPageViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
        print("startOffset: \(startOffset)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction = 0 //Scroll stopped
        if startOffset < scrollView.contentOffset.x{
            direction = 1 //right
        }else if startOffset > scrollView.contentOffset.x{
            direction = -1 //left
        }
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        let percent = positionFromStartOfCurrentPage /  self.view.frame.width
        delegaRoot?.scrollDetails(direction: (direction == 1) ? .goingRight : .goingLeft, percent: percent, index: currentPage)
        print("percent: \(percent)")
        print("direction: \(direction)")
    }
}
