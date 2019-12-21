#import <Foundation/Foundation.h>

NSString * aesEncryptString(NSString *content);
NSString * aesEncryptNoEncodeString(NSString *content);
NSString * aesDecryptString(NSString *content);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);
