//
//  AppTopBarController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

protocol CustomPageControllerDelegate: class {
    func parentController() -> UIViewController
    func numberOfViewControllers() -> Int
    func titleOfViewController(at position: Int) -> String?
    func childViewControllers() -> [UIViewController]
}

class CustomPageController: UIView {
    weak var delegate: CustomPageControllerDelegate?
    var topContainorView = UIView(frame: CGRect.zero)
    var topStackView: UIStackView = UIStackView(frame: CGRect.zero)
    var buttonArray: [UIButton] = []
    var underLineView = UIView(frame: CGRect.zero)
    var underLineViewLeadingConstraint :NSLayoutConstraint?
    var pageController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var selectedButton: UIButton?
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
        print("\(String(describing: self)) deinit called")
    }
    
    func setupViewLayout() {
        let stackViewHeight : CGFloat = 50
        let underLineViewHeight : CGFloat = 5
        
        self.backgroundColor = UIColor.clear
        topContainorView.backgroundColor = UIColor.appRed
        topContainorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topContainorView)
        topContainorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        topContainorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        topContainorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topContainorView.heightAnchor.constraint(equalToConstant: (stackViewHeight+underLineViewHeight+4.0)).isActive = true
        
        topStackView.backgroundColor = UIColor.clear
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.contentMode = .center
        topStackView.distribution = .fillEqually
        topStackView.spacing = 8
        topContainorView.addSubview(topStackView)
        
        topStackView.topAnchor.constraint(equalTo: topContainorView.topAnchor, constant: 0).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: topContainorView.leadingAnchor, constant: 0).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: topContainorView.trailingAnchor, constant: 0).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: stackViewHeight).isActive = true
        
        let numberOfButtons = delegate?.numberOfViewControllers() ?? 0
        setTopButtons(numberOfButtons)
        
        underLineView.backgroundColor = UIColor.appWhite
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        topContainorView.addSubview(underLineView)
        underLineViewLeadingConstraint = underLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selectedButton?.frame.origin.x ?? 0)
        underLineViewLeadingConstraint?.isActive = true
        underLineView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 0).isActive = true
        underLineView.heightAnchor.constraint(equalToConstant: underLineViewHeight).isActive = true
        underLineView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: CGFloat((1.0/CGFloat(numberOfButtons > 0 ? numberOfButtons : 1))), constant: -4).isActive = true
        
        self.pageController.view.backgroundColor = UIColor.clear
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageController.view)
        pageController.view.topAnchor.constraint(equalTo: topContainorView.bottomAnchor, constant: 0).isActive = true
        pageController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        pageController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        self.pageController.dataSource = self
        self.pageController.delegate = self
        let orderedViewControllers = delegate?.childViewControllers() ?? []
        
        let parentController = delegate?.parentController()
        parentController?.addChild(self.pageController)
        pageController.didMove(toParent: parentController)
        
        self.pageController.setViewControllers([orderedViewControllers[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    //To setup top button
    private func setTopButtons(_ numberOfButtons: Int) {
        
        for i in 0..<numberOfButtons {
            
            let button = UIButton()
            button.setTitle(delegate?.titleOfViewController(at: i) ?? "", for: .normal)
            topStackView.addArrangedSubview(button)
            button.backgroundColor = UIColor.appRed
            button.setTitleColor(UIColor.appWhite, for: .normal)
            button.titleLabel?.font = UIFont.semiBold(fontSize: 18)
            button.tag = i
            button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
            buttonArray.append(button)
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let orderedViewControllers = delegate?.childViewControllers() ?? []
        self.pageController.setViewControllers([orderedViewControllers[sender.tag]], direction: (sender.tag > (selectedButton?.tag ?? 0)) ? .forward : .reverse, animated: true, completion: nil)
        
        selectedButton = sender
        updateUnderLineViewConstraint()
    }
    
    func updateUnderLineViewConstraint() {
        underLineViewLeadingConstraint?.constant = selectedButton?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

//MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension CustomPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let orderedViewControllers = delegate?.childViewControllers(),
              let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0,
              orderedViewControllers.count > previousIndex  else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let orderedViewControllers = delegate?.childViewControllers(),
              let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex,
              orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let orderedViewControllers = delegate?.childViewControllers() ?? []
        if completed {
            guard let newViewController = pageViewController.viewControllers?.first,
                  let index = orderedViewControllers.firstIndex(of: newViewController) else { return }
            
            selectedButton = buttonArray[index]
            updateUnderLineViewConstraint()
        }
    }
}
