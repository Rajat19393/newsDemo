//
//  ArticleCell.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPublishedAt: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelSourceId: UILabel!
    @IBOutlet weak var labelSourceName: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    
    var articleObject : Articles! {
        didSet {
            self.labelTitle.setText(self.articleObject.title, "TITLE")
            self.labelDescription.setText(self.articleObject.description, "DESCRIPTION")
            self.labelPublishedAt.setText(self.articleObject.publishedAt, "PUBLISHED AT")
            self.labelContent.setText(self.articleObject.content, "CONTENT")
            self.labelAuthor.setText(self.articleObject.author, "AUTHOR")
            if let sourceObject = self.articleObject.source {
                self.labelSourceId.setText(sourceObject.id, "SOURCE ID")
                self.labelSourceName.setText(sourceObject.name, "SOURCE NAME")
            }
            self.imageArticle.imageFromServerURL(self.articleObject.urlToImage, placeHolder: UIImage(named: "news-placeholder"))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
