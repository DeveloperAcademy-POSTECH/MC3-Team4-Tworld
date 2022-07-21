////
////  ProgressUpdateModalViewController.swift
////  SueobHaro
////
////  Created by Sooik Kim on 2022/07/20.
////
//
//import UIKit
//
//class ProgressUpdateModalViewController: UIViewController, UITextFieldDelegate {
//    
//    typealias completion = (String, Bool) -> Void
//    var updateCompletion:completion!
//    
//    public var value: String?
//    //저장하기 버튼
//    private lazy var uiButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("저장하기", for: .normal)
//        button.layer.cornerRadius = 10
//        
//        button.layer.backgroundColor = UIColor.theme.spLightBlue.cgColor
//        button.addTarget(self, action: #selector(animateDismissView), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
//    //클래스명
//    private var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "코딩 영재반"
//        label.font = .systemFont(for: .title2)
//        label.textColor = .theme.greyscale1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    //클래스회차
//    private let countLabel: UILabel = {
//        let label = UILabel()
//        label.text = "4회차"
//        label.font = .systemFont(for: .caption)
//        label.textAlignment = .center
//        label.textColor = .theme.greyscale7
//        label.layer.cornerRadius = 16
//        label.clipsToBounds = true
//        label.layer.backgroundColor = UIColor.theme.spLightBlue.cgColor
//        label.layer.frame.size.width = 42
//        label.layer.frame.size.height = 24
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    //스케쥴 일자
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "2022.7.16(토)"
//        label.font = .systemFont(for: .body1)
//        label.textColor = .theme.greyscale1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    //스케쥴 시간
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "13:00~15:00"
//        label.font = .systemFont(for: .body1)
//        label.textColor = .theme.greyscale3
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    //텍스트필드 타이틀
//    private let textFiledTitle: UILabel = {
//        let label = UILabel()
//        label.text = "진행상황"
//        label.font = .systemFont(for: .body1)
//        label.textColor = .theme.greyscale3
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    //텍스트필드
//    private lazy var uiTextFiled: UITextField = {
//        let textField = UITextField()
//        
//        textField.textColor = .theme.greyscale1
//        textField.borderStyle = .none
//        textField.tintColor = .theme.spLightBlue
//        textField.autocorrectionType = .no
////        textField.tintColor = .theme.spLightBlue
////        textField.clipsToBounds = true
//        textField.clearButtonMode = .whileEditing
//        return textField
//        
//    }()
//    //각 요소 담아주는 컨테이너 뷰
//    // 1
//    lazy var containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .theme.greyscale6
//        view.layer.cornerRadius = 20
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        view.clipsToBounds = true
////        view.addSubview(uiButton)
//        view.addSubview(titleLabel)
//        view.addSubview(countLabel)
//        view.addSubview(dateLabel)
//        view.addSubview(timeLabel)
//        view.addSubview(textFiledTitle)
//        view.addSubview(uiTextFiled)
//        view.addSubview(uiButton)
//        
//        return view
//    }()
//    
//    //백그라운드 디머
//    lazy var dimmedView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.alpha = 0.7
//        return view
//    }()
//    //기본 높이
//    let defaultHeight: CGFloat = 300
//    
//    // 3. Dynamic container constraint
//    var containerViewTopConstraint: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        uiTextFiled.text = value
//        uiTextFiled.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        
//        self.setupView()
//        self.setupConstraints()
//        uiTextFiled.delegate = self
//        showBottomSheet()
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        uiTextFiled.becomeFirstResponder()
//    }
//    
//    func setupView() {
//        view.backgroundColor = .clear
//    }
//    
//    
//    
//    func setupConstraints() {
//        // 4. Add subviews
//        titleLabel.frame.size = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: titleLabel.frame.height))
//        timeLabel.frame.size = timeLabel.sizeThatFits(CGSize(width: timeLabel.frame.width, height: timeLabel.frame.height))
//        dateLabel.frame.size = dateLabel.sizeThatFits(CGSize(width: dateLabel.frame.width, height: dateLabel.frame.height))
//        textFiledTitle.frame.size = textFiledTitle.sizeThatFits(CGSize(width: textFiledTitle.frame.width, height: textFiledTitle.frame.height))
//        uiTextFiled.frame.size = CGSize(width: view.frame.width-32, height: 27)
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: 23, width: uiTextFiled.frame.width, height: 1)
//        border.backgroundColor = UIColor.theme.spLightBlue.cgColor
//        uiTextFiled.layer.addSublayer((border))
//        
//        view.addSubview(dimmedView)
//        view.addSubview(containerView)
//
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 5. Set static constraints
//        NSLayoutConstraint.activate([
//            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
//            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
//        uiTextFiled.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox),
//            countLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16 + 12 + titleLabel.frame.width),
//            countLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox),
//            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox + titleLabel.frame.height + CGFloat.padding.toText),
//            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16 + 12 + dateLabel.frame.width),
//            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox + titleLabel.frame.height + CGFloat.padding.toText),
//            textFiledTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            textFiledTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox + titleLabel.frame.height + CGFloat.padding.toText + dateLabel.frame.height + CGFloat.padding.toBox),
//            uiTextFiled.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            uiTextFiled.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox + titleLabel.frame.height + CGFloat.padding.toText + dateLabel.frame.height + CGFloat.padding.toBox + CGFloat.padding.toText + 24),
//            uiButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            uiButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat.padding.toBox + titleLabel.frame.height + CGFloat.padding.toText + dateLabel.frame.height + CGFloat.padding.toBox + CGFloat.padding.toText + 24 + 71.8),
//            uiButton.widthAnchor.constraint(equalToConstant: view.frame.size.width - 32),
//            uiButton.heightAnchor.constraint(equalToConstant: 52),
//            countLabel.widthAnchor.constraint(equalToConstant: 42),
//            countLabel.heightAnchor.constraint(equalToConstant: 24),
//            
//        ])
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
//        containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
//        NSLayoutConstraint.activate([
//            // set container static constraint (trailing & leading)
//            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            containerViewTopConstraint,
//        ])
//
//        
//    }
//    
//    private func showBottomSheet() {
//        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
//        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
//        
//        containerViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
//        
//        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
//                    // 4 - 1
//            self.dimmedView.alpha = 0.7
//                    // 4 - 2
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
//    @objc func animateDismissView() {
//        if value != "" {
//            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
//            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
//            UIView.animate(withDuration: 0.3) {
//                self.containerViewTopConstraint.constant = (safeAreaHeight + bottomPadding)
//                // call this to trigger refresh constraint
//                self.view.layoutIfNeeded()
//            }
//            // hide blur view
//            dimmedView.alpha = 0.7
//            UIView.animate(withDuration: 0.4) {
//                self.dimmedView.alpha = 0
//            } completion: { _ in
//                // once done, dismiss without animation
//                self.updateCompletion(self.value ?? "", true)
//                self.dismiss(animated: false)
//            }
//        }
//        
//    }
//    
//    @objc func keyboardWillShow(_ sender: Notification) {
//        if let userInfo = sender.userInfo,
//                // 3
//            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                self.containerView.frame.origin.y = self.containerView.frame.origin.y - keyboardRectangle.height
//            }
//        
//    }
//
//    @objc func keyboardWillHide(_ sender: Notification) {
//        if let userInfo = sender.userInfo,
//                // 3
//            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                self.containerView.frame.origin.y = self.containerView.frame.origin.y + keyboardRectangle.height
//            }
//        
//
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }
//    
////
////    func textFieldDidBeginEditing(_ textField: UITextField) {
////        if textField.text == "" {
////            uiButton.backgroundColor = UIColor.theme.greyscale4
////        } else {
////            uiButton.backgroundColor = UIColor.theme.spLightBlue
////        }
////        uiTextFiled.tintColor = .theme.spLightBlue
////        print("begin")
////
////    }
////
////    func textFieldDidEndEditing(_ textField: UITextField) {
////        value = textField.text ?? ""
////        if textField.text == "" {
////            uiButton.backgroundColor = UIColor.theme.greyscale4
////        } else {
////            uiButton.backgroundColor = UIColor.theme.spLightBlue
////        }
////        print("end")
////        uiTextFiled.tintColor = .theme.greyscale1
////    }
//    
//    
//    //TextField 입력 시 값 변화에 따른 반응
////    func textFieldDidChangeSelection(_ textField: UITextField) {
////        if textField.text == "" {
////            uiButton.backgroundColor = UIColor.theme.greyscale4
////        } else {
////            uiButton.backgroundColor = UIColor.theme.spLightBlue
////        }
////        value = textField.text ?? ""
////    }
//    
//}
//
//
//extension ProgressUpdateModalViewController {
//    //TextFiled 값 변화에 따른 반응
//    @objc func textFieldDidChange(_ sender: Any?) {
//        if uiTextFiled.text == "" {
//            uiButton.backgroundColor = UIColor.theme.greyscale4
//        } else {
//            uiButton.backgroundColor = UIColor.theme.spLightBlue
//        }
//        self.value = self.uiTextFiled.text
//    
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
