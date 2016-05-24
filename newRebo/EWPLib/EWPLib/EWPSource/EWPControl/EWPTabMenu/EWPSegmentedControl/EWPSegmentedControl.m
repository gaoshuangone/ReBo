//
//  EWPSegmentedControl.m
//  EWPSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "EWPSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import "CustomBadge.h"
#import "CommonFuction.h"

#define segmentImageTextPadding 7

@interface EWPScrollView : UIScrollView
@end

@interface EWPSegmentedControl ()

@property (nonatomic, strong) CALayer *selectionIndicatorStripLayer;
@property (nonatomic, strong) CALayer *selectionIndicatorBoxLayer;
@property (nonatomic, strong) CALayer *selectionIndicatorArrowLayer;
@property (nonatomic, readwrite) CGFloat segmentWidth;
@property (nonatomic, readwrite) NSArray *segmentWidthsArray;
@property (nonatomic, strong) EWPScrollView *scrollView;

//added by tmy
@property (nonatomic, strong) NSMutableArray *badgeArray;
@end

@implementation EWPScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.dragging) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    } else{
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    if (!self.dragging) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

@end

@implementation EWPSegmentedControl

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
        self.sectionTitles = sectiontitles;
        self.type = EWPSegmentedControlTypeText;
        
        //added by tmy。只有文字类型的加入了badge功能
        _badgeArray = [[NSMutableArray alloc] init];
        for(int i=0;i<self.sectionTitles.count;i++)
        {
            CustomBadge* badge = [CustomBadge customBadgeWithString:@"0"
                                                    withStringColor:[UIColor whiteColor]
                                                     withInsetColor:[CommonFuction colorFromHexRGB:@"ff6666"]
                                                     withBadgeFrame:YES
                                                withBadgeFrameColor:[CommonFuction colorFromHexRGB:@"ff6666"]
                                                          withScale:0.7
                                                        withShining:NO];
            badge.hidden = YES;
            [self addSubview:badge];
            [_badgeArray addObject:badge];
        }

    }
    
    return self;
}

- (id)initWithSectionImages:(NSArray*)sectionImages sectionSelectedImages:(NSArray*)sectionSelectedImages {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
        self.type = EWPSegmentedControlTypeImages;
    }
    
    return self;
}

- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles {
	self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
		
		if (sectionImages.count != sectiontitles.count) {
			[NSException raise:NSRangeException format:@"***%s: Images bounds (%ld) Dont match Title bounds (%ld)", sel_getName(_cmd), (unsigned long)sectionImages.count, (unsigned long)sectiontitles.count];
        }
		
        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
		self.sectionTitles = sectiontitles;
        self.type = EWPSegmentedControlTypeTextImages;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.segmentWidth = 0.0f;
    [self commonInit];
}

- (void)commonInit {
    self.scrollView = [[EWPScrollView alloc] init];
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    self.indicatorBKColor = [UIColor clearColor];
    
    self.selectedSegmentIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.selectionIndicatorHeight = 5.0f;
    self.selectionStyle = EWPSegmentedControlSelectionStyleTextWidthStripe;
    self.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationUp;
    self.segmentWidthStyle = EWPSegmentedControlSegmentWidthStyleFixed;
    self.userDraggable = YES;
    self.touchEnabled = YES;
    self.type = EWPSegmentedControlTypeText;
    
    self.shouldAnimateUserSelection = YES;
    
    self.selectionIndicatorArrowLayer = [CALayer layer];
    
    self.selectionIndicatorStripLayer = [CALayer layer];
    
    self.selectionIndicatorBoxLayer = [CALayer layer];
    self.selectionIndicatorBoxLayer.opacity = 0.2;
    self.selectionIndicatorBoxLayer.borderWidth = 1.0f;
    
    self.contentMode = UIViewContentModeRedraw;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateSegmentsRects];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self updateSegmentsRects];
}

- (void)setSectionTitles:(NSArray *)sectionTitles {
    _sectionTitles = sectionTitles;
    
    [self setNeedsLayout];
}

