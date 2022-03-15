//
//  ArticlesViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import UIKit
import SafariServices

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var tableArray: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepare source list to be used later (articleCellDidPressSourceButton)
        DataManager.shared.fetchSources()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getDataFromServer()
    }
    
    private func getDataFromServer() {
        //[weak self] - refere itself weakly, to avoid retain cycle
        Networking.shared.getTopHeadlines(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                //an error occoured
                print(error)
            case .success(let articles):
                //we got response
                self.tableArray = articles
                self.tableView.reloadData() //refresh list
            }
        }
    }
    
    //here we can stop a segue from happening
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        /*
         sender - the one that clicked - is cell in tableView
         cell has a valid index
         if url is nil, abort segue
         */
        if identifier == "showWebPage",
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            return tableArray[indexPath.row].url != nil
        }
        
        return true
    }
    
    //notify before moving to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
         segue.destination is WebPageViewController
         sender - the one that clicked - is cell in tableView
         cell has a valid index
         */
        if segue.identifier == "showWebPage",
           let webPageVC = segue.destination as? WebPageViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            
            webPageVC.article = tableArray[indexPath.row]
            
        }
    }
    
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    //how many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    //what to show on each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get prototype cell element
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        
        //fill it
        let article = tableArray[indexPath.row]
        cell.populate(with: article)
        cell.delegate = self

        //return it
        return cell
    }
    
    //user clicked on row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //remove selection indication (gray highlight)
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*
         Alternatively, we can display the Article in Safari View Conroller, to provide the best native User Experience (UX) to the user
         //note: import SafariServices
         */
/*
        guard let url = tableArray[indexPath.row].url else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
 */
    }
    
}

extension ArticlesViewController : ArticleCellDelegate {
    
    func articleCellDidPressSourceButton(_ cell: ArticleCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let article = tableArray[indexPath.row]
        print(article)
    }
    
}
