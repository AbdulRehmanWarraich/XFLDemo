//
//  ViewController+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

extension UIViewController {
    //MARK: -  Properties
    var myStoryBoard: UIStoryboard {
        
        if let currentStoryBoard = self.storyboard  {
            return currentStoryBoard
        } else {
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    //MARK: -  Functions
    /**
     Initialize a nib.
     - returns: UIViewController.
     */
    public class func fromNib<T>() -> T? where T : UIViewController {
        return fromNib(nibName: nil)
    }
    
    /**
     Initialize a nib.

     - parameter nibName: Nib name.
     
     - returns: UIViewController.
     */
    public class func fromNib<T>(nibName: String?) -> T? where T : UIViewController {
        
        let name = nibName ?? String(describing: self)
        return self.init(nibName: name, bundle: Bundle.main) as? T
    }
    
    /**
     Initialize a UIViewController from Storyboard.
     - returns: UIViewController.
     */
    class func instantiateViewControllerFromStoryboard<T>() -> T? where T : UIViewController {
        return instantiateViewController()
    }
    
    /**
     Initialize a UIViewController from Storyboard.
     - returns: UIViewController.
     */
    fileprivate class func instantiateViewController<T>() -> T? where T : UIViewController  {
        return UIViewController().myStoryBoard.instantiateViewController(withIdentifier: String(describing: self)) as? T
    }
    
}

//MARK: -  Present view controller
extension UIViewController {
    /**
     Presents ViewController with animation.
     
     - parameter viewControllerToPresent: ViewController to present.
     - parameter animated: With animation or not.
     - parameter modalTransitionStyle: Presentation style. Bydefault its 'coverVertical'.
     
     - returns: void.
     */
    open func presentPOPUP(_ viewControllerToPresent: UIViewController,
                           animated flag: Bool,
                           modalPresentationStyle: UIModalPresentationStyle = .overCurrentContext,
                           modalTransitionStyle:UIModalTransitionStyle = .coverVertical,
                           completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            viewControllerToPresent.modalPresentationStyle = modalPresentationStyle
            viewControllerToPresent.modalTransitionStyle = modalTransitionStyle
            
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}
