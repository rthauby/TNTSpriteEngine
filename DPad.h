//
//  DPad.h
//  TNTSpriteEngine
//
//  Created by Rodrigo Thauby on 9/28/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPadDelegate <NSObject>
@optional
- (void) moveTo:(CGPoint)point;
@end

@interface DPad : UIView {
	CGPoint center;
	CGPoint pressedPoint;
	id <DPadDelegate> delegate;
	UIImageView *thumb;
	float radius;
	float diameter;
}

@property (nonatomic, assign) id <DPadDelegate> delegate;
@property (nonatomic, retain) UIImageView *thumb;

- (id) initWithImage:(UIImage *)img andFrame:(CGRect)frame;

@end
