//
//  MainViewController.swift
//  Movies
//
//  Created by Pierre Chamorro on 29/04/22.
//

import UIKit

class MainViewController: UIViewController {
    var rootPageViewcontroller :RootPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
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
        print(index)
    }

}
