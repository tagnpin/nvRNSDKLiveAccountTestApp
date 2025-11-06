//
//  NotificationService.m
//  NVRNPushServiceExt
//
//  Created by Notifyvisitors Macbook Air 4 on 05/11/25.
//

#import "NotificationService.h"
#import <notifyvisitors/notifyvisitors.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
 //   self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
   // self.contentHandler(self.bestAttemptContent);
  [notifyvisitors LoadAttachmentWithRequest: request bestAttemptContent: self.bestAttemptContent withContentHandler: self.contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
