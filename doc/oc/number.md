# OC Number

```
NSNumberFormatter * theFormatter = [[[NSNumberFormatter alloc] init] 
autorelease];
NSDecimalNumber * theNan = [NSDecimalNumber notANumber];
NSNumber * the0By0 = [NSNumber numberWithFloat:0.0/0.0];
NSNumber * the1By0 = [NSNumber numberWithFloat:1.0/0.0];
NSNumber * theM1By0 = [NSNumber numberWithFloat:-1.0/0.0];

printf("format notANumber : %s\n", [[theFormatter 
stringForObjectValue:theNan] lossyCString]);

printf("format 0/0 : %s\n", [[theFormatter 
stringForObjectValue:the0By0] lossyCString]);
printf("format 1/0 : %s\n", [[theFormatter 
stringForObjectValue:the1By0] lossyCString]);
printf("format -1/0 : %s\n", [[theFormatter 
stringForObjectValue:theM1By0] lossyCString]);

printf("stringValue for 0/0 : %s\n", [[the0By0 stringValue] 
lossyCString]);
printf("stringValue for 1/0 : %s\n", [[the1By0 stringValue] 
lossyCString]);
printf("stringValue for -1/0 : %s\n", [[theM1By0 stringValue] 
lossyCString]);



format notANumber : NaN
format 0/0 : NaN
format 1/0 : NaN
format -1/0 : 0.00
stringValue for 0/0 : NaN
stringValue for 1/0 : Inf
stringValue for -1/0 : -Inf

```
