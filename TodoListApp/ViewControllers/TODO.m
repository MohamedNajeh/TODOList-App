//
//  TODO.m
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import "TODO.h"

@implementation TODO

- (void)encodeWithCoder:(nonnull NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_descrip forKey:@"descrip"];
    [encoder encodeObject:_periorty forKey:@"periorty"];
    [encoder encodeObject:_currDate forKey:@"date"];
    [encoder encodeObject:_status forKey:@"status"];
}

- (id)initWithCoder:(nonnull NSCoder *)decoder {
    if((self = [super init])){
        _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _descrip = [decoder decodeObjectOfClass:[NSString class] forKey:@"descrip"];
        _periorty = [decoder decodeObjectOfClass:[NSString class] forKey:@"periorty"];
        _currDate = [decoder decodeObjectOfClass:[NSString class] forKey:@"date"];
        _status = [decoder decodeObjectOfClass:[NSString class] forKey:@"status"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}
@end
