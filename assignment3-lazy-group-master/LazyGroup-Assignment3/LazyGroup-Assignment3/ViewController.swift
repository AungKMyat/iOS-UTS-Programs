//
//  ViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Junghyun Eom on 22/5/21.
//

import UIKit

class ViewController: UIViewController {

    
    var userName: String? = nil
    var isA: Bool = false
    var startingTimer = Timer()
    var timeLeft = 3
    
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fadeOutLabel()
        self.fadeOutImage()
        
        startingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            startingTimer in
            self.timeLeft -= 1
            if (self.timeLeft < 0){
                startingTimer.invalidate()
                self.isA = true
                self.startAPP()
            }
        }
        
        
        loadingIndicator.isAnimating = true
        
        
        userName = UserDefaults.standard.string(forKey: "DB")
        
    }
    
    @objc func startAPP(){
        if isA == true {
            if userName == nil
                {
                    let vc = storyboard?.instantiateViewController(identifier: "RegiViewController") as! RegiViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.navigationItem.setHidesBackButton(true, animated: true)
                }else
                    {
                        let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.navigationItem.setHidesBackButton(true, animated: true)
                    }
        }
    }
    
    @objc func fadeOutImage() {
        logoImageView.isHidden = false
        UIView.animate(withDuration: 1, delay: 3, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.logoImageView.alpha = 0
        }, completion: { finished in
            self.logoImageView.isHidden = true
            self.isA = true
        })

    }
    
    @objc func fadeOutLabel() {
        logoLabel.isHidden = false
        UIView.animate(withDuration: 1, delay: 3, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.logoLabel.alpha = 0
        }, completion: { finished in
            self.logoLabel.isHidden = true
    
        })
   
    }

    // MARK: - UI Setup
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = .white
        
        //self.view.addSubview(helloLabel)
        self.view.addSubview(loadingIndicator)



        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()



}

