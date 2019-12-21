/********* cordova_plugin_giaes.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "AESCipher.h"

@interface cordova_plugin_giaes : CDVPlugin 

- (void)encrypt:(CDVInvokedUrlCommand*)command;
- (void)encryptnoencode:(CDVInvokedUrlCommand*)command;
- (void)decrypt:(CDVInvokedUrlCommand*)command;
@end


@implementation cordova_plugin_giaes

- (void)encrypt:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;
    NSString* plainText = [command.arguments objectAtIndex:0];
    NSString* cipherText = aesEncryptString(plainText);

    if (cipherText != nil && [cipherText length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:cipherText];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)encryptnoencode:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;
    NSString* plainText = [command.arguments objectAtIndex:0];
    NSString* cipherText = aesEncryptNoEncodeString(plainText);

    if (cipherText != nil && [cipherText length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:cipherText];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)decrypt:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;
    NSString* encryptedText = [command.arguments objectAtIndex:0];
    NSString* decryptedText = aesDecryptString(encryptedText);

    if (decryptedText != nil && [decryptedText length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:decryptedText];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
