//
//  TableViewCell.swift
//  VKCheckboxExample
//
//  Created by Vladislav Kovalyov on 8/16/17.
//  Copyright © 2017 WOOPSS.com http://woopss.com/ All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var checkbox: VKCheckbox!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.checkbox.line             = .thin
        self.checkbox.bgColorSelected  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        self.checkbox.bgColor          = .gray
        self.checkbox.color            = .white
        self.checkbox.borderColor      = .white
        self.checkbox.borderWidth      = 2
        self.checkbox.cornerRadius     = self.checkbox.bounds.size.height / 2
    }

    func setTitle(_ title: String?)
    {
        self.labelTitle.text = title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
