//
//  TabBarController.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 10/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        var tabFrame: CGRect = tabBar.frame
        tabFrame.size.height = 55
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            
            //iPhone X
            tabFrame.origin.y = view.frame.size.height - 65
            for vc in self.viewControllers! {
                if vc.nibName! != "REC-MH-qc5-view-HML-ya-tzH" {
                    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(25, 0, -25, 0)
                }
                
            }
            
        }
        else
        {
            
            tabFrame.origin.y = view.frame.size.height - 55
            
        }
        
        tabBar.frame = tabFrame
        
        self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color:UIColor(
            red: 255/255,
            green: 255/255,
            blue: 255/255,
            alpha: 1.0), size: CGSize(width: (tabBar.frame.width)/CGFloat((tabBar.items!.count)), height: (tabBar.frame.height)), lineHeight: tabBar.frame.height)
        
    }

}
