//
//  GalleryVC.swift
//  dynamicGellary
//
//  Created by Netra Technosys on 05/06/19.
//  Copyright © 2019 Netra Technosys. All rights reserved.
//

import UIKit
import PinterestLayout
import Photos
import ColorSlider
import TLPhotoPicker

class GalleryVC: UIViewController,PinterestLayoutDelegate,UIScrollViewDelegate,PhotoEditorDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TLPhotosPickerViewControllerDelegate
{
    //@IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var viewCamera: UIView!
    @IBOutlet var viewText: UIView!
    @IBOutlet var viewGallery: UIView!
    @IBOutlet var viewMainText: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet var galleryView: UIView!

    @IBOutlet var imgCamera: UIImageView!
    @IBOutlet var imgText: UIImageView!
    @IBOutlet var imgGallery: UIImageView!
    
    @IBOutlet var slide: UISlider!
    
    @IBOutlet var btnText11: UIButton!
    @IBOutlet var btnChangeImage: UIButton!
    
    @IBOutlet var scrolText: UIScrollView!
    
    var arryImg = NSMutableArray()
    var images = [PHAsset]()
    var timerForCheckPermission = Timer()
    var IsAuthorized : Bool = false
    
    var btnTitle = UIButton()
    let btnClose = UIButton()
    let btnDone = UIButton()
    
    var arrImageeesssss : [UIImage] = []
    var isFirst : Bool = true
    
    let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
    
    var arrImageGradient : [UIImage] = []
    var imgGradientCount : Int = 0
    
    let colorSlider = ColorSlider(orientation: .vertical, previewView: nil)
    
    var arr_img = NSMutableArray()
    
    let galleryViewController = TLPhotosPickerViewController()
    
    override func viewDidLoad()
    {
        isFirst = true
        arrImageGradient = [UIImage(named: "gradiant1.png"),UIImage(named: "gradiant2.png"),UIImage(named: "gradiant3.png"),UIImage(named: "gradiant4.png"),UIImage(named: "gradiant5.png"),UIImage(named: "gradiant6.png"),UIImage(named: "gradiant7.png")] as! [UIImage]
        
        btnChangeImage.frame.size.height = btnChangeImage.frame.size.width
        btnChangeImage.layer.cornerRadius = btnChangeImage.frame.size.height / 2.0
        btnChangeImage.layer.masksToBounds = true
        btnChangeImage.layer.borderColor = UIColor.white.cgColor
        btnChangeImage.layer.borderWidth = 2.0
        
        slide.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        slide.minimumValue = 10.0
        slide.maximumValue = 75.0
        slide.value = 37.0
        
        viewCamera.frame.size.height = viewCamera.frame.width
        viewCamera.layer.cornerRadius = viewCamera.frame.height / 2.0
        
        viewGallery.frame.size.height = viewGallery.frame.width
        viewGallery.layer.cornerRadius = viewGallery.frame.height / 2.0
        
        viewCamera = ShadowOfView(view: viewCamera)
        viewGallery = ShadowOfView(view: viewGallery)
        viewText = ShadowOfView(view: viewText)
        
        setupLayout()
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            let xposition = self.view.frame.width - 75
            let yposition = self.view.frame.height - ((self.tabBarController?.tabBar.frame.height)!) - 80
            
            viewText.frame = CGRect(x: xposition, y: yposition, width: 60, height: 60)
            
            btnChangeImage.frame = CGRect(x: 80, y: 15, width: 50, height: 50)
            btnChangeImage.layer.cornerRadius = btnChangeImage.frame.height / 2
        }
        else
        {
            let xposition = self.view.frame.width - 65
            let yposition = self.view.frame.height - ((self.tabBarController?.tabBar.frame.height)!) - 78
            
            viewText.frame = CGRect(x: xposition, y: yposition, width: 50, height: 50)
        }
        
        imgText.tintColor = UIColor.white
        viewText.frame.size.height = viewText.frame.width
        viewText.layer.cornerRadius = viewText.frame.height / 2.0
        viewText = ShadowOfView(view: viewText)
        
        if self.view.frame.height >= 812.0
        {
            
        }
        else
        {
            self.btnChangeImage.frame.origin.y = self.btnChangeImage.frame.origin.y + 4
        }
        
