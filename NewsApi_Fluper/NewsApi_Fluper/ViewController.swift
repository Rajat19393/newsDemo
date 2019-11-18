//
//  ViewController.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var newsFeedTable: UITableView!
    let viewModel = ViewControllerViewModel()
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        self.context = self.appDelegate.persistentContainer.viewContext
        viewModel.getNewsData(self, context, appDelegate) { (success) in
            if success {
                self.newsFeedTable.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        let article = viewModel.cellArticle(index: indexPath.row)
        articleCell.articleObject = article
        return articleCell
    }
}
