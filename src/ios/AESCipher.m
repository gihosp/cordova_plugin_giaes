
#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>

//NSString const *kInitVector = @"[B@127b40f";
NSString const *key = @"A1234&ABCDE/98745#000078";
size_t const kKeySize = kCCKeySizeAES192;


NSData * cipherOperation(NSData *contentData, NSData *keyData, CCOperation operation) {
    NSUInteger dataLength = contentData.length;    
    const unsigned char bytes[]  = {8, 7, 5, 6, 4, 1, 2, 3, 18, 17, 15, 16, 14, 11, 12, 13};
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    NSString *stringiv = [[NSString alloc] initWithData:data
                                               encoding:NSASCIIStringEncoding];
    
    void const *initVectorBytes = [stringiv dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;

    
    
    size_t operationSize = dataLength + kCCKeySizeAES192;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyBytes,
                                          kKeySize,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}

NSString * aesEncryptString(NSString *content) {
    NSCParameterAssert(content);
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = aesEncryptData(contentData, keyData);
    
    NSString *value = [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *plaincrypt = [value stringByReplacingOccurrencesOfString:@"\n"
                                             withString:@""];
    NSLog(@"%@plaincrypt", plaincrypt);
    
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]" "";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedData = [plaincrypt stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
     NSLog(@"%@encodedcrypt", encodedData);
    
    return encodedData;
}

NSString * aesDecryptString(NSString *content) {
    NSCParameterAssert(content);
    content = [content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = aesDecryptData(contentData, keyData);
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

NSString * aesEncryptNoEncodeString(NSString *content) {
    NSCParameterAssert(content);
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = aesEncryptData(contentData, keyData);
    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

NSData * aesEncryptData(NSData *contentData, NSData *keyData) {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize * 8, kKeySize];
    NSCAssert(keyData.length == kKeySize, hint);
    return cipherOperation(contentData, keyData, kCCEncrypt);
}

NSData * aesDecryptData(NSData *contentData, NSData *keyData) {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize * 8, kKeySize];
    NSCAssert(keyData.length == kKeySize, hint);
    return cipherOperation(contentData, keyData, kCCDecrypt);
}
