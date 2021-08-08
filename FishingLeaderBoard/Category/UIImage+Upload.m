//
//  UIImage+Upload.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/23.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIImage+Upload.h"
#import "AppManager.h"


@implementation UIImage (Upload)
#define kUrl "networkURL"
-(void)uploadSelf:(void (^)(void))onSuccess failure:(void (^)())onFailure{
 [[ApiFetch share] upload:self
                  success:^(NSString * _Nonnull fileUrl) {
      objc_setAssociatedObject(self,
                               kUrl,
                               fileUrl,
                               OBJC_ASSOCIATION_COPY);
     onSuccess();
     
 } failure:^{
     onFailure();
 }];
//    NSData * data = UIImageJPEGRepresentation(self,0.3);
//   
//       
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//
////    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    [manager.requestSerializer setValue:[AppManager manager].token
//                     forHTTPHeaderField:@"token"];
////    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
////    [manager POST:UPLOAD_URL
////       parameters:@{}
////          headers:manager.requestSerializer.HTTPRequestHeaders
////constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
////NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
////formatter.dateFormat =@"yyyyMMddHHmmss";
////NSString *str = [formatter stringFromDate:[NSDate date]];
////NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
////
//////上传的参数(上传图片，以文件流的格式)
////[formData appendPartWithFileData:data
////                            name:@"file"
////                        fileName:fileName
////                        mimeType:@"image/jpeg"];
////
////    } progress:^(NSProgress * _Nonnull uploadProgress) {
////        NSLog(@"uploadProgress = %@",uploadProgress);
////    }
////          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////
////    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////
////    }];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                             @"text/html",
//                                                             @"text/plain",
//                                                             @"image/jpeg",
//                                                             @"image/png",
//                                                             @"application/octet-stream",
//                                                             @"text/json",
//                                                             nil];
//        [manager POST:UPLOAD_URL
//           parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                [formData appendPartWithFileData:UIImageJPEGRepresentation(self, 0.3) name:@"file" fileName:@"123.jpg" mimeType:@"image/jpg"];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            objc_setAssociatedObject(self, kUrl, [[responseObject valueForKey:@"data"] valueForKey:@"value"], OBJC_ASSOCIATION_COPY);
//            NSLog(@"%@",objc_getAssociatedObject(self, kUrl));
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        }];
}
-(NSString *)networkURL{
    return objc_getAssociatedObject(self, kUrl);
}
@end
