//
//  ArticleCell.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import UIKit
import SDWebImage
/*
 ArticleCellDelegate requires implementation by class only (: AnyObject)
 Only class reference can be weak.
 If the reference to the cell delegate will not be weak - a retain cycle will be created
 ArticlesViewController -> UITableView -> ArticleCell -> delegate (ArticlesViewController)
 */
protocol ArticleCellDelegate: AnyObject {
    
    func articleCellDidPressSourceButton(_ cell: ArticleCell)
    
}

class ArticleCell: UITableViewCell {
    
    weak var delegate: ArticleCellDelegate?

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    
    //like viewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sourceButton.titleLabel?.numberOfLines = 1
        sourceButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sourceButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    func populate(with article: Article) {
        articleTitleLabel.text = article.title
        
        //load image
        if let url = article.urlToImage { //load image for A
            articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else { //B
            //clean old image
            articleImageView.image = UIImage(named: "placeholder")
            //since cells are reusable, the same cell can be used for more then single article
            //clean old request, to avoid mismatch between previous populated article and current articles
            articleImageView.sd_cancelCurrentImageLoad()
        }
        
        //show source
        sourceButton.setTitle(article.source?.name, for: .normal)
        //if source-id is null, disable the button. Since we can not fetch more info
        if article.source?.id == nil {
            sourceButton.isEnabled = false
        } else {
            //enable the source button, bear in mind that cells are reusable, therefore the button might be disabled from previous article
            sourceButton.isEnabled = true
        }
        
        publishedDateLabel.text = article.publishedAt?.stringToDate_yyyy_MM_dd_T_HH_mm_ssZ()?.toRelativeString()
    }
    
    @IBAction func articleSourceAction(_ sender: Any) {
        delegate?.articleCellDidPressSourceButton(self)
    }
    

}

/*
 t - load article A | request image load (1s)
 t + 0.5 - load article B | display placeholder
 t + 1 - image load finised, show A's image
 */
