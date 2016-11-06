//
//  TaskGroup.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit

class TaskGroup: UIView
{
    // Lets us know once we have done our intiial constraint set-up.
    var shouldSetUpConstraints = true;
    
    // MARK: Initialization
    // Since this view will be used in a storyboard, we override its superclass's init?(coder:) initializer.
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func updateConstraints()
    {
        if (shouldSetUpConstraints)
        {
            shouldSetUpConstraints = false;
        }
        super.updateConstraints();
    }
}
