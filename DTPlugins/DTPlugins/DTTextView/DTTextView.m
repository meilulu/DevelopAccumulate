//
//  DTTextView.m
//  DTPluginDemo
//
//  Created by 树妖 on 2019/6/18.
//  Copyright © 2019 树妖. All rights reserved.
//

#import "DTTextView.h"
#import "Masonry.h"
@interface DTTextView()<UITextViewDelegate>

@property (strong, nonatomic) NSMutableParagraphStyle *paragraphStyle;

@end
@implementation DTTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        self.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.delegate = self;
        self.maxCount = 100;
        
        //输入文字段落
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        [attributes setObject:self.paragraphStyle forKey:NSParagraphStyleAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName];
        self.typingAttributes = attributes;
        
        [self addSubview:self.placeholderLabel];
        [self addSubview:self.characterCountLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@(width-30));
        make.top.equalTo(self).offset(10);
    }];
    
    [self.characterCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_left).offset(width-30);
        make.bottom.equalTo(self.mas_top).offset(height-20);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length>0;
    
    self.characterCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",textView.text.length,self.maxCount];
    if (textView.text.length>=self.maxCount) {
        textView.text = [textView.text substringToIndex:self.maxCount-1];
        self.characterCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.maxCount,self.maxCount];
    }
}

//设置行距后光标变长。可以通过这方法设置合适的光标大小
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect rect = [super caretRectForPosition:position];
    rect.size.height = self.font.lineHeight + 2;
    rect.size.width = 3;
    
    return rect;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    self.characterCountLabel.text = [NSString stringWithFormat:@"0/%ld",self.maxCount];
}

- (void)setCountLabelHidden:(BOOL)countLabelHidden {
    _countLabelHidden = countLabelHidden;
    self.characterCountLabel.hidden = countLabelHidden;
}
#pragma mark - 懒加载
- (NSMutableParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [NSMutableParagraphStyle new];
        _paragraphStyle.alignment = NSTextAlignmentNatural;
        _paragraphStyle.lineSpacing = 10;//行间距（上下两行距离）
    }
    return _paragraphStyle;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.numberOfLines = 3;
        _placeholderLabel.textColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1];
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UILabel *)characterCountLabel {
    if (!_characterCountLabel) {
        _characterCountLabel = [UILabel new];
        _characterCountLabel.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
        _characterCountLabel.hidden = true;
    }
    
    return _characterCountLabel;
}

@end
