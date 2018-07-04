//
//  WebViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 7/3/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    //Property
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    
    var URL: URL?
    
    var loadingTime: Timer?
    var finishLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupWebView()
        loadRequest()
    }

    override func loadView() {
        super.loadView()
        createUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let bound = navigationController?.navigationBar.bounds {
            self.progressView.frame = CGRect(x: 0, y: bound.height - 2, width: bound.width, height: 2)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let toolbar = navigationController?.toolbar {
            var frame = toolbar.frame
            let currentHeight = frame.height
            let newHeight: CGFloat = 56.0
            let valueChange = newHeight - currentHeight
            
            frame.size.height = newHeight
            frame.origin.y -= valueChange
            toolbar.frame = frame
            
            let scrollView = webView.scrollView
            scrollView.scrollIndicatorInsets.bottom = valueChange
            scrollView.contentInset.bottom = valueChange
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.navigationController?.setToolbarHidden(false, animated: false)
        progressView.removeFromSuperview()
    }
    
    deinit {
        webView.stopLoading()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //MARK:- Create UI
    
    func createUI() {

        let configrution = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configrution)
        self.view = webView
        self.webView = webView
        
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView.progressTintColor = .red
        progressView.trackTintColor = .clear
        if let nav = navigationController?.navigationBar {
            nav.addSubview(progressView)
        }
        self.progressView = progressView
    }
    
    //MARK:- SETUP
    
    func setupWebView() {
        webView.navigationDelegate = self
        
    }
    
    func setupNavigationBar() {
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(dismissWebView))
        if let navController = navigationController {
            navController.navigationItem.rightBarButtonItem = item
        }
    }
    
    //MARK:- OBSERVE

    
    
    //MARK:- ACTION
    
    func loadRequest() {
        if let url = URL {
            webView.load(URLRequest(url: url))
        }
    }
    
}

extension WebViewController {
    @objc func dismissWebView() {
        guard let navController = navigationController else { return
            dismiss(animated: true, completion: nil)
        }
        navController.dismiss(animated: true, completion: nil)
    }
    
    @objc func timerCallBack() {
        if finishLoading {
            if progressView.progress >= 1 {
                progressView.isHidden = true
                loadingTime?.invalidate()
            } else {
                progressView.progress += 0.03
            }
        } else {
            let value = progressView.progress
            if value > 0.2 && value < 0.5 {
                progressView.progress += 0.001
            } else if value < 0.8 {
                progressView.progress += 0.01
            } else {
                progressView.progress = 0.8
            }
        }
    }
    
    func finishProgress()  {
        finishLoading = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func startProgress() {
        progressView.isHidden = false
        progressView.progress = 0.0
        finishLoading = false
        loadingTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        finishProgress()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startProgress()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        finishProgress()
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        finishProgress()
        print(error.localizedDescription)
    }
}

















