//
//  BLCMediaTableViewCell.m
//  BlocStagram
//
//  Created by Coby West on 4/30/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMediaTableViewCell.h"
#import "BLCMedia.h"
#import "BLCComment.h"
#import "BLCUser.h"

@interface BLCMediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelWidthConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *commentLabelWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGrey;
static UIColor *commentLabelGrey;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;


@implementation BLCMediaTableViewCell

+(void) load
{
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    usernameLabelGrey = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1];
    commentLabelGrey = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1];
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1];
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.mediaImageView = [[UIImageView alloc] init];
//        self.usernameAndCaptionLabel = [[UILabel alloc] init];
//        self.usernameAndCaptionLabel.numberOfLines = 0;
//        self.commentLabel = [[UILabel alloc] init];
//        self.commentLabel.numberOfLines = 0;
        
            [self.contentView addSubview:self.mediaImageView];
            self.mediaImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
   NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]"
                                                                             options:kNilOptions
                                                                             metrics:nil
                                                                               views:viewDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_usernameAndCaptionLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
    
    
    
    self.imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:.5
                                                               constant:1];
    
//    self.usernameAndCaptionLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
//                                                                                attribute:NSLayoutAttributeWidth
//                                                                                relatedBy:NSLayoutRelationEqual
//                                                                                   toItem:nil
//                                                                                attribute:NSLayoutAttributeNotAnAttribute
//                                                                               multiplier:1
//                                                                                 constant:100];
//    
//    self.commentLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
//                                                                     attribute:NSLayoutAttributeWidth
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:nil
//                                                                     attribute:NSLayoutAttributeNotAnAttribute
//                                                                    multiplier:1
//                                                                      constant:100];
//    
//    [self.contentView addConstraints:@[self.imageWidthConstraint, self.usernameAndCaptionLabelWidthConstraint, self.commentLabelWidthConstraint]];
    [self.contentView addConstraint:self.imageWidthConstraint];
    self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:1];
    
//    self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
//                                                                                attribute:NSLayoutAttributeHeight
//                                                                                relatedBy:NSLayoutRelationEqual
//                                                                                   toItem:nil
//                                                                                attribute:NSLayoutAttributeNotAnAttribute
//                                                                               multiplier:1
//                                                                                 constant:100];
//    
//    self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
//                                                                     attribute:NSLayoutAttributeHeight
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:nil
//                                                                     attribute:NSLayoutAttributeNotAnAttribute
//                                                                    multiplier:1
//                                                                      constant:100];
//    
//    [self.contentView addConstraints:@[self.imageHeightConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
    [self.contentView addConstraint:self.imageHeightConstraint];

    return self;
}

-(NSAttributedString *) usernameAndCaptionString
{
    CGFloat usernameFontSize = 15;
    
    NSString *baseString = [[NSString alloc] init];
    
    if (self.mediaItem.caption)
    {
        baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    }
    else
    {
        baseString = self.mediaItem.user.userName;
    }

    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

-(NSAttributedString *) commentString
{
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    
    for (BLCComment *comment in self.mediaItem.comments)
    {
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
        
        [commentString appendAttributedString:oneCommentString];
    }
    return commentString;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
//    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
//    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
//    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
    
//    self.usernameAndCaptionLabelWidthConstraint.constant = usernameLabelSize.width + 20;
//    self.commentLabelWidthConstraint.constant = commentLabelSize.width +20;
//    
//    
//    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height + 20;
//    self.commentLabelHeightConstraint.constant = commentLabelSize.height +20;
    
    CGFloat imageHeight = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    
    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds)/2, imageHeight);
    
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(self.bounds));
}

-(void) setMediaItem:(BLCMedia *)mediaItem
{
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
    
//    self.imageWidthConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds) / 2;
    
//     self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width
{
    BLCMediaTableViewCell *layoutCell = [[BLCMediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
        layoutCell.mediaItem = mediaItem;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

@end