- (void)setSectionImages:(NSArray *)sectionImages {
    _sectionImages = sectionImages;
    
    [self setNeedsLayout];
}

- (void)setSelectionIndicatorLocation:(EWPSegmentedControlSelectionIndicatorLocation)selectionIndicatorLocation {
	_selectionIndicatorLocation = selectionIndicatorLocation;
	
	if (selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationNone) {
		self.selectionIndicatorHeight = 0.0f;
	}
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);

    self.selectionIndicatorArrowLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    
    self.selectionIndicatorStripLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    
    self.selectionIndicatorBoxLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    self.selectionIndicatorBoxLayer.borderColor = self.selectionIndicatorColor.CGColor;
    
    // Remove all sublayers to avoid drawing images over existing ones
    self.scrollView.layer.sublayers = nil;
    
    if (self.type == EWPSegmentedControlTypeText) {
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringHeight = roundf([titleString sizeWithFont:self.font].height);
            CGFloat stringWidth = roundf([titleString sizeWithFont:self.font].width);
            
            // Text inside the CATextLayer will appear blurry unless the rect values are rounded
            CGFloat y = roundf(CGRectGetHeight(self.frame) - self.selectionIndicatorHeight)/2 - stringHeight/2 + ((self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationUp) ? self.selectionIndicatorHeight : 0);
            
            CGRect rect;
            if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed) {
                rect = CGRectMake((self.segmentWidth * idx) + (self.segmentWidth - stringWidth)/2, y, stringWidth, stringHeight);
            }
            else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleEqually)
            {
                rect = CGRectMake((self.segmentWidth * idx), y, self.segmentWidth, stringHeight);
            }
            else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
                // When we are drawing dynamic widths, we need to loop the widths array to calculate the xOffset
                CGFloat xOffset = 0;
                NSInteger i = 0;
                for (NSNumber *width in self.segmentWidthsArray) {
                    if (idx == i)
                        break;
                    xOffset = xOffset + [width floatValue];
                    i++;
                }
                
                rect = CGRectMake(xOffset, y, [[self.segmentWidthsArray objectAtIndex:idx] floatValue], stringHeight);
            }
            
            CATextLayer *titleLayer = [CATextLayer layer];
            titleLayer.frame = rect;
            titleLayer.font = (__bridge CFTypeRef)(self.font.fontName);
            titleLayer.fontSize = self.font.pointSize;
            titleLayer.alignmentMode = kCAAlignmentCenter;
            titleLayer.string = titleString;
            titleLayer.truncationMode = kCATruncationEnd;
            if (self.showShadow)
            {
                titleLayer.shadowColor = [UIColor blackColor].CGColor;
                titleLayer.shadowOffset = CGSizeMake(0, 0);
                titleLayer.shadowRadius = 1;
                titleLayer.shadowOpacity = 0.4;
            }
            
            
            if (self.selectedSegmentIndex == idx) {
                titleLayer.foregroundColor = self.selectedTextColor.CGColor;
            } else {
                titleLayer.foregroundColor = self.textColor.CGColor;
            }
            titleLayer.shadowColor = [UIColor blackColor].CGColor;
            titleLayer.shadowOffset = CGSizeMake(1, 1);
            
            titleLayer.contentsScale = [[UIScreen mainScreen] scale];
            [self.scrollView.layer addSublayer:titleLayer];
            
            //added by tmy
            CustomBadge* badge = [_badgeArray objectAtIndex:idx];
            [badge autoBadgeSizeWithString:badge.badgeText];
            CGSize sz = badge.frame.size;
            CGRect frame = CGRectMake(rect.origin.x+rect.size.width-sz.width+badge.offsetSize.width,
                                      MAX(rect.origin.y-badge.offsetSize.height,0), sz.width, sz.height);
            badge.frame = frame;

        }];
    } else if (self.type == EWPSegmentedControlTypeImages) {
        [self.sectionImages enumerateObjectsUsingBlock:^(id iconImage, NSUInteger idx, BOOL *stop) {
            UIImage *icon = iconImage;
            CGFloat imageWidth = icon.size.width;
            CGFloat imageHeight = icon.size.height;
            CGFloat y = roundf(CGRectGetHeight(self.frame) - self.selectionIndicatorHeight) / 2 - imageHeight / 2 + ((self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationUp) ? self.selectionIndicatorHeight : 0);
            CGFloat x = self.segmentWidth * idx + (self.segmentWidth - imageWidth)/2.0f;
            CGRect rect = CGRectMake(x, y, imageWidth, imageHeight);
            
            CALayer *imageLayer = [CALayer layer];
            imageLayer.frame = rect;
                        
            if (self.selectedSegmentIndex == idx) {
                if (self.sectionSelectedImages) {
                    UIImage *highlightIcon = [self.sectionSelectedImages objectAtIndex:idx];
                    imageLayer.contents = (id)highlightIcon.CGImage;
                } else {
                    imageLayer.contents = (id)icon.CGImage;
                }
            } else {
                imageLayer.contents = (id)icon.CGImage;
            }
            
            [self.scrollView.layer addSublayer:imageLayer];
        }];
    } else if (self.type == EWPSegmentedControlTypeTextImages){
		[self.sectionImages enumerateObjectsUsingBlock:^(id iconImage, NSUInteger idx, BOOL *stop) {
            // When we have both an image and a title, we start with the image and use segmentImageTextPadding before drawing the text.
            // So the image will be left to the text, centered in the middle
            UIImage *icon = iconImage;
            CGFloat imageWidth = icon.size.width;
            CGFloat imageHeight = icon.size.height;
			
			CGFloat stringHeight = roundf([self.sectionTitles[idx] sizeWithFont:self.font].height);
            CGFloat yOffset = roundf(CGRectGetHeight(self.frame) - self.selectionIndicatorHeight) / 2 - stringHeight / 2 + ((self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationUp) ? self.selectionIndicatorHeight : 0);
            CGFloat imageXOffset = self.segmentEdgeInset.left; // Start with edge inset
            if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed)
                imageXOffset = self.segmentWidth * idx;
            else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
                // When we are drawing dynamic widths, we need to loop the widths array to calculate the xOffset
                NSInteger i = 0;
                for (NSNumber *width in self.segmentWidthsArray) {
                    if (idx == i)
                        break;
                    imageXOffset = imageXOffset + [width floatValue];
                    i++;
                }
            }
            
            CGRect imageRect = CGRectMake(imageXOffset, yOffset, imageWidth, imageHeight);
			
            // Use the image offset and padding to calculate the text offset
            CGFloat textXOffset = imageXOffset + imageWidth + segmentImageTextPadding;
            
            // The text rect's width is the segment width without the image, image padding and insets
            CGRect textRect = CGRectMake(textXOffset, yOffset, [[self.segmentWidthsArray objectAtIndex:idx] floatValue]-imageWidth-segmentImageTextPadding-self.segmentEdgeInset.left-self.segmentEdgeInset.right, stringHeight);
            CATextLayer *titleLayer = [CATextLayer layer];
            titleLayer.frame = textRect;
            titleLayer.font = (__bridge CFTypeRef)(self.font.fontName);
            titleLayer.fontSize = self.font.pointSize;
            titleLayer.alignmentMode = kCAAlignmentCenter;
            titleLayer.string = self.sectionTitles[idx];
            titleLayer.truncationMode = kCATruncationEnd;
            if (self.showShadow)
            {
                titleLayer.shadowColor = [UIColor blackColor].CGColor;
                titleLayer.shadowOffset = CGSizeMake(0, 0);
                titleLayer.shadowRadius = 1;
                titleLayer.shadowOpacity = 0.4;
            }
			
            CALayer *imageLayer = [CALayer layer];
            imageLayer.frame = imageRect;
			
            if (self.selectedSegmentIndex == idx) {
                if (self.sectionSelectedImages) {
                    UIImage *highlightIcon = [self.sectionSelectedImages objectAtIndex:idx];
                    imageLayer.contents = (id)highlightIcon.CGImage;
                } else {
                    imageLayer.contents = (id)icon.CGImage;
                }
				titleLayer.foregroundColor = self.selectedTextColor.CGColor;
            } else {
                imageLayer.contents = (id)icon.CGImage;
				titleLayer.foregroundColor = self.textColor.CGColor;
            }
            
            [self.scrollView.layer addSublayer:imageLayer];
			titleLayer.contentsScale = [[UIScreen mainScreen] scale];
            [self.scrollView.layer addSublayer:titleLayer];
			
        }];
	}

    // Add the selection indicators
    if (self.selectedSegmentIndex != EWPSegmentedControlNoSegment) {
        if (self.selectionStyle == EWPSegmentedControlSelectionStyleArrow) {
            if (!self.selectionIndicatorArrowLayer.superlayer) {
                [self setArrowFrame];
                [self.scrollView.layer addSublayer:self.selectionIndicatorArrowLayer];
            }
        } else {
            if (!self.selectionIndicatorStripLayer.superlayer) {
                self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
                CALayer *indicatorBkLayer = [CALayer layer];
                indicatorBkLayer.backgroundColor = self.indicatorBKColor.CGColor;
                CGRect rect = [self frameForSelectionIndicator];
                rect.origin.x = 0;
                rect.size.width = self.scrollView.frame.size.width;
                indicatorBkLayer.frame = rect;;
                [self.scrollView.layer addSublayer:indicatorBkLayer];
                [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
                
                if (self.selectionStyle == EWPSegmentedControlSelectionStyleBox && !self.selectionIndicatorBoxLayer.superlayer) {
                    self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
                    [self.scrollView.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
                }
            }
        }
    }
    
    
}

- (void)setArrowFrame {
    self.selectionIndicatorArrowLayer.frame = [self frameForSelectionIndicator];
    
    self.selectionIndicatorArrowLayer.mask = nil;
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    CGPoint p3 = CGPointZero;
    
    if (self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationDown) {
        p1 = CGPointMake(self.selectionIndicatorArrowLayer.bounds.size.width / 2, 0);
        p2 = CGPointMake(0, self.selectionIndicatorArrowLayer.bounds.size.height);
        p3 = CGPointMake(self.selectionIndicatorArrowLayer.bounds.size.width, self.selectionIndicatorArrowLayer.bounds.size.height);
    }
    
    if (self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationUp) {
        p1 = CGPointMake(self.selectionIndicatorArrowLayer.bounds.size.width / 2, self.selectionIndicatorArrowLayer.bounds.size.height);
        p2 = CGPointMake(self.selectionIndicatorArrowLayer.bounds.size.width, 0);
        p3 = CGPointMake(0, 0);
    }
    
    [arrowPath moveToPoint:p1];
    [arrowPath addLineToPoint:p2];
    [arrowPath addLineToPoint:p3];
    [arrowPath closePath];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.selectionIndicatorArrowLayer.bounds;
    maskLayer.path = arrowPath.CGPath;
    self.selectionIndicatorArrowLayer.mask = maskLayer;
}

- (CGRect)frameForSelectionIndicator {
    CGFloat indicatorYOffset = 0.0f;
        
    if (self.selectionIndicatorLocation == EWPSegmentedControlSelectionIndicatorLocationDown) {
        indicatorYOffset = self.bounds.size.height - self.selectionIndicatorHeight;
    }
    
    CGFloat sectionWidth = 0.0f;

    if (self.type == EWPSegmentedControlTypeText) {
        CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithFont:self.font].width;
        sectionWidth = stringWidth;
    } else if (self.type == EWPSegmentedControlTypeImages) {
        UIImage *sectionImage = [self.sectionImages objectAtIndex:self.selectedSegmentIndex];
        CGFloat imageWidth = sectionImage.size.width;
        sectionWidth = imageWidth;
    } else if (self.type == EWPSegmentedControlTypeTextImages) {
		CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithFont:self.font].width;
		UIImage *sectionImage = [self.sectionImages objectAtIndex:self.selectedSegmentIndex];
		CGFloat imageWidth = sectionImage.size.width;
        if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed) {
            sectionWidth = MAX(stringWidth, imageWidth);
        } else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
            sectionWidth = imageWidth + segmentImageTextPadding + stringWidth;
        }
	}
    
    if (self.selectionStyle == EWPSegmentedControlSelectionStyleArrow) {
        CGFloat widthToEndOfSelectedSegment = (self.segmentWidth * self.selectedSegmentIndex) + self.segmentWidth;
        CGFloat widthToStartOfSelectedIndex = (self.segmentWidth * self.selectedSegmentIndex);
        
        CGFloat x = widthToStartOfSelectedIndex + ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) - (self.selectionIndicatorHeight/2);
        return CGRectMake(x, indicatorYOffset, self.selectionIndicatorHeight, self.selectionIndicatorHeight);
    } else {
        if (self.selectionStyle == EWPSegmentedControlSelectionStyleTextWidthStripe &&
            sectionWidth <= self.segmentWidth &&
            self.segmentWidthStyle != EWPSegmentedControlSegmentWidthStyleDynamic) {
            CGFloat widthToEndOfSelectedSegment = (self.segmentWidth * self.selectedSegmentIndex) + self.segmentWidth;
            CGFloat widthToStartOfSelectedIndex = (self.segmentWidth * self.selectedSegmentIndex);
            
            CGFloat x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2.0f) + (widthToStartOfSelectedIndex - sectionWidth / 2.0f);
            CGFloat addWidth = 10.0f;
            return CGRectMake(x - addWidth / 2.0f, indicatorYOffset, sectionWidth + addWidth + 2, self.selectionIndicatorHeight);
        } else {
            if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
                CGFloat selectedSegmentOffset = 0.0f;
                
                NSInteger i = 0;
                for (NSNumber *width in self.segmentWidthsArray) {
                    if (self.selectedSegmentIndex == i)
                        break;
                    selectedSegmentOffset = selectedSegmentOffset + [width floatValue];
                    i++;
                }
                
                return CGRectMake(selectedSegmentOffset, indicatorYOffset, [[self.segmentWidthsArray objectAtIndex:self.selectedSegmentIndex] floatValue], self.selectionIndicatorHeight);
            }
