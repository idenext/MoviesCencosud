//
//  MainViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet weak var tabsView: TabsView!
    var rootPageViewcontroller :RootPageViewController!
    private var options : [String] = ["POPULAR MOVIE","TOP RATED MOVIE","UPCOMING MOVIE"]
    
    var currentPageIndex : Int = 0{
        willSet{
            print("wilSet: \(currentPageIndex)")
            let cell = tabsView.collectionView.cellForItem(at: IndexPath(item: currentPageIndex, section: 0))
            cell?.isSelected = false
        }
        didSet{
            print("didSet: \(currentPageIndex)")
            if let _ = rootPageViewcontroller{
                rootPageViewcontroller.currentPage = currentPageIndex
                let cell = tabsView.collectionView.cellForItem(at: IndexPath(item: currentPageIndex, section: 0))
                cell?.isSelected = true
            }
        }
    }
    
    var didTapOption : Bool = false{
        didSet{
            if didTapOption{
                tabsView.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
                    self.didTapOption.toggle()
                    self.tabsView.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    var prevPercent : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tabsView.buildView(delegate: self, options: options)
    }
    
    func setupSearchBar(){
        navigationItem.titleView = searchBarView
        setupTextFieldsAccessoryView()
        searchBarView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController{
            destination.delegaRoot = self
            rootPageViewcontroller = destination
        }
    }
}
extension MainViewController : RootPageDelegate {
    
    func currentPage(_ index: Int) {
        print("currentPage: ", index)
        currentPageIndex = index
        tabsView.selectedItem = IndexPath(item: index, section: 0)
    }
    
    func scrollDetails(direction: ScrollDirection, percent: CGFloat, index: Int) {
        if percent == 0.0 || didTapOption{
            return
        }
        
        let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index, section: 0))
        if direction == .goingRight{
            if index == options.count-1 { return}
            let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index+1, section: 0))
            let calculateNewLeading = currentCell!.frame.origin.x + (currentCell!.frame.width * percent)
            let newWidth = (prevPercent < percent) ? nextCell?.frame.width : currentCell?.frame.width
            updateUnderlineConstraints(calculateNewLeading, newWidth!)
        }else{
            if index == 0 { return }
            let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index-1, section: 0))
            let calculateNewLeading = currentCell!.frame.origin.x - (nextCell!.frame.width * percent)
            let newWidth = (prevPercent) < percent ? nextCell?.frame.width : currentCell?.frame.width
            updateUnderlineConstraints(calculateNewLeading, newWidth!)
        }
        prevPercent = percent
    }
    
    func updateUnderlineConstraints(_ leading: CGFloat, _ width: CGFloat){
        tabsView.leadingConstraint?.constant = leading
        tabsView.widthConstraint?.constant = width
        tabsView.layoutIfNeeded()
    }

}
extension MainViewController : TabsViewProtocol{
    func didSelectOption(index: Int) {
        print("index: ", index)
        didTapOption = true
        
        let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index, section: 0))!
        tabsView.updateUnderline(xOrigin: currentCell.frame.origin.x, width: currentCell.frame.width)
        
        var direction : UIPageViewController.NavigationDirection = .forward
        if index < currentPageIndex{
            direction = .reverse
        }
        rootPageViewcontroller.setViewControllerFromIndex(index: index, direction: direction)
        
        currentPageIndex = index
    }
}
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["search" : searchText])
    }

    func setupTextFieldsAccessoryView() {
        let toolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(didPressDoneButton))
        toolBar.items = [flexsibleSpace, doneButton]
        searchBarView.inputAccessoryView = toolBar
    }

    @objc func didPressDoneButton(button: UIButton) {
        searchBarView.resignFirstResponder()
    }
}
