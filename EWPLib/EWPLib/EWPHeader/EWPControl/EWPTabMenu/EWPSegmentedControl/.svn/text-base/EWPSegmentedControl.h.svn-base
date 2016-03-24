//
//  EWPSegmentedControl.h
//  EWPSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangeBlock)(NSInteger index);

typedef enum {
    EWPSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    EWPSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    EWPSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment
    EWPSegmentedControlSelectionStyleArrow // An arrow in the middle of the segment pointing up or down depending on `EWPSegmentedControlSelectionIndicatorLocation`
} EWPSegmentedControlSelectionStyle;

typedef enum {
    EWPSegmentedControlSelectionIndicatorLocationUp,
    EWPSegmentedControlSelectionIndicatorLocationDown,
	EWPSegmentedControlSelectionIndicatorLocationNone // No selection indicator
} EWPSegmentedControlSelectionIndicatorLocation;

typedef enum {
    EWPSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    EWPSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset)
    EWPSegmentedControlSegmentWidthStyleEqually,
} EWPSegmentedControlSegmentWidthStyle;

enum {
    EWPSegmentedControlNoSegment = -1   // Segment index for no selected segment
};

typedef enum {
    EWPSegmentedControlTypeText,
    EWPSegmentedControlTypeImages,
	EWPSegmentedControlTypeTextImages
} EWPSegmentedControlType;

@interface EWPSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;
//modify by jiangbin
@property (nonatomic, assign) NSInteger sectionCount;

@property (nonatomic, assign) BOOL showShadow;
/*
 Provide a block to be executed when selected index is changed.
 
 Alternativly, you could use `addTarget:action:forControlEvents:`
 */
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

/*
 Font for segments names when segmented control type is `EWPSegmentedControlTypeText`
 
 Default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
 */
@property (nonatomic, strong) UIFont *font;

/*
 Text color for segments names when segmented control type is `EWPSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *textColor;

/* 
 Text color for selected segment name when segmented control type is `EWPSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/*
 Segmented control background color.
 
 Default is [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*
 Color for the selection indicator stripe/box
 
 Default is R:52, G:181, B:229
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor;

@property (nonatomic, strong) UIColor *indicatorBKColor;
/*
 Specifies the style of the control
 
 Default is `EWPSegmentedControlTypeText`
 */
@property (nonatomic, assign) EWPSegmentedControlType type;

/*
 Specifies the style of the selection indicator.
 
 Default is `EWPSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) EWPSegmentedControlSelectionStyle selectionStyle;

/*
 Specifies the style of the segment's width.
 
 Default is `EWPSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) EWPSegmentedControlSegmentWidthStyle segmentWidthStyle;

/*
 Specifies the location of the selection indicator.
 
 Default is `EWPSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) EWPSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Default is NO. Set to YES to allow for adding more tabs than the screen width could fit.
 
 When set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
 otherwise it will be equal to the width of the control's frame divided by the number of segments.
 
 As of v 1.4 this is no longer needed. The control will manage scrolling automatically based on tabs sizes.
 */
@property(nonatomic, getter = isScrollEnabled) BOOL scrollEnabled DEPRECATED_ATTRIBUTE;

/*
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user.
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/*
 Default is YES. Set to NO to deny any touch events by the user.
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;

@property (nonatomic,assign) NSInteger oldSelectedSegmentIndex;
/*
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/*
 Height of the selection indicator. Only effective when `EWPSegmentedControlSelectionStyle` is either `EWPSegmentedControlSelectionStyleTextWidthStripe` or `EWPSegmentedControlSelectionStyleFullWidthStripe`.
 
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/*
 Inset left and right edges of segments. Only effective when `scrollEnabled` is set to YES.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/*
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;

//added by tmy
-(void)setBadge:(NSInteger)badgeNum atIndex:(NSInteger)idx;

- (void)ewpSegmentBadge:(NSInteger)ewpbadge atIndex:(NSInteger)idx;

@end
