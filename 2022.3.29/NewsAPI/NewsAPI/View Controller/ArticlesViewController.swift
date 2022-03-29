//
//  ArticlesViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import UIKit
import SafariServices
import PKHUD
import CCBottomRefreshControl

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var tableArray: [Article] = []
    var page: Int = 1
    public var loadOnStart: Bool {
        true
    }
    
    //MARK: - UI Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepare source list to be used later (articleCellDidPressSourceButton)
        
        registerCellNib()
        tableView.dataSource = self
        tableView.delegate = self
        
        if loadOnStart {
            getDataFromServer(true)
        }
        
        setupTopRefreshControl()
        setupBottomRefreshControl()
    }
    
    //hook our tableview with ArticleCell.xib
    private func registerCellNib() {
        tableView.register(UINib(nibName: "ArticleCell", bundle: .main), forCellReuseIdentifier: "cell")
    }
    
    private func setupTopRefreshControl() {
        //setup pull to refresh
        let refreshControl = UIRefreshControl()
        //hook IBAction by code
        refreshControl.addTarget(self, action: #selector(topRefreshControlAction(_: )), for: .valueChanged)
        //add to UI
        tableView.refreshControl = refreshControl
    }
    
    private func setupBottomRefreshControl() {
        //setup pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = 100
        //hook IBAction by code
        refreshControl.addTarget(self, action: #selector(bottomRefreshControlAction(_: )), for: .valueChanged)
        //add to UI
        tableView.bottomRefreshControl = refreshControl
    }
    
    //MARK: - Actions
    
    @objc func bottomRefreshControlAction(_ sender: UIRefreshControl) {
        //increment page
        self.page += 1
        //get more data
        getDataFromServer(false)
    }
    
    @objc func topRefreshControlAction(_ sender: UIRefreshControl) {
        startOver()
    }
    
    //MARK: - Get Data
    
    func startOver() {
        //cleanup old data, start over also requires to set the page to 1
        self.page = 1
        self.tableArray = []
        //get new data
        getDataFromServer(false)
    }
    
    //open - can be overrided, even by other target
    open func sendNetworkingRequest() {
        
    }
   
    private func getDataFromServer(_ showProgress: Bool) {
        
        if showProgress {
            //show loading inidication, if requested
            HUD.show(.progress)
        }
        
        sendNetworkingRequest()
    }
    
    //public - exposed, can not be overrided by other target
    public func handle(result: Result<[Article],Networking.NetworkingError>) {
        //stop top & bottom refresh-controls
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.bottomRefreshControl?.endRefreshing()
        
        //handle the result
        switch result {
        case .failure(let error):
            //an error occoured
            //HUD.flash(.error, delay: 1.0)
            HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil), delay: 1)
            
            print(error)
        case .success(let articles):
            //we got response
            //HUD.flash(.success, delay: 1.0)
            HUD.hide()
            
            if self.page == 1 {
                self.tableArray = articles
            } else {
                self.tableArray += articles
            }
        }
        
        self.tableView.reloadData() //refresh list
    }
    
    //MARK: - Navigation
    /*
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
    */
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
        
        handleSelection(of: tableArray[indexPath.row])
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
    
    private func handleSelection(of article: Article) {
        let webPageVC = self.storyboard?.instantiateViewController(withIdentifier: "WebPageViewController") as! WebPageViewController
        webPageVC.article = article
        self.navigationController?.pushViewController(webPageVC, animated: true)
    }
    
}

extension ArticlesViewController : ArticleCellDelegate {
    
    func articleCellDidPressSourceButton(_ cell: ArticleCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        //get article source object
        let article = tableArray[indexPath.row]
        //check for null values
        guard let sourceId = article.source?.id,
              let source = DataManager.shared.getSourceBy(id: sourceId) else {
                  return
              }
        
        //create ArticleSourceViewController object
        guard let articleSourceVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleSourceViewController") as? ArticleSourceViewController else {
            return
        }
        //set its source objecgt
        articleSourceVC.source = source
        //display the source view controller
        self.navigationController?.pushViewController(articleSourceVC, animated: true)
    }
    
}
