//
//  LGButton.swift
//  LGButtonDemo
//
//  Created by Lorenzo Greco on 28/05/2017.
//  Copyright © 2017 Lorenzo Greco. All rights reserved.
//
import UIKit
import QuartzCore


@IBDesignable
open class LGButton: UIControl {
    
    enum TouchAlphaValues : CGFloat {
        case touched = 0.7
        case untouched = 1.0
    }

    let touchDisableRadius : CGFloat = 100.0

    let availableFontIcons = ["fa", "io", "oc", "ic", "ma", "ti", "mi"]
    
    var gradient : CAGradientLayer?
    
    
    fileprivate var rootView : UIView!
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    @IBOutlet fileprivate weak var mainStackView: UIStackView!
    
    @IBOutlet fileprivate weak var bgContentView: UIView!
    @IBOutlet fileprivate weak var leftIcon: UILabel!
    @IBOutlet fileprivate weak var leftImage: UIImageView!
    @IBOutlet fileprivate weak var rightIcon: UILabel!
    @IBOutlet fileprivate weak var rightImage: UIImageView!
    
    @IBOutlet fileprivate weak var trailingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var topMainConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var leftImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leftImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var loadingStackView: UIStackView!
    @IBOutlet fileprivate weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var loadingLabel: UILabel!
    @IBOutlet fileprivate var trailingLoadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var leadingLoadingConstraint: NSLayoutConstraint!
    
    
    open var isLoading = false {
        didSet {
           showLoadingView()
        }
    }
    
    // MARK: - Inspectable properties
    // MARK:
    
