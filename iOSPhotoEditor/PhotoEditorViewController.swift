//
//  ViewController.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 4/23/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

public final class PhotoEditorViewController: UIViewController {
    
    /** holding the 2 imageViews original image and drawing & stickers */
    @IBOutlet weak var canvasView: UIView!
    //To hold the image
    @IBOutlet public var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    //To hold the drawings and stickers
    @IBOutlet weak var canvasImageView: UIImageView!
    @IBOutlet public var imageSaveIcon: UIImageView!
    @IBOutlet public var imageDrawIcon: UIImageView!
    @IBOutlet public var imageStickerIcon: UIImageView!
    
    
    @IBOutlet public var imgText: UIImageView!

    @IBOutlet weak var topToolbar: UIView!
    @IBOutlet weak var bottomToolbar: UIView!

    @IBOutlet weak var topGradient: UIView!
    @IBOutlet weak var bottomGradient: UIView!
    
    @IBOutlet public var viewText: UIView!
    @IBOutlet weak var viewSaveImage: UIView!
    @IBOutlet weak var viewDrawImage: UIView!
    @IBOutlet weak var viewStickerImage: UIView!
    
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var colorPickerView: UIView!
    @IBOutlet weak var colorPickerViewBottomConstraint: NSLayoutConstraint!
    
    //Controls
    @IBOutlet public var doneButton: UIButton!
    @IBOutlet public var cropButton: UIButton!
    @IBOutlet public var stickerButton: UIButton!
    @IBOutlet public var drawButton: UIButton!
    @IBOutlet public var textButton: UIButton!
    @IBOutlet public var saveButton: UIButton!
    @IBOutlet public var shareButton: UIButton!
    @IBOutlet public var clearButton: UIButton!
    @IBOutlet public var cancelButton: UIButton!
    
    @IBOutlet weak var constraintBottomDeleteBtn: NSLayoutConstraint!
    public var image: UIImage?
    /**
     Array of Stickers -UIImage- that the user will choose from
     */
    public var stickers : [UIImage] = []
    /**
     Array of Colors that will show while drawing or typing
     */
    public var colors  : [UIColor] = []
    
    public var photoEditorDelegate: PhotoEditorDelegate?
    var colorsCollectionViewDelegate: ColorsCollectionViewDelegate!
    
    // list of controls to be hidden
    public var hiddenControls : [control] = []
    
    var stickersVCIsVisible = false
    var drawColor: UIColor = UIColor.black
    public var textColor: UIColor = UIColor.white
    var isDrawing: Bool = false
    var lastPoint: CGPoint!
    var swiped = false
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    public var lastTextViewFont:UIFont?
    public var activeTextView: UITextView!
    var imageViewToPan: UIImageView?
    var isTyping: Bool = false
    
    var stickersViewController: StickersViewController!
    
    var btnTitle = UIButton()
    let btnClose = UIButton()
    let btnDone = UIButton()
    
    var closeEditorType = 0

    //Register Custom font before we load XIB
    public override func loadView()
    {
        registerFont()
        super.loadView()
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        doneButton.isHidden = true
    }
    
