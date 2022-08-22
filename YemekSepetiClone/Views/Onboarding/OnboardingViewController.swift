//
//  OnboardingViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 19.08.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButtonClicked: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [onboardingSlide] = []
    
    var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
                if currentPage == slides.count - 1 {
                    
                    let button = UIButton(frame: CGRect(x: 132, y: 650, width: 125, height: 50))
                    button.setTitle("Sign Up", for: .normal)
                    button.backgroundColor = .systemGreen
                    view.addSubview(button)
                    button.layer.cornerRadius = 10
                    nextButtonClicked.backgroundColor = .systemGreen
                    nextButtonClicked.setTitle("Sign In", for: .normal)
                } else {
                    nextButtonClicked.setTitle("Next", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
        slides = [
            onboardingSlide(title: "All kinds of food", description: "Selected dishes from world cuisine", image: UIImage(named: "1")!),
            onboardingSlide(title: "Dishes you can customize", description: "You can choose what your meal includes", image: UIImage(named: "2")!),
            onboardingSlide(title: "Let's bring it to your location", description: "Your delivery is ready in minutese", image: UIImage(named: "3")!),
            onboardingSlide(title: "Let's bring it to your location", description: "Your delivery is ready in minutese", image: UIImage(named: "4")!)
        
        ]
        
        pageControl.numberOfPages = slides.count
         
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
      
    }
    

}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row ])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
}