    @IBInspectable open var bgColor: UIColor = UIColor.gray {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var showTouchFeedback: Bool = true
    
    @IBInspectable open var gradientStartColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var gradientEndColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var gradientHorizontal: Bool = false {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable open var gradientRotation: CGFloat = 0 {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var fullyRoundedCorners: Bool = false {
        didSet{
            setupBorderAndCorners()
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var titleColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var titleString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var titleFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var titleFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var verticalOrientation: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable open var leftIconString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftIconFontName: String = " " {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftIconFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftIconColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var leftImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightIconString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightIconFontName: String = " " {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightIconFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightIconColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var rightImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var spacingTitleIcon: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var spacingTop: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var spacingBottom: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var spacingLeading: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var spacingTrailing: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var shadowOffset: CGSize = CGSize.init(width:0, height:0) {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat = 0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var shadowOpacity: CGFloat = 1 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var shadowColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var loadingSpinnerColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var loadingColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var loadingString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var loadingFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var loadingFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    // MARK: - Overrides
    // MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        setupView()
    }
    
    override open func layoutSubviews() {
        if gradient != nil {
            gradient?.removeFromSuperlayer()
            gradient = nil
            setupGradientBackground()
        }
        setupBorderAndCorners()
    }
    
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    // MARK: - Internal functions
    // MARK:
    
    // Setup the view appearance
    fileprivate func setupView(){
        bgContentView.clipsToBounds = true
        layer.masksToBounds = false
        setIconOrientation()
        setupBackgroundColor()
        setupGradientBackground()
        setupBorderAndCorners()
        setupTitle()
        setupLeftIcon()
        setupRightIcon()
        setupLeftImage()
        setupRightImage()
        setupSpacings()
        setupShadow()
        setupLoadingView()
    }
    
    fileprivate func setIconOrientation() {
        if verticalOrientation {
            mainStackView.axis = .vertical
        }else{
            mainStackView.axis = .horizontal
        }
    }
    
    fileprivate func setupBackgroundColor() {
        bgContentView.backgroundColor = bgColor
    }
    
    fileprivate func setupGradientBackground() {
        if gradientStartColor != nil && gradientEndColor != nil && gradient == nil{
            gradient = CAGradientLayer()
            gradient!.frame.size = frame.size
            gradient!.colors = [gradientStartColor!.cgColor, gradientEndColor!.cgColor]
            
            var rotation:CGFloat!
            if gradientRotation >= 0 {
                rotation = min(gradientRotation, CGFloat(360.0))
            } else {
                rotation = max(gradientRotation, CGFloat(-360.0))
            }
            var xAngle:Float = Float(rotation/360)
            if (gradientHorizontal) {
                xAngle = 0.25
            }
            let a = pow(sinf((2*Float(Double.pi)*((xAngle+0.75)/2))),2)
            let b = pow(sinf((2*Float(Double.pi)*((xAngle+0.0)/2))),2)
            let c = pow(sinf((2*Float(Double.pi)*((xAngle+0.25)/2))),2)
            let d = pow(sinf((2*Float(Double.pi)*((xAngle+0.5)/2))),2)
            gradient!.startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
            gradient!.endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
        
            bgContentView.layer.addSublayer(gradient!)
        }
    }
    
    fileprivate func setupBorderAndCorners() {
        if fullyRoundedCorners {
            bgContentView.layer.cornerRadius = frame.size.height/2
            layer.cornerRadius = frame.size.height/2
        }else{
            bgContentView.layer.cornerRadius = cornerRadius
            layer.cornerRadius = cornerRadius
        }
        bgContentView.layer.borderColor = borderColor.cgColor
        bgContentView.layer.borderWidth = borderWidth
    }
    
    fileprivate func setupTitle() {
        titleLbl.isHidden = titleString.isEmpty
        titleLbl.text = titleString
        titleLbl.textColor = titleColor
        if titleFontName != nil {
            titleLbl.font = UIFont.init(name:titleFontName! , size:titleFontSize)
        }else{
            titleLbl.font = UIFont.systemFont(ofSize: titleFontSize)
        }
    }
    
    fileprivate func setupLeftIcon(){
        setupIcon(icon: leftIcon,
                  fontName: leftIconFontName,
                  iconName: leftIconString,
                  fontSize: leftIconFontSize,
                  color: leftIconColor)
    }
    
    fileprivate func setupRightIcon(){
        setupIcon(icon: rightIcon,
                  fontName: rightIconFontName,
                  iconName: rightIconString,
                  fontSize: rightIconFontSize,
                  color: rightIconColor)
    }
    
    fileprivate func setupLeftImage(){
        setupImage(imageView: leftImage,
                   image: leftImageSrc,
                   color: leftImageColor,
                   widthConstraint: leftImageWidthConstraint,
                   heightConstraint: leftImageHeightConstraint,
                   widthValue: leftImageWidth,
                   heightValue: leftImageHeight)
        leftIcon.isHidden =  (leftImageSrc != nil || !availableFontIcons.contains(leftIconFontName))
    }
    
    fileprivate func setupRightImage(){
        rightIcon.isHidden =  rightImageSrc != nil
        setupImage(imageView: rightImage,
                   image: rightImageSrc,
                   color: rightImageColor,
                   widthConstraint: rightImageWidthConstraint,
                   heightConstraint: rightImageHeightConstraint,
                   widthValue: rightImageWidth,
                   heightValue: rightImageHeight)
        rightIcon.isHidden =  (rightImageSrc != nil || !availableFontIcons.contains(rightIconFontName))
    }
    
    fileprivate func setupSpacings(){
        mainStackView.spacing = spacingTitleIcon
        topMainConstraint.constant = spacingTop
        bottomMainConstraint.constant = spacingBottom
        leadingMainConstraint.constant = spacingLeading
        trailingMainConstraint.constant = spacingTrailing
        setupBorderAndCorners()
    }
    
    fileprivate func setupShadow(){
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowColor = shadowColor.cgColor
    }
    
    fileprivate func setupLoadingView(){
        loadingLabel.isHidden = loadingString.isEmpty
        loadingLabel.text = loadingString
        loadingLabel.textColor = loadingColor
        if loadingFontName != nil {
            loadingLabel.font = UIFont.init(name:loadingFontName! , size:titleFontSize)
        }else{
            loadingLabel.font = UIFont.systemFont(ofSize: loadingFontSize)
        }
        loadingSpinner.color = loadingSpinnerColor
        setupBorderAndCorners()
    }
    
    fileprivate func setupIcon(icon:UILabel, fontName:String, iconName:String, fontSize:CGFloat, color:UIColor){
        icon.isHidden = !availableFontIcons.contains(fontName)
        if  !icon.isHidden {
            icon.textColor = color
            switch fontName {
            case "fa":
                icon.font = UIFont.icon(from: .FontAwesome, ofSize: fontSize)
                icon.text = String.fontAwesomeIcon(iconName)
                break;
            case "io":
                icon.font = UIFont.icon(from: .Ionicon, ofSize: fontSize)
                icon.text = String.fontIonIcon(iconName)
                break;
            case "oc":
                icon.font = UIFont.icon(from: .Octicon, ofSize: fontSize)
                icon.text = String.fontOcticon(iconName)
                break;
            case "ic":
                icon.font = UIFont.icon(from: .Iconic, ofSize: fontSize)
                icon.text = String.fontIconicIcon(iconName)
                break;
            case "ma":
                icon.font = UIFont.icon(from: .MaterialIcon, ofSize: fontSize)
                icon.text = String.fontMaterialIcon(iconName.replacingOccurrences(of: "-", with: "."))
                break;
            case "ti":
                icon.font = UIFont.icon(from: .Themify, ofSize: fontSize)
                icon.text = String.fontThemifyIcon(iconName.replacingOccurrences(of: "-", with: "."))
                break;
            case "mi":
                icon.font = UIFont.icon(from: .MapIcon, ofSize: fontSize)
                icon.text = String.fontMapIcon(iconName.replacingOccurrences(of: "-", with: "."))
                break;
            default:
                break;
            }
        }
        setupBorderAndCorners()
    }
    
    fileprivate func setupImage(imageView:UIImageView, image:UIImage?, color:UIColor?, widthConstraint:NSLayoutConstraint, heightConstraint:NSLayoutConstraint, widthValue:CGFloat, heightValue:CGFloat){
        imageView.isHidden = image == nil
        if image != nil {
            if color != nil {
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = color
            }else{
                image?.withRenderingMode(.alwaysOriginal)
                imageView.image = image
            }
            widthConstraint.constant = widthValue
            heightConstraint.constant = heightValue
        }
        setupBorderAndCorners()
    }
    
    fileprivate func showLoadingView() {
        leadingLoadingConstraint.isActive = isLoading
        trailingLoadingConstraint.isActive = isLoading
        mainStackView.isHidden = isLoading
        loadingStackView.isHidden = !isLoading
        isUserInteractionEnabled = !isLoading
    }
    
    // MARK: - Xib file
    // MARK:
    fileprivate func xibSetup() {
        rootView = loadViewFromNib()
        rootView.frame = bounds
        rootView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(rootView)
        leadingLoadingConstraint.isActive = false
        trailingLoadingConstraint.isActive = false
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LGButton", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    // MARK: - Touches
    // MARK:
    var touchAlpha : TouchAlphaValues = .untouched {
        didSet {
            updateTouchAlpha()
        }
    }
    
    var pressed : Bool = false {
        didSet {
            if !showTouchFeedback {
                return
            }
            
            touchAlpha = (pressed) ? .touched : .untouched
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        pressed = true
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        let shouldSendActions = pressed
        pressed = false
        if shouldSendActions{
            sendActions(for: .touchUpInside)
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touchLoc = touches.first?.location(in: self){
            if (touchLoc.x < -touchDisableRadius ||
                touchLoc.y < -touchDisableRadius ||
                touchLoc.x > self.bounds.size.width + touchDisableRadius ||
                touchLoc.y > self.bounds.size.height + touchDisableRadius){
                pressed = false
            }
            else if self.touchAlpha == .untouched {
                pressed = true
            }
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = false
    }
    
    func updateTouchAlpha() {
        if self.alpha != self.touchAlpha.rawValue {
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.touchAlpha.rawValue
            }
        }
    }
}