//            首页间距   self.segmentWidth
            return CGRectMake(self.segmentWidth * self.selectedSegmentIndex + 8, indicatorYOffset, self.segmentWidth -14, self.selectionIndicatorHeight);
        }
    }
}

- (CGRect)frameForFillerSelectionIndicator {
    if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
        CGFloat selectedSegmentOffset = 0.0f;
        
        NSInteger i = 0;
        for (NSNumber *width in self.segmentWidthsArray) {
            if (self.selectedSegmentIndex == i) {
                break;
            }
            selectedSegmentOffset = selectedSegmentOffset + [width floatValue];

            i++;
        }
        
        return CGRectMake(selectedSegmentOffset, 0, [[self.segmentWidthsArray objectAtIndex:self.selectedSegmentIndex] floatValue], CGRectGetHeight(self.frame));
    }
    return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, 0, self.segmentWidth, CGRectGetHeight(self.frame));
}

- (void)updateSegmentsRects {
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    // When `scrollEnabled` is set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
    // otherwise it will be equal to the width of the control's frame divided by the number of segments.
    if ([self sectionCount] > 0) {
        self.segmentWidth = self.frame.size.width / [self sectionCount];
    }
    
    if (self.type == EWPSegmentedControlTypeText && self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed) {
        for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
            CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#else
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#endif
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
    }
    else if (self.type == EWPSegmentedControlTypeText && self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleEqually)
    {
       //均分
    }
    else if (self.type == EWPSegmentedControlTypeText && self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
        NSMutableArray *mutableSegmentWidths = [NSMutableArray array];
        
        for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
            CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#else
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#endif
            [mutableSegmentWidths addObject:[NSNumber numberWithFloat:stringWidth]];
        }
        self.segmentWidthsArray = [mutableSegmentWidths copy];
    } else if (self.type == EWPSegmentedControlTypeImages) {
        for (UIImage *sectionImage in self.sectionImages) {
            CGFloat imageWidth = sectionImage.size.width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(imageWidth, self.segmentWidth);
        }
    } else if (self.type == EWPSegmentedControlTypeTextImages && EWPSegmentedControlSegmentWidthStyleFixed){
        //lets just use the title.. we will assume it is wider then images...
        for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
            CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#else
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#endif
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
    } else if (self.type == EWPSegmentedControlTypeTextImages && EWPSegmentedControlSegmentWidthStyleDynamic) {
        NSMutableArray *mutableSegmentWidths = [NSMutableArray array];
        
        int i = 0;
        for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
            CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width + self.segmentEdgeInset.right;
#else
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.right;
#endif
            UIImage *sectionImage = [self.sectionImages objectAtIndex:i];
            CGFloat imageWidth = sectionImage.size.width + self.segmentEdgeInset.left;
            
            CGFloat combinedWidth = imageWidth + segmentImageTextPadding + stringWidth;
            
            [mutableSegmentWidths addObject:[NSNumber numberWithFloat:combinedWidth]];
            
            i++;
        }
        self.segmentWidthsArray = [mutableSegmentWidths copy];
    }

    self.scrollView.scrollEnabled = self.isUserDraggable;
    self.scrollView.contentSize = CGSizeMake([self totalSegmentedControlWidth], self.frame.size.height);
}

