//
//  ViewController.swift
//  SampleApp
//
//  Created by Tara Singh M C on 15/02/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showCustomView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var addCustomShortcutView: AddCustomShortcutView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        tableView.register(JobTableViewCell.self)
//        tableView.dataSource = self
    }

    @IBAction func showCustomView(_ sender: Any, forEvent event: UIEvent) {
        let customView = AddCustomShortcutView(frame: .zero)
        customView.backgroundColor = UIColor.groupTableViewBackground
        customView.layer.cornerRadius = 12.0
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.delegate = self
        self.view.addSubview(customView)
        
        self.addCustomShortcutView = customView

        
        let conX = customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let conBottom = customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.size.width-20)
        let conWidth = customView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0)
       // let conHeight = customView.heightAnchor.constraint(equalTo: customView.widthAnchor )
        let conHeight = customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6, constant: 0)

        NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight])
        view.layoutIfNeeded()
        
        self.addCustomShortcutView.bottomConstraint = conBottom
        
        
        UIView.animate(
        withDuration: 0.8) {
            conBottom.constant = 0
            self.view.layoutIfNeeded()

        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeue(NameTableViewCell.self, forIndexPath: indexPath)
            cell.backgroundColor = .red
            return cell
        }
        
        let cell = tableView.dequeue(JobTableViewCell.self, forIndexPath: indexPath)
        //cell.backgroundColor = .green
        return cell
      
    }
    
    
  
    
    
}

extension ViewController: AddCustomShortcutViewDelegate {
    
    func dismiss(view: AddCustomShortcutView) {
        
        UIView.animate(withDuration: 0.8, animations: {
             self.addCustomShortcutView.bottomConstraint?.constant = self.addCustomShortcutView.frame.size.height
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.addCustomShortcutView.removeFromSuperview()

        })

        
    }
    
    
}
