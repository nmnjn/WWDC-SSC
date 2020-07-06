//
//  ChapterOnePageThree.swift
//  BookCore
//
//  Created by Naman Jain on 13/05/20.
//

import Foundation

import UIKit
import PlaygroundSupport
import NaturalLanguage

public class ChapterOnePageThreeController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {

    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        return tableView
    }()

    
    //MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
    //MARK: - Properties
    var messages = ["Thank you for this oppurtunity", "I love coding!", "Today was a bad day.", "She is so beautiful!!"]
    var sentimentDetection = true
    var message = ""
    let sentimentPredictor = try! NLModel(mlModel: SentimentClassifier().model)
    
    
    //MARK: - MessageHandler Methods
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .boolean(bool):
            self.sentimentDetection = bool
            self.tableView.reloadData()
            break
        case let .string(text):
            if(text != self.messages.last){
                self.messages.append(text)
                self.tableView.reloadData()
            }
        default:
            break
        }
    }
}



extension ChapterOnePageThreeController {
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        
        let image = UIImageView()
        image.image = UIImage(named: "messages.png")
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        image.frame = view.frame
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! MessagesTableViewCell
        cell.selectionStyle = .none
        let message = messages[indexPath.row]
        cell.messageTitle.text = message
        
        
        if sentimentDetection{
            let result = sentimentPredictor.predictedLabel(for: message)

            if(result == "positive"){
                cell.sentimentTitle.text = "😁"
            }else{
                cell.sentimentTitle.text = "🤕"
//                cell.detailTextLabel?.text = ""
            }
        }

        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


class MessagesTableViewCell: UITableViewCell {
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPink.withAlphaComponent(0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.systemBlue.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 15
        view.layer.cornerRadius = 20
//        view.layer.m  asksToBounds = true
        return view
    }()
    
    lazy var messageTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var sentimentTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardView)
        addSubview(messageTitle)
        addSubview(sentimentTitle)
        
        backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)

        messageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
//        messageTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 64).isActive = true
        messageTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        messageTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
        
        sentimentTitle.topAnchor.constraint(equalTo: messageTitle.topAnchor, constant: 0).isActive = true
        sentimentTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        sentimentTitle.bottomAnchor.constraint(equalTo: messageTitle.bottomAnchor, constant: 0).isActive = true
        
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        cardView.leftAnchor.constraint(equalTo: messageTitle.leftAnchor, constant: -24).isActive = true
        cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
