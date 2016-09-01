//
//  ViewController.m
//  涂鸦
//
//  Created by Ryan on 15/10/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "ZRPainView.h"
#import "UIImage+ZR.h"
#import "MBProgressHUD+MJ.h"
#import "ZRPictureController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)clear:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)drawArrow:(id)sender;
- (IBAction)drawLine:(id)sender;
- (IBAction)drawRect:(id)sender;

- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet ZRPainView *PainView;
/** originalImage */
@property (nonatomic, strong) UIImage *originalImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PainView.backgroundColor = [UIColor clearColor];
    self.PainView.status = none;
    
}


- (IBAction)pictures:(id)sender {
    ZRPictureController * pictureController = [[ZRPictureController alloc] init];
    [self presentViewController:pictureController animated:YES completion:nil];
}

- (IBAction)clear:(id)sender {
   
    [self.PainView clear];
}

- (IBAction)back:(id)sender {
    [self.PainView back];
}

- (IBAction)drawArrow:(id)sender {
    self.PainView.status = arrow;// 换成箭头
   }

- (IBAction)drawLine:(id)sender {
    self.PainView.status = line;// 换成线
}

- (IBAction)drawRect:(id)sender {
    self.PainView.status = rect;

}

- (IBAction)save:(id)sender {
    // 截图
    UIImage *image = [UIImage captureWithView:self.pictureView];
    
    // 保存
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (IBAction)takePhoto:(id)sender {
    // 设置为相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
//    [self presentModalViewController:picker animated:YES];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 * 保存图片操作之后就会掉用
 */
 - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    }
    else
    {
        [MBProgressHUD showSuccess:@"保存成功"];
    }

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.originalImage = info[UIImagePickerControllerOriginalImage];
   

    
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = self.originalImage;
}

@end
