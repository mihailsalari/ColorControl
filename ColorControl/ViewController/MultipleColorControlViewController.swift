//
//  MultipleColorControlViewController.swift
//  ColorControl
//
//  Created by Developer on 12/1/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class MultipleColorControlViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var contrastLabel: UILabel!
    @IBOutlet weak var saturationLabel: UILabel!
    
    @IBOutlet weak var brightnessUISlider: UISlider!
    @IBOutlet weak var contrastUISlider: UISlider!
    @IBOutlet weak var saturationUISlider: UISlider!
    
    fileprivate var items = [UIImage]()
    fileprivate var colorControlsFilter : CIFilter!
    fileprivate var ciImageContext: CIContext!
    
    fileprivate var visibleCurrentCell: IndexPath? {
        for cell in self.collectionView.visibleCells {
            if let previewCell = cell as? MultipleColorCell {
                let indexPath = self.collectionView.indexPath(for: previewCell)
                
                return indexPath
            }
        }
        
        return nil
    }
    
    
    
    // MARK: - LyfeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///
        self.brightnessLabel.text = "Brightness \(brightnessUISlider.value)"
        self.contrastLabel.text = "Contrast \(contrastUISlider.value)"
        self.saturationLabel.text = "Saturation \(saturationUISlider.value)"
        
        ///
        self.fetchImages()
        
        ///
        let openGLContext = EAGLContext(api: .openGLES3)!
        ciImageContext = CIContext(eaglContext: openGLContext)
        colorControlsFilter = CIFilter(name: "CIColorControls")!
        
        self.setDefaultValueOfSliders()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func fetchImages() {
        for index in 0...7 {
            if let image = UIImage(named: "\(index)") {
                self.items.append(image)
            }
        }
    }
}



// MARK: UICollectionViewDataSource

extension MultipleColorControlViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleColorCell.reuseIdentifier, for: indexPath) as! MultipleColorCell
        
        // Configure the cell
        
        let image = items[indexPath.row]
        cell.imageView.image = image
        
        /// Default Value of filters
        if let cgimg = image.cgImage {
            let coreImage = CIImage(cgImage: cgimg)
            self.colorControlsFilter.setValue(coreImage, forKey: kCIInputImageKey)
        }
        
        self.setDefaultValueOfSliders()
        
        return cell
    }
}


// MARK: UICollectionViewDelegate

extension MultipleColorControlViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell = \(indexPath.row)")
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension MultipleColorControlViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}


// MARK: - setDefaultValueOfSliders

extension MultipleColorControlViewController {
    
    func setDefaultValueOfSliders() {
        colorControlsFilter.setDefaults()
        let brightnessValue = self.colorControlsFilter.value(forKey: kCIInputBrightnessKey) as? Float
        let contrastValue = self.colorControlsFilter.value(forKey: kCIInputContrastKey) as? Float
        let saturationValue = self.colorControlsFilter.value(forKey: kCIInputSaturationKey) as? Float
        
        print((brightnessValue, contrastValue, saturationValue));
        
        contrastUISlider.value = contrastValue ?? 1.00
        contrastUISlider.maximumValue = 4.00
        contrastUISlider.minimumValue = 0.00
        
        brightnessUISlider.value = brightnessValue ?? 0.0
        brightnessUISlider.maximumValue = 1.00
        brightnessUISlider.minimumValue = -1.00
        
        saturationUISlider.value = saturationValue ?? 1.00
        saturationUISlider.maximumValue = 2.00
        saturationUISlider.minimumValue = 0.00
    }
}


// MARK: - UISlider @IBAction

extension MultipleColorControlViewController {
    
    @IBAction func brightnessUISliderPressed(_ sender: UISlider) {
        if let indexPath = self.visibleCurrentCell {
            let cell = self.collectionView.cellForItem(at: indexPath) as! MultipleColorCell
            colorControlsFilter.setValue(sender.value, forKey: kCIInputBrightnessKey)
            self.brightnessLabel.text = "Brightness \(sender.value)"
            
            if let outputImage = self.colorControlsFilter.outputImage {
                if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
                    let newImg = UIImage(cgImage: cgImageNew)
                    cell.imageView.image = newImg
                }
            }
        }
    }
    
    @IBAction func contrastUISliderPressed(_ sender: UISlider) {
        if let indexPath = self.visibleCurrentCell {
            let cell = self.collectionView.cellForItem(at: indexPath) as! MultipleColorCell
            colorControlsFilter.setValue(sender.value, forKey: kCIInputContrastKey)
            self.contrastLabel.text = "Contrast \(sender.value)"
            
            if let outputImage = self.colorControlsFilter.outputImage {
                if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
                    let newImg = UIImage(cgImage: cgImageNew)
                    cell.imageView.image = newImg
                }
            }
        }
    }
    
    @IBAction func saturationUISliderPressed(_ sender: UISlider) {
        if let indexPath = self.visibleCurrentCell {
            let cell = self.collectionView.cellForItem(at: indexPath) as! MultipleColorCell
            colorControlsFilter.setValue(sender.value, forKey: kCIInputSaturationKey)
            self.saturationLabel.text = "Saturation \(sender.value)"
            
            if let outputImage = self.colorControlsFilter.outputImage {
                if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
                    let newImg = UIImage(cgImage: cgImageNew)
                    cell.imageView.image = newImg
                }
            }
        }
    }
}


// MARK: - UIScrollViewDelegate

extension MultipleColorControlViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setDefaultValueOfSliders()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let indexPath = self.visibleCurrentCell {
            let cell = self.collectionView.cellForItem(at: indexPath) as! MultipleColorCell
            if let image = cell.imageView.image {
                self.items.remove(at: indexPath.row)
                self.items.insert(image, at: indexPath.row)
                
                print(indexPath)
                self.collectionView.reloadData()
            }
        }
    }
}
