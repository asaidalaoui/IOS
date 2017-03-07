//
//  PageViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    // fileprivate(set) means - this property is readable throughout the module/app
    // that contains this code, but only writeable from within this file.
    // lazy means - lazy evaluation - the code isn't executed until it's referenced.
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.currentTaskViewController(),
                self.currentGoalViewController()]
    }()
    
    // Include this method to be able to programmatically choose the transition style.
    // Choose between:  .scroll (default) and .pageCurl
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        // Get the first view controller from the array of view controllers,
        // and use it to establish the initial array of view controllers
        // that will be managed by the page view controller.
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        // Set colors for the page control.
        // We're setting the global page control appearance object.
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.backgroundColor = UIColor.lightGray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func currentTaskViewController() -> UIViewController {
        // Instantiate a view controller that is in the storyboard, using the
        // associated storyboard id - which can be set in the Identity Inspector.
        // "Main" here is the name of the storyboard file.
        let tgtVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentTaskView")
        return tgtVC
    }
    
    fileprivate func currentGoalViewController() -> UIViewController {
        // Instantiate a view controller that is in the storyboard, using the
        // associated storyboard id - which can be set in the Identity Inspector.
        // "Main" here is the name of the storyboard file.
        let tgtVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentGoalView")
        return tgtVC
    }
}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