- (NSInteger)sectionCount
{
    if (self.type == EWPSegmentedControlTypeText)
    {
        return self.sectionTitles.count;
    }
    else if (self.type == EWPSegmentedControlTypeImages
             ||self.type == EWPSegmentedControlTypeTextImages)
    {
        return self.sectionImages.count;
    }
    
    return 0;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    if (self.sectionTitles || self.sectionImages) {
        [self updateSegmentsRects];
    }
}

#pragma mark - Touch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = 0;
        if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed || self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleEqually) {
            segment = (touchLocation.x + self.scrollView.contentOffset.x) / self.segmentWidth;
        }
        else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
            // To know which segment the user touched, we need to loop over the widths and substract it from the x position.
            CGFloat widthLeft = (touchLocation.x + self.scrollView.contentOffset.x);
            for (NSNumber *width in self.segmentWidthsArray) {
                widthLeft = widthLeft - [width floatValue];
                
                // When we don't have any width left to substract, we have the segment index.
                if (widthLeft <= 0)
                    break;
                
                segment++;
            }
        }
        
        if (segment != self.selectedSegmentIndex && segment < [self.sectionTitles count]) {
            // Check if we have to do anything with the touch event
            if (self.isTouchEnabled)
                [self setSelectedSegmentIndex:segment animated:self.shouldAnimateUserSelection notify:YES];
        }
    }
}