    public override func viewWillAppear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doneButtonAction), name: .doneButtonAction, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(navButtonHideShow), name: .navButtonHideShow, object: nil)
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        btnTitle.titleLabel?.contentMode = .center
        btnTitle = UIButton(type: .custom)
        btnTitle .setTitle("Netra Stickers", for: UIControl.State.normal)
        btnTitle .setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 35.0)
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 28.0)
        }
        else
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 24.0)
        }
        
        btnTitle.contentHorizontalAlignment = .center
        btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 250)/2), y:10, width:250, height:20)
        navigationController?.navigationBar .addSubview(btnTitle)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        let draworigImage = UIImage(named: "drawline")
        let tintedImage = draworigImage?.withRenderingMode(.alwaysTemplate)
        //drawButton.tintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
       // drawButton.setImage(tintedImage, for: .normal)
        
        //stickerButton.tintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        //stickerButton.setImage(UIImage(named: "Smiley.png"), for: .normal)
        
        //let origImage1 = UIImage(named: "download")
        //let tintedImage1 = origImage1?.withRenderingMode(.alwaysTemplate)
        //saveButton.tintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        //saveButton.setImage(tintedImage1, for: .normal)
        
        imgText.tintColor = UIColor.white
        viewText.frame.size.height = viewText.frame.width
        viewText.layer.cornerRadius = viewText.frame.width / 2.0
        
        cancelButton.layer.cornerRadius = cancelButton.frame.width / 2.0
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            cancelButton.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
            cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
            
            viewText.frame = CGRect(x: UIScreen.main.bounds.width - 248, y: 15, width: 50, height: 50)
            
            //stickerButton.imageView?.contentMode = .scaleAspectFill
            viewStickerImage.frame = CGRect(x: self.viewText.frame.origin.x + self.viewText.frame.width + 12, y: 15, width: 50, height: 50)
            
            //drawButton.imageView?.contentMode = .scaleAspectFill
            viewDrawImage.frame = CGRect(x: self.viewStickerImage.frame.origin.x + self.viewStickerImage.frame.width + 12, y: 15, width: 50, height: 50)
            
            viewSaveImage.frame = CGRect(x: self.viewDrawImage.frame.origin.x + self.viewDrawImage.frame.width + 12, y: 15, width: 50, height: 50)
            
            viewText.layer.cornerRadius = viewText.frame.width / 2.0
            stickerButton.layer.cornerRadius =  stickerButton.frame.size.height / 2.0
            viewDrawImage.layer.cornerRadius =  viewDrawImage.frame.size.width / 2.0
            imageDrawIcon.layer.cornerRadius =  imageDrawIcon.frame.size.width / 2.0
            imageStickerIcon.layer.cornerRadius = imageStickerIcon.frame.size.width / 2.0
            imageSaveIcon.layer.cornerRadius =  imageSaveIcon.frame.size.width / 3
            
            if self.closeEditorType == 1
            {
                self.constraintBottomDeleteBtn.constant = 75
            }
            else
            {
                self.constraintBottomDeleteBtn.constant = 40
            }
        }
        else
        {
            stickerButton.layer.cornerRadius =  stickerButton.frame.size.height / 2.0
            viewDrawImage.layer.cornerRadius =  drawButton.frame.size.width / 2.0
            imageDrawIcon.layer.cornerRadius =  imageDrawIcon.frame.size.width / 2.0
            imageStickerIcon.layer.cornerRadius = imageStickerIcon.frame.size.width / 2.0
        }
        
        canvasImageView.image = nil
        
        for v in canvasImageView.subviews
        {
            v.removeFromSuperview()
        }
        
        //canvasView.frame = CGRect(x: 0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height)
        
        //activeTextView?.frame.origin.x = 20.0
        //activeTextView?.frame.origin.y = (self.view.frame.height - self.activeTextView.frame.size.height)/2.0 
        
        deleteView.layer.cornerRadius = deleteView.bounds.height / 2
        deleteView.layer.borderWidth = 2.0
        deleteView.layer.borderColor = UIColor.white.cgColor
        deleteView.clipsToBounds = true
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .bottom
        edgePan.delegate = self
        self.view.addGestureRecognizer(edgePan)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        configureCollectionView()
        stickersViewController = StickersViewController(nibName: "StickersViewController", bundle: Bundle(for: StickersViewController.self))
        hideControls()

        self.setImageView(image: image!)
        self.setNavigationButton()
        
        if UIScreen.main.bounds.height >= 812
        {
            self.canvasImageView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 125)
            self.canvasView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 125)
            self.imageView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 125)
        }
    }
    
    func setNavigationButton()
    {
        btnClose.setImage(UIImage(named: "Close.png"), for: .normal)
        btnClose.frame = CGRect(x: 8, y: 0, width: 44, height: 44)
        btnClose.addTarget(self, action: #selector(btnClosePressed), for: .touchUpInside)
        btnClose.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        btnDone.setImage(UIImage(named: "Done.png"), for: .normal)
        btnDone.frame = CGRect(x: self.view.frame.width - 54 , y: 0, width: 44, height: 44)
        btnDone.addTarget(self, action: #selector(btnDonePressed), for: .touchUpInside)
        btnDone.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        self.navigationController?.navigationBar.addSubview(btnClose)
        self.navigationController?.navigationBar.addSubview(btnDone)
        btnClose.isHidden = true
        btnDone.isHidden = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let viewHeight = self.view.frame.height
            let setHeight = viewHeight - keyboardHeight
            colorPickerView.frame.origin.y = setHeight - 38
            btnDone.isHidden = false
            btnClose.isHidden = false
            self.colorPickerView.isHidden = false
        }
    }
    
    @objc func btnClosePressed()
    {
        btnClose.isHidden = true
        btnDone.isHidden = true
        self.view.endEditing(true)
        colorPickerView.isHidden = true
        NotificationCenter.default.post(name: .navButtonHideShow, object: nil)
        NotificationCenter.default.post(name: .galleryNavButtonHideShow, object: nil)
    }
    
    @objc func btnDonePressed()
    {
        btnDone.isHidden = true
        btnClose.isHidden = true
        removeStickersView()
        self.view.endEditing(true)
        colorPickerView.isHidden = true
        canvasImageView.isUserInteractionEnabled = true
        hideToolbar(hide: false)
        isDrawing = false
        NotificationCenter.default.post(name: .navButtonHideShow, object: nil)
        NotificationCenter.default.post(name: .galleryNavButtonHideShow, object: nil)
    }
    
    @objc func doneButtonAction()
    {
        removeStickersView()
        self.view.endEditing(true)
        colorPickerView.isHidden = true
        canvasImageView.isUserInteractionEnabled = true
        hideToolbar(hide: false)
        isDrawing = false
        btnDone.isHidden = true
        btnClose.isHidden = true
        self.btnDone.isHidden = true
        self.btnClose.isHidden = true
        NotificationCenter.default.post(name: .galleryNavButtonHideShow, object: nil)
    }
    
    @objc func navButtonHideShow()
    {
        btnDone.isHidden = true
        btnClose.isHidden = true
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        colorsCollectionView.collectionViewLayout = layout
        colorsCollectionViewDelegate = ColorsCollectionViewDelegate()
        colorsCollectionViewDelegate.colorDelegate = self
        if !colors.isEmpty {
            colorsCollectionViewDelegate.colors = colors
        }
        colorsCollectionView.delegate = colorsCollectionViewDelegate
        colorsCollectionView.dataSource = colorsCollectionViewDelegate
        
        colorsCollectionView.register(
            UINib(nibName: "ColorCollectionViewCell", bundle: Bundle(for: ColorCollectionViewCell.self)),
            forCellWithReuseIdentifier: "ColorCollectionViewCell")
    }
    
    func setImageView(image: UIImage) {
        imageView.image = image
    }
    
    func hideToolbar(hide: Bool)
    {
        if hide
        {
            NotificationCenter.default.post(name: .hideGradiantButton, object: nil)
        }
        else
        {
            NotificationCenter.default.post(name: .showGradiantButton, object: nil)
        }
        
        topGradient.isHidden = hide
        bottomToolbar.isHidden = hide
        bottomGradient.isHidden = hide
    }
}

extension PhotoEditorViewController: ColorDelegate {
   public func didSelectColor(color: UIColor) {
        if isDrawing {
            self.drawColor = color
        } else if activeTextView != nil {
            activeTextView?.textColor = color
            textColor = color
        }
    }
}





