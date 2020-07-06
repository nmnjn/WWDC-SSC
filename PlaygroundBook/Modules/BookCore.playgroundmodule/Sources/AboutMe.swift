//
//  AboutMe.swift
//  BookCore
//
//  Created by Naman Jain on 16/05/20.
//

import UIKit
import PlaygroundSupport

public class AboutMeViewController: UITableViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        tableView.register(AboutMeCell.self, forCellReuseIdentifier: "cellId")
    }
    
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AboutMeCell
        cell.selectionStyle = .none
        return cell
    }
    
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}


class AboutMeCell: UITableViewCell{

    let photo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Naman.jpg")
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "Hello 👋\n I am Naman Jain."
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        label.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "I am a Computer Science Student\nfrom India. 🇮🇳"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = UIColor.systemPink.withAlphaComponent(0.75)
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "I like solving day to day problems by writing code. I believe it is the best way to help people and add value to the society! ♥️"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = UIColor.systemGray.withAlphaComponent(0.75)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "I also enjoy videography and dancing! 🕺🏼"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = UIColor.orange.withAlphaComponent(0.75)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.text = "Thank you for checking out my Swift Playground!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = UIColor.systemTeal.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    let label6: UILabel = {
        let label = UILabel()
        label.text = "🤝"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = UIColor.systemTeal.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 44)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        addSubview(photo)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(label5)
        addSubview(label6)
        
        _ = photo.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, topConstant: 75, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        photo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.photo.transform = CGAffineTransform(rotationAngle: .pi)
        
        _ = label1.anchor(top: photo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        _ = label2.anchor(top: label1.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 16, rightConstant: 32, widthConstant: 0, heightConstant: 0)
        _ = label3.anchor(top: label2.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 50, bottomConstant: 16, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        _ = label4.anchor(top: label3.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        _ = label5.anchor(top: label4.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        _ = label6.anchor(top: label5.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.photo.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.photo.transform = .identity
                self.label1.alpha = 1
            }) { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.label2.alpha = 1
                }) { (_) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.label3.alpha = 1
                        self.label1.alpha = 0
                    }) { (_) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.label4.alpha = 1
                            self.label1.alpha = 1
                        }) { (_) in
                            UIView.animate(withDuration: 0.6, animations: {
                                self.label5.alpha = 1
                            }) { (_) in
                                UIView.animate(withDuration: 0.2, animations: {
                                    self.label6.alpha = 1
                                }) { (_) in
                                    UIView.animate(withDuration: 0.75, delay: 0, options: [.repeat, .autoreverse], animations: {
                                        self.label6.alpha = 0.6
                                    }, completion: nil)
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIView {
    
    @objc func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstants(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    @objc func anchorWithConstants(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        _ = anchor(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    @objc func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
}