#pragma mark - Scrolling

- (CGFloat)totalSegmentedControlWidth {
    if (self.type == EWPSegmentedControlTypeText && self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed) {
        return self.sectionTitles.count * self.segmentWidth;
    } else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
        return [[self.segmentWidthsArray valueForKeyPath:@"@sum.self"] floatValue];
    } else {
        return self.sectionImages.count * self.segmentWidth;
    }
}

- (void)scrollToSelectedSegmentIndex {
    CGRect rectForSelectedIndex;
    CGFloat selectedSegmentOffset = 0;
    if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleFixed || self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleEqually) {
        rectForSelectedIndex = CGRectMake(self.segmentWidth * self.selectedSegmentIndex,
                                                 0,
                                                 self.segmentWidth,
                                                 self.frame.size.height);
        
        selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (self.segmentWidth / 2);
    } else if (self.segmentWidthStyle == EWPSegmentedControlSegmentWidthStyleDynamic) {
        NSInteger i = 0;
        CGFloat offsetter = 0;
        for (NSNumber *width in self.segmentWidthsArray) {
            if (self.selectedSegmentIndex == i)
                break;
            offsetter = offsetter + [width floatValue];
            i++;
        }
        
        rectForSelectedIndex = CGRectMake(offsetter,
                                          0,
                                          [[self.segmentWidthsArray objectAtIndex:self.selectedSegmentIndex] floatValue],
                                          self.frame.size.height);
        
        selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - ([[self.segmentWidthsArray objectAtIndex:self.selectedSegmentIndex] floatValue] / 2);
    }
    
    
    CGRect rectToScrollTo = rectForSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset * 2;
    [self.scrollView scrollRectToVisible:rectToScrollTo animated:YES];
}

