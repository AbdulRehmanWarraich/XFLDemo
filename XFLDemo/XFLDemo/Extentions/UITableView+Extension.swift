//
//  UITableView+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

extension UITableView {
    
    ///Hides Default Sperator of UITableView
    func hideDefaultSeprator() {
        self.separatorColor = UIColor.clear
        self.separatorStyle = .none
    }
    
    ///Deque cell of a UITableView
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(forIndexPath: nil)
    }
    
    /**
     Deque cell of a UITableView for index path.
     
     - parameter forIndexPath: Index path for dequing cell.
     
     - returns: void.
     */
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath?) -> T? {
        
        if let myCell: T = self.dequeueReusableCell(indexPath) {
            return myCell
            
        } else {
            
            self.register(UINib(nibName: T.self.cellIdentifier(), bundle: Bundle.main), forCellReuseIdentifier: T.self.cellIdentifier())
            
            if let myCell: T = self.dequeueReusableCell(indexPath) {
                return myCell
                
            } else {
                return nil
            }
        }
    }
    
    /**
     Deque cell of a UITableView for index path.
     
     - parameter forIndexPath: Index path for dequing cell.
     
     - returns: void.
     */
    private func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath?) -> T? {
        
        if let myIndexPath = indexPath {
            
            if let cell = self.dequeueReusableCell(withIdentifier: T.self.cellIdentifier(), for: myIndexPath) as? T {
                return cell
            } else {
                return nil
            }
        } else {
            
            if let cell = self.dequeueReusableCell(withIdentifier: T.self.cellIdentifier()) as? T {
                return cell
            } else {
                return nil
            }
        }
    }
    
    /**
     A method that registers the given cell with the tableView and dequeue it using cell's class name as identifier. The purpose of this method is to reduce the code repeatition using generics.
     - parameter indexPath: The indexPath of the current cell
     */
    
    func register<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        self.register(UINib(nibName: String(describing: T.self), bundle: .main), forCellReuseIdentifier: String(describing: T.self))
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
    
    func reloadTableViewData(_ description: String = Constants.generalNoData) {
        self.reloadData()
        
        if (self.numberOfSections <= 0 || self.numberOfRows(inSection: 0) <= 0 ) {
            self.showDescriptionViewWithImage(description: description)
            
        } else {
            self.hideDescriptionView()
        }
    }
}