        self.addStickersToController()
        self.setNavigationButton()
        scrolText.isHidden = true
        slide.isHidden = true
        colorSlider.isHidden = true
    }
    
    func addStickersToController()
    {
        self.photoEditor.stickers.append(UIImage(named: "Love.png")!)
        self.photoEditor.stickers.append(UIImage(named: "Laugh.png")!)
        self.photoEditor.stickers.append(UIImage(named: "Happy.png")!)
    }
    
    func setupGalleryView()
    {
        galleryViewController.delegate = self
        var configure = TLPhotosPickerConfigure()
        configure.allowedVideo = false
        configure.singleSelectedMode = true
        configure.cancelTitle = ""
        configure.doneTitle = ""
        configure.selectedColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        
        galleryViewController.configure = configure
        
        addChild(galleryViewController)
        self.galleryView.addSubview(galleryViewController.view)
        galleryViewController.view.frame = self.galleryView.bounds
        galleryViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        galleryViewController.didMove(toParent: self)
    }
    
    func removeGallery()
    {
        galleryViewController.willMove(toParent: nil)
        galleryViewController.view.removeFromSuperview()
        galleryViewController.removeFromParent()
    }
    
    func hideButton()
    {
        self.viewText.isHidden = false
        self.viewCamera.isHidden = true
        self.viewGallery.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .stikernotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.stickernotirecived(_:)), name: .stickerRemove, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideGradiantButton(_:)) , name: .hideGradiantButton , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showGradiantButton(_:)), name: .showGradiantButton , object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDonebutton(_:)), name: .showNavDoneButton , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideEditorWhenItClose(_:)), name: .hideEditorWhenItClose , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeSliderLayoutWhenKeyboardOpen(_:)), name: .changeSliderLayoutWhenKeyboardOpen , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(galleryNavButtonHideShow(_:)), name: .galleryNavButtonHideShow , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(manageEditorControllerTool(_:)), name: .manageEditorControllerTool , object: nil)
        
        self.tabBarController?.tabBar.isHidden = false
        
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
            scrolText.contentSize.width = btnText11.frame.origin.x + btnText11.frame.size.width + 950
        }
        else
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 24.0)
            scrolText.contentSize.width = btnText11.frame.origin.x + btnText11.frame.size.width + 525
        }
        
        btnTitle.contentHorizontalAlignment = .center
        btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 250)/2), y:10, width:250, height:20)
        
        navigationController?.navigationBar .addSubview(btnTitle)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        if UserDefaults.standard.value(forKey: "DarkMode") as? String == "TouchIdoff"
        {
            nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        }
        else
        {
            nav?.barTintColor = UIColor.black
        }
        
        timerForCheckPermission = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.checkPhotoLibraryPermission), userInfo: nil, repeats: true)
        
        self.setupGalleryView()
        
        self.hideButton()
        btnClose.isHidden = true
        btnDone.isHidden = true
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.hideAndShowGallaryEditior()
    }
    
    //For manage gallary and Editor
    func hideAndShowGallaryEditior()
    {
        self.viewMainText.isHidden = true
        self.galleryView.isHidden = false
        self.viewText.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.view.backgroundColor = UIColor.clear
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    //For get Keyvoard Height
    @objc func keyboardWillShow(_ notification: Notification)
    {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            btnDone.isHidden = false
            btnClose.isHidden = false
        }
    }
    
    @objc func hideEditorWhenItClose(_ notification : Notification)
    {
        self.viewMainText.isHidden = true
        self.galleryView.isHidden = false
        self.viewText.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func showDonebutton(_ notification : Notification)
    {
        self.btnDone.isHidden = false
    }
    
    @objc func notificationReceived(_ notification: Notification)
    {
        viewText.isHidden = true
        viewGallery.isHidden = true
        viewCamera.isHidden = true
        scrolText.isHidden = true
    }
    
    @objc func stickernotirecived(_ notification: Notification)
    {

    }
    
    @objc func hideGradiantButton(_ notification :Notification)
    {
        self.btnChangeImage.isHidden = true
    }
    
    @objc func showGradiantButton(_ notification :Notification)
    {
        self.btnChangeImage.isHidden = false
    }
    
    @IBAction func SliderValueChanged(_sender : UISlider)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView.font = UIFont(name:photoEditor.activeTextView!.font!.fontName , size: CGFloat(slide!.value))!
            photoEditor.lastTextViewFont = UIFont(name: photoEditor.activeTextView!.font!.fontName, size: CGFloat(slide!.value))!
            photoEditor.activeTextView.frame = CGRect(x: 25.0, y: photoEditor.activeTextView.frame.origin.y, width: self.view.frame.width - 60, height: CGFloat(slide.value * 3.0))
        }
    }
    
    @IBAction func btnText1Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "lato-black", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText2Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "Flavors-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText3Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "AguafinaScript-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText4Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "Bonbon-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText5Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "FrederickatheGreat-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText6Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "Helvetica", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText7Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "LondrinaShadow-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText8Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "MissFajardose-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText9Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "MysteryQuest", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText10Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "Poppins-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    @IBAction func btnText11Pressed(_sender : UIButton)
    {
        if ((photoEditor.activeTextView) != nil)
        {
            photoEditor.activeTextView!.font = UIFont(name: "SnowburstOne-Regular", size: photoEditor.activeTextView!.font!.pointSize)!
        }
    }
    
    func ShadowOfView(view: UIView) -> UIView
    {
        let shadowLayer = CALayer()
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 4 , height: 4)
        view.layer.isOpaque = true
        shadowLayer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 5.0).cgPath
        return view
    }
    
    func getImages()
    {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
            self.images.append(object)
        })
    }
    
    @objc func checkPhotoLibraryPermission()
    {
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized)
        {
            timerForCheckPermission.invalidate()
            self.getAllImageorVideofromGallery()
            IsAuthorized = true
        }
        else if (status == PHAuthorizationStatus.denied)
        {
            IsAuthorized = false
        }
        else if (status == PHAuthorizationStatus.notDetermined)
        {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized)
                {
                    print("newStatusnewStatusnewStatusnewStatusnewStatus")
                }
            })
        }
        else if (status == PHAuthorizationStatus.restricted)
        {
            // Restricted access - normally won't happen.
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.removeGallery()
        self.timerForCheckPermission.invalidate()
        self.navigationController?.navigationBar.isHidden = false
        btnTitle.removeFromSuperview()
        navigationController?.navigationBar.isTranslucent = true
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func btnChangeImagePressed(_sender : UIButton)
    {
        if imgGradientCount == 0
        {
            photoEditor.imageView.image = arrImageGradient[0]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[0], for: .normal)
        }
        else if imgGradientCount == 1
        {
            photoEditor.imageView.image = arrImageGradient[1]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[1], for: .normal)
        }
        else if imgGradientCount == 2
        {
            photoEditor.imageView.image = arrImageGradient[2]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[2], for: .normal)
        }
        else if imgGradientCount == 3
        {
            photoEditor.imageView.image = arrImageGradient[3]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[3], for: .normal)
        }
        else if imgGradientCount == 4
        {
            photoEditor.imageView.image = arrImageGradient[4]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[4], for: .normal)
        }
        else if imgGradientCount == 5
        {
            photoEditor.imageView.image = arrImageGradient[5]
            imgGradientCount = imgGradientCount + 1
            btnChangeImage.setImage(arrImageGradient[5], for: .normal)
        }
        else if imgGradientCount == 6
        {
            photoEditor.imageView.image = arrImageGradient[6]
            imgGradientCount = 0
            btnChangeImage.setImage(arrImageGradient[6], for: .normal)
        }
    }
    
    @IBAction func btnGalleryPressed(_sender : UIButton)
    {
        if (!isFirst)
        {
            self.photoEditor.willMove(toParent: nil)
            self.photoEditor.view.removeFromSuperview()
            self.photoEditor.removeFromParent()
        }
    }
    
    @IBAction func btnCameraPressed(_sender : UIButton)
    {
        if (!isFirst)
        {
            self.photoEditor.willMove(toParent: nil)
            self.photoEditor.view.removeFromSuperview()
            self.photoEditor.removeFromParent()
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnTextPressed(_sender : UIButton)
    {
        self.galleryView.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.galleryView.isHidden = true
        self.viewMainText.isHidden = false
        self.view.backgroundColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        
        photoEditor.closeEditorType = 0
        self.viewText.isHidden = true
        isFirst = false
        imgGradientCount = 0
        photoEditor.photoEditorDelegate = self
        photoEditor.image = arrImageGradient[0]
        imgGradientCount = 1
        photoEditor.hiddenControls = [.crop,.clear,.share]
        
        photoEditor.willMove(toParent: self)
        
        if UIScreen.main.bounds.height > 811.0
        {
            self.viewMainText.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 125)
            colorSlider.frame = CGRect(x: self.viewMainText.frame.size.width - 45, y: 200, width: 30, height: 300)
            slide.frame = CGRect(x: 15, y: colorSlider.frame.origin.y, width: colorSlider.frame.size.width, height: colorSlider.frame.size.height)
            self.scrolText.frame.origin.y = 650
        }
        else
        {
            colorSlider.frame = CGRect(x: self.viewMainText.frame.size.width - 45, y: 125, width: 30, height: 300)
            slide.frame = CGRect(x: 15, y: colorSlider.frame.origin.y, width: colorSlider.frame.size.width, height: colorSlider.frame.size.height)
        }
        
        photoEditor.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.viewMainText.addSubview(photoEditor.view)
        self.addChild(photoEditor)
        photoEditor.didMove(toParent: self)
        
        photoEditor.viewText.layer.cornerRadius = photoEditor.viewText.frame.height / 2.0
        
        self.viewMainText.addSubview(colorSlider)
        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
        colorSlider.gradientView.layer.borderWidth = 2.0
        colorSlider.gradientView.layer.borderColor = UIColor.white.cgColor
        colorSlider.gradientView.automaticallyAdjustsCornerRadius = false
        
        self.viewMainText.addSubview(slide)
        slide.bringSubviewToFront(self.viewMainText)
        
        self.viewMainText.addSubview(scrolText)
        scrolText.bringSubviewToFront(self.viewMainText)
        
        self.viewMainText.addSubview(btnChangeImage)
        btnChangeImage.bringSubviewToFront(self.viewMainText)
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            photoEditor.viewText.layer.cornerRadius = photoEditor.viewText.frame.height / 2.0
            scrolText.layer.cornerRadius = 50/2.0
            
        }
        else
        {
            scrolText.layer.cornerRadius = 15.0
        }
    }
    
    @objc func changedColor(_ slider: ColorSlider)
    {
        let color = slider.color
        photoEditor.activeTextView?.textColor = color
    }
    
    @IBAction func btnBackAction (_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func changeSliderLayoutWhenKeyboardOpen(_ notification: Notification)
    {
        colorSlider.frame = CGRect(x: self.viewMainText.frame.size.width - 45, y: 170, width: 30, height: 300)
        slide.frame = CGRect(x: 15, y: colorSlider.frame.origin.y, width: colorSlider.frame.size.width, height: colorSlider.frame.size.height)
    }
    
    @objc func galleryNavButtonHideShow(_ notification: Notification)
    {
        self.btnClose.isHidden = true
        self.btnDone.isHidden = true
    }
    
    @objc func manageEditorControllerTool(_ notification: Notification)
    {
        let activeTool = UserDefaults.standard.value(forKey: "ActiveTool") as! String
        
        if activeTool == "text"
        {
            self.slide.isHidden = false
            self.colorSlider.isHidden = false
            self.scrolText.isHidden = false
        }
        else if activeTool == "sticker"
        {
            self.slide.isHidden = true
            self.colorSlider.isHidden = true
            self.scrolText.isHidden = true
        }
        else
        {
            self.slide.isHidden = true
            self.colorSlider.isHidden = true
            self.scrolText.isHidden = true
        }
    }
    
    func setupLayout()
    {
        let layout: PinterestLayout = {
            if let layout = UICollectionViewLayout.self as? PinterestLayout
            {
                return layout
            }
            
            let layout = PinterestLayout()
            //collectionView?.collectionViewLayout = layout
            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        photoEditor.photoEditorDelegate = self
        
        let asset = arr_img[indexPath.row] as! PHAsset
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width:asset.pixelWidth, height:asset.pixelHeight), contentMode: PHImageContentMode.aspectFill, options: nil)
        { (image, userInfo) -> Void in
            self.photoEditor.image = self.getAssetThumbnail(asset: self.arr_img.object(at: indexPath.row) as! PHAsset, size: 150.0)
        }
        self.photoEditor.hiddenControls = [.crop,.clear,.share]
        self.present(self.photoEditor, animated: true, completion: nil)
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.photoEditor.doneButton.frame = CGRect(x: self.view.frame.width - 50, y: 44, width: self.photoEditor.doneButton.frame.width, height: self.photoEditor.doneButton.frame.height)
            
        }
    }
    
    
    func collectionView(collectionView: UICollectionView,heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    {
        let assetssss = self.arr_img.object(at: indexPath.row) as! PHAsset
        
        return 150
    }
    
    func collectionView(collectionView: UICollectionView,heightForAnnotationAtIndexPath indexPath: IndexPath,withWidth: CGFloat) -> CGFloat
    {
        return 0
    }
    
    func getAllImageorVideofromGallery()
    {
        self.arr_img = NSMutableArray()
        self.arrImageeesssss = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        let imagesAndVideos = PHAsset.fetchAssets(with: fetchOptions)
        imagesAndVideos.enumerateObjects({ (asset, idx, stop) in
            self.arr_img.add(asset)
        })
    }
    
    func getAssetThumbnail(asset: PHAsset, size: CGFloat) -> UIImage
    {
        let retinaScale = UIScreen.main.scale
        let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)//CGSizeMake(size * retinaScale, size * retinaScale)
        let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
        let square = CGRect(x: 0, y: 0, width: cropSizeLength, height: cropSizeLength)//CGRectMake(0, 0, CGFloat(cropSizeLength), CGFloat(cropSizeLength))
        let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.normalizedCropRect = cropRect
        
        manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    func getUIImage(asset: PHAsset) -> UIImage?
    {
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options)
        { data, _, _, _ in
            if let data = data
            {
                img = UIImage(data: data)
            }
        }
        return img
    }
    
    func doneEditing(image: UIImage)
    {
        let img : UIImage = image
        print("DONE")
    }
    
    func canceledEditing()
    {
        self.tabBarController?.tabBar.isHidden = false
        self.viewText.isHidden = false
        self.photoEditor.willMove(toParent: nil)
        self.photoEditor.view.removeFromSuperview()
        self.photoEditor.removeFromParent()
        print("CANCEL")
    }
    
    func openTempEditor()
    {
        isFirst = false
        imgGradientCount = 0
        photoEditor.photoEditorDelegate = self
        photoEditor.image = arrImageGradient[0]
        imgGradientCount = 1
        photoEditor.hiddenControls = [.crop,.clear,.share]
        self.viewMainText.addSubview(photoEditor.view)
        self.addChild(photoEditor)
        photoEditor.didMove(toParent: self)
        
        self.viewMainText.addSubview(colorSlider)
        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
        colorSlider.gradientView.layer.borderWidth = 2.0
        colorSlider.gradientView.layer.borderColor = UIColor.white.cgColor
        colorSlider.gradientView.automaticallyAdjustsCornerRadius = false
        
        self.viewMainText.addSubview(slide)
        slide.bringSubviewToFront(self.viewMainText)
        
        self.viewMainText.addSubview(scrolText)
        scrolText.bringSubviewToFront(self.viewMainText)
        
        self.viewMainText.addSubview(btnChangeImage)
        btnChangeImage.bringSubviewToFront(self.viewMainText)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if (info[.originalImage] as? UIImage) != nil
        {
            
            picker.dismiss(animated: true, completion: nil)
            let imgtemp : UIImage = (info[.originalImage] as! UIImage)
            
            photoEditor.hiddenControls = [.crop,.clear,.share]
            
            photoEditor.image = imgtemp
            present(photoEditor, animated: true, completion: nil)
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
    
    @objc func btnClosePressed()
    {
        btnDone.isHidden = true
        btnClose.isHidden = true
        self.btnDone.isHidden = true
        self.btnClose.isHidden =  true
        self.view.endEditing(true)
        NotificationCenter.default.post(name: .navButtonHideShow, object: nil)
        NotificationCenter.default.post(name: .galleryNavButtonHideShow, object: nil)
    }
    
    @objc func btnDonePressed()
    {
        btnClose.isHidden = true
        btnDone.isHidden = true
        self.btnDone.isHidden = true
        self.btnClose.isHidden =  true
        NotificationCenter.default.post(name: .doneButtonAction, object: nil)
        self.view.endEditing(true)
        NotificationCenter.default.post(name: .navButtonHideShow, object: nil)
        NotificationCenter.default.post(name: .galleryNavButtonHideShow, object: nil)
    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset])
    {
        photoEditor.photoEditorDelegate = self
        if let seletedData = withTLPHAssets.first
        {
            if let assets = seletedData.fullResolutionImage
            {
                
                self.photoEditor.image = assets
                self.photoEditor.hiddenControls = [.crop,.clear,.share]
                
                photoEditor.closeEditorType = 1
                self.tabBarController?.tabBar.isHidden = true
                self.navigationController?.pushViewController(photoEditor, animated: true)
            }
        }
    }
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController)
    {
        // exceed max selection
    }
}

class cellCollectionImages : UICollectionViewCell
{
    @IBOutlet var imgGallery: UIImageView!
}

extension UIViewController
{
    static func loadFromNib() -> Self
    {
        func instantiateFromNib<T: UIViewController>() -> T
        {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}

extension UIView
{
    class func fromNib<T: UIView>() -> T
    {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