#pragma mark - Index change

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO notify:YES];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    [self setSelectedSegmentIndex:index animated:animated notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify {
    _oldSelectedSegmentIndex = _selectedSegmentIndex;
    _selectedSegmentIndex = index;
    [self setNeedsDisplay];
    
    if (index == EWPSegmentedControlNoSegment) {
        [self.selectionIndicatorArrowLayer removeFromSuperlayer];
        [self.selectionIndicatorStripLayer removeFromSuperlayer];
        [self.selectionIndicatorBoxLayer removeFromSuperlayer];
    } else {
        [self scrollToSelectedSegmentIndex];
        
        if (animated) {
            // If the selected segment layer is not added to the super layer, that means no
            // index is currently selected, so add the layer then move it to the new
            // segment index without animating.
            if(self.selectionStyle == EWPSegmentedControlSelectionStyleArrow) {
                if ([self.selectionIndicatorArrowLayer superlayer] == nil) {
                    [self.scrollView.layer addSublayer:self.selectionIndicatorArrowLayer];
                    
                    [self setSelectedSegmentIndex:index animated:NO notify:YES];
                    return;
                }
            }else {
                if ([self.selectionIndicatorStripLayer superlayer] == nil) {
                    [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
                    
                    if (self.selectionStyle == EWPSegmentedControlSelectionStyleBox && [self.selectionIndicatorBoxLayer superlayer] == nil)
                        [self.scrollView.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
                    
                    [self setSelectedSegmentIndex:index animated:NO notify:YES];
                    return;
                }
            }
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
            
            // Restore CALayer animations
            self.selectionIndicatorArrowLayer.actions = nil;
            self.selectionIndicatorStripLayer.actions = nil;
            self.selectionIndicatorBoxLayer.actions = nil;
            
            // Animate to new position
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.15f];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            [self setArrowFrame];
            self.selectionIndicatorBoxLayer.frame = [self frameForSelectionIndicator];
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [CATransaction commit];
        } else {
            // Disable CALayer animations
            NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
            self.selectionIndicatorArrowLayer.actions = newActions;
            [self setArrowFrame];
            
            self.selectionIndicatorStripLayer.actions = newActions;
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            
            self.selectionIndicatorBoxLayer.actions = newActions;
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
        }
    }
}

- (void)notifyForSegmentChangeToIndex:(NSInteger)index {
    if (self.superview)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (self.indexChangeBlock)
        self.indexChangeBlock(index);
}

//added by tmy
-(void)setBadge:(NSInteger)badgeNum atIndex:(NSInteger)idx{
    if(_badgeArray)
    {

        CustomBadge* badge = [_badgeArray objectAtIndex:idx];
        badge.badgeText = [NSString stringWithFormat:@"%ld",badgeNum];
        badge.badgeScaleFactor = 0.5;
        CGSize offsetSize = badge.offsetSize;
//        offsetSize.width -= 2;
//        offsetSize.height -= 4;
        badge.offsetSize = offsetSize;

        if(badgeNum == 0)
            badge.hidden = YES;
        else
            badge.hidden = NO;
        
        [self setNeedsDisplay];
    }
}

- (void)ewpSegmentBadge:(NSInteger)ewpbadge atIndex:(NSInteger)idx
{
    if(_badgeArray)
    {
        CustomBadge* badge = [_badgeArray objectAtIndex:idx];
        badge.badgeScaleFactor = 0.4;
        CGSize offsetSize = badge.offsetSize;
        offsetSize.width -= 4;
        offsetSize.height -= 6;
        badge.offsetSize = offsetSize;

        badge.badgeFrame = NO;
        badge.badgeText = @"";
        if (ewpbadge == 0)
        {
            badge.hidden = YES;
        }
        else
        {
            badge.hidden = NO;
        }
  
        [self setNeedsDisplay];
    }
}

@end
