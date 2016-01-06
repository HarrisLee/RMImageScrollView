//
//  RMImageScrollView.h
//  RMImageScrollView
//
//  Created by JianRongCao on 1/6/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMImageScrollView : UIView

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic        ) CGFloat minimumZoomScale;

@property (nonatomic        ) CGFloat maximumZoomScale;

- (void)setImage:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

@end
