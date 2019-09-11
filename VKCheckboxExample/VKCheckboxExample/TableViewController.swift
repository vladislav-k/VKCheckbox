//
//  TableViewController.swift
//  VKCheckboxExample
//
//  Created by Vladislav Kovalyov on 8/16/17.
//  Copyright © 2016 WOOPSS.com http://woopss.com/ All rights reserved.
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

class TableViewController: UITableViewController
{
    var selectedRows = [Int]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension TableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let title = "Item \(indexPath.row + 1)"
        cell.setTitle(title)
        cell.checkbox.setOn(self.selectedRows.contains(indexPath.row), animated: false)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !self.selectedRows.contains(indexPath.row)
        {
            self.selectedRows.append(indexPath.row)
        }
        else
        {
            let index = self.selectedRows.firstIndex(of: indexPath.row)!
            self.selectedRows.remove(at: index)
        }
        
        let selected = self.selectedRows.contains(indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.checkbox.setOn(selected, animated: true)
    }
}
