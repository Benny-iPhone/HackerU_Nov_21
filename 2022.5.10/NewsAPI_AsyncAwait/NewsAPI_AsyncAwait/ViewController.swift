//
//  ViewController.swift
//  NewsAPI_AsyncAwait
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import UIKit


struct ArticleResponse: Codable {
    
    struct Article: Codable {
        let title: String
    }
    
    let articles: [Article]
    
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var response: ArticleResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchArticles()
    }
    
    private func fetchArticles() {
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let data = try await getDataFromServer()
                self.response = try self.parse(data: data)
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func getDataFromServer() async throws -> Data {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-04-10&sortBy=publishedAt&apiKey=bd10f79c843d4116bb36c91f6333584b")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    private func parse(data: Data) throws -> ArticleResponse {
        return try JSONDecoder().decode(ArticleResponse.self, from: data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = response?.articles[indexPath.row].title
        
        return cell
    }


}

