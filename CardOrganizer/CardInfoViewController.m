//
//  CardInfoViewController.m
//  CardOrganizer
//
//  Created by Jiang on 2014-09-23.
//  Copyright (c) 2014 Jet&JXY. All rights reserved.
//

#import "CardInfoViewController.h"
#import "createNewCardViewController.h"

@interface CardInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (strong,nonatomic)UIImage *image;
@end

@implementation CardInfoViewController

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

-(UIImage *)image
{
    return self.imageView.image;
}

- (void)setcardPath:(NSMutableArray *)cardPath
{
    _cardPath = cardPath;
}

-(NSMutableArray *)cardPath
{
    if (!_cardPath) {
        _cardPath = [[NSMutableArray alloc]init];
    }
    return _cardPath;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSString *str in self.cardPath) {
        if(str){
            NSLog(@"str = %@", str);
        }
    }
    
    NSString *textDataPathStr = [[self.cardPath objectAtIndex:0] objectAtIndex:0];
    NSString *imageDataPathStr = [[self.cardPath  objectAtIndex:0] objectAtIndex:1];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:textDataPathStr] || [fileManager fileExistsAtPath:imageDataPathStr]) {

        
        NSArray *data = [[NSArray alloc] initWithContentsOfFile:textDataPathStr];
        
        self.cardNameTextField.text = [data objectAtIndex:0];
        self.cardNumberTextField.text = [data objectAtIndex:1];
        
        UIImage *customImage = [UIImage imageWithContentsOfFile:imageDataPathStr];
        self.imageView.image = customImage;

        
    }else{
        NSLog(@"Did not found corresponding file");
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
