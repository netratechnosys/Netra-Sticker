//
//  PhotoEditor+Controls.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

// MARK: - Control
public enum control {
    case crop
    case sticker
    case draw
    case text
    case save
    case share
    case clear
}

extension PhotoEditorViewController {

     //MARK: Top Toolbar
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        btnClose.isHidden = true
        btnDone.isHidden = true
        if self.closeEditorType == 1
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            photoEditorDelegate?.canceledEditing()
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: .hideEditorWhenItClose, object: nil)
        }
    }

    @IBAction func cropButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .showNavDoneButton, object: nil)
        let controller = CropViewController()
        controller.delegate = self
        controller.image = image
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }

    @IBAction func stickersButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .showNavDoneButton, object: nil)
        btnDone.isHidden = false
        addStickersViewController()
         NotificationCenter.default.post(name: .stikernotification, object: nil)
        UserDefaults.standard.set("sticker", forKey: "ActiveTool")
        NotificationCenter.default.post(name: .manageEditorControllerTool, object: nil)
    }

    @IBAction func drawButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .showNavDoneButton, object: nil)
        isDrawing = true
        canvasImageView.isUserInteractionEnabled = false
        colorPickerView.isHidden = false
        hideToolbar(hide: true)
        btnDone.isHidden = false
        self.btnDone.isHidden = false
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            colorPickerView.frame.origin.y = UIScreen.main.bounds.height - 200
        }
        else
        {
            colorPickerView.frame.origin.y = UIScreen.main.bounds.height - 200
        }
        UserDefaults.standard.set("draw", forKey: "ActiveTool")
        NotificationCenter.default.post(name: .manageEditorControllerTool, object: nil)
    }

    @IBAction func textButtonTapped(_ sender: Any) {
        isTyping = true
        let textView = UITextView(frame: CGRect(x: 0, y: canvasImageView.center.y,
                                                width: UIScreen.main.bounds.width, height: 30))
        btnDone.isHidden = false
        btnClose.isHidden = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "Lato-Bold", size: 30)
        textView.textColor = textColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowRadius = 1.0
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.autocorrectionType = .no
        textView.isScrollEnabled = false
        textView.delegate = self
        self.canvasImageView.addSubview(textView)
        addGestures(view: textView)
        textView.becomeFirstResponder()
        //viewText.isHidden = true
        NotificationCenter.default.post(name: .changeSliderLayoutWhenKeyboardOpen, object: nil)
        UserDefaults.standard.set("text", forKey: "ActiveTool")
        NotificationCenter.default.post(name: .manageEditorControllerTool, object: nil)
    }    
    
    @IBAction func doneButtonTapped(_ sender: Any)
    {
        removeStickersView()
        view.endEditing(true)
        btnDone.isHidden = true
        colorPickerView.isHidden = true
        canvasImageView.isUserInteractionEnabled = true
        hideToolbar(hide: false)
        isDrawing = false
    }
    
    //MARK: Bottom Toolbar
    
    @IBAction func saveButtonTapped(_ sender: AnyObject)
    {
        removeStickersView()
        btnDone.isHidden = true
        UIImageWriteToSavedPhotosAlbum(canvasView.toImage(),self, #selector(PhotoEditorViewController.image(_:withPotentialError:contextInfo:)), nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let activity = UIActivityViewController(activityItems: [canvasView.toImage()], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
    }
    
    @IBAction func clearButtonTapped(_ sender: AnyObject) {
        //clear drawing
        canvasImageView.image = nil
        //clear stickers and textviews
        for subview in canvasImageView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let img = self.canvasView.toImage()
        photoEditorDelegate?.doneEditing(image: img)
        self.dismiss(animated: true, completion: nil)
    }

    //MAKR: helper methods
    
    @objc func image(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        
//        canvasImageView.
//        for subview in canvasImageView.subviews {
//            subview.removeFromSuperview()
//        }
        
        let alert = UIAlertController(title: "Image Saved", message: "Image successfully saved to Photos library", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideControls() {
        for control in hiddenControls {
            switch control {
            case .clear:
                clearButton.isHidden = true
            case .crop:
                cropButton.isHidden = true
            case .draw:
                drawButton.isHidden = true
            case .save:
                saveButton.isHidden = true
            case .share:
                shareButton.isHidden = true
            case .sticker:
                stickerButton.isHidden = true
            case .text:
                stickerButton.isHidden = true
            }
        }
    }
    
}
