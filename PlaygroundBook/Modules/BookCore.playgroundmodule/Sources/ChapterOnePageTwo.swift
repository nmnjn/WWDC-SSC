//
//  ChapterOnePageTwo.swift
//  BookCore
//
//  Created by Naman Jain on 09/05/20.
//

import Foundation

import UIKit
import PlaygroundSupport
import NaturalLanguage
import QuartzCore

public class ChapterOnePageTwoController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {

    
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

    var firstLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "Hello 1"
        return label
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
        tableView.register(SpamTableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    

    
    //MARK: - Properties
    var documents = ["Assignment Submission Deadline",  "Claim your free reward now!", "Thank you for registering with us!", "Hey Nina, How are you?"]
    
    var senders = ["Prof X",  "Grab101", "Apple Developer", "Mom", "New User"]
    var spamDetection = false
    let spamFilter = try! NLModel(mlModel: SpamFilter().model)
    var docs = [PlaygroundSupport.PlaygroundValue]()

    
    
    //MARK: - MessageHandler Methods
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .boolean(bool):
            self.spamDetection = bool
            self.tableView.reloadData()
            break
        case let .string(text):
            if(text != self.documents.last){
                self.senders.append("New User")
                self.documents.append(text)
                self.tableView.reloadData()
            }
        default:
            break
        }
    }
}



extension ChapterOnePageTwoController {
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 125
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        let image = UIImageView()
        image.image = UIImage(named: "mailbox.png")
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
        return documents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SpamTableViewCell
        cell.selectionStyle = .none
        let mail = documents[indexPath.row]
        let sender = senders[indexPath.row]
        cell.messageTitle.text = mail
        cell.senderTitle.text = sender
        
        if spamDetection{
            let result = spamFilter.predictedLabel(for: mail)!

            if(result == "spam"){
                cell.spamTitle.text = "SPAM"
                cell.spamOverlay.backgroundColor = .white
//                cell.detailTextLabel?.text = "SPAM"
            }else{
                cell.spamTitle.text = ""
                cell.spamOverlay.backgroundColor = .clear
//                cell.detailTextLabel?.text = ""
            }
        }

        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


class SpamTableViewCell: UITableViewCell {
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 10
//        view.layer.m  asksToBounds = true
        return view
    }()
    
    lazy var spamOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var messageTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var senderTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var spamTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemRed.withAlphaComponent(0.75)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        
        addSubview(cardView)
        addSubview(messageTitle)
        addSubview(senderTitle)
        addSubview(spamOverlay)
        messageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        messageTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        messageTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        senderTitle.topAnchor.constraint(equalTo: messageTitle.bottomAnchor, constant: 8).isActive = true
        senderTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        senderTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        senderTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true

        
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
        
        spamOverlay.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        spamOverlay.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        spamOverlay.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        spamOverlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
        spamOverlay.addSubview(spamTitle)
        spamTitle.fillSuperview()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
