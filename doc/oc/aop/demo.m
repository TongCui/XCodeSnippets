@protocol Invoker <NSObject>

// Required methods (must be implemented)
@required
- (void) preInvoke:(NSInvocation *)inv withTarget:(id) target;
// Optional methods
@optional
- (void) postInvoke:(NSInvocation *)inv withTarget:(id) target;

@end

@interface AuditingInvoker : NSObject <Invoker>

@end

@implementation AuditingInvoker

- (void) preInvoke:(NSInvocation *)inv withTarget:(id)target
{
    NSLog(@"Creating audit log before sending message with selector %@ to %@ object",
          NSStringFromSelector([inv selector]), [[target class] description]);
}

- (void) postInvoke:(NSInvocation *)inv withTarget:(id)target
{
    NSLog(@"Creating audit log after sending message with selector %@ to %@ object",
          NSStringFromSelector([inv selector]), [[target class] description]);
}

@end

@interface AspectProxy : NSProxy

@property (strong) id proxyTarget;
@property (strong) id<Invoker> invoker;
@property (readonly) NSMutableArray *selectors;

- (id)initWithObject:(id)object andInvoker:(id<Invoker>)invoker;
- (id)initWithObject:(id)object selectors:(NSArray *)selectors
          andInvoker:(id<Invoker>)invoker;
- (void)registerSelector:(SEL)selector;

@end

@implementation AspectProxy

- (id)initWithObject:(id)object selectors:(NSArray *)selectors
          andInvoker:(id<Invoker>)invoker
{
    _proxyTarget = object;
    _invoker = invoker;
    _selectors = [selectors mutableCopy];
    return self;
}

- (id)initWithObject:(id)object andInvoker:(id<Invoker>)invoker
{
    return [self initWithObject:object selectors:nil andInvoker:invoker];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.proxyTarget methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)inv
{
    // Perform functionality before invoking method on target
    if ([self.invoker respondsToSelector:@selector(preInvoke:withTarget:)])
    {
        if (self.selectors != nil)
        {
            SEL methodSel = [inv selector];
            for (NSValue *selValue in self.selectors)
            {
                if (methodSel == [selValue pointerValue])
                {
                    [[self invoker] preInvoke:inv withTarget:self.proxyTarget];
                    break;
                }
            }
        }
        else
        {
            [[self invoker] preInvoke:inv withTarget:self.proxyTarget];
        }
    }
    
    // Invoke method on target
    [inv invokeWithTarget:self.proxyTarget];
    
    // Perform functionality after invoking method on target
    if ([self.invoker respondsToSelector:@selector(postInvoke:withTarget:)])
    {
        if (self.selectors != nil)
        {
            SEL methodSel = [inv selector];
            for (NSValue *selValue in self.selectors)
            {
                if (methodSel == [selValue pointerValue])
                {
                    [[self invoker] postInvoke:inv withTarget:self.proxyTarget];
                    break;
                }
            }
        }
        else
        {
            [[self invoker] postInvoke:inv withTarget:self.proxyTarget];
        }
    }
}

- (void)registerSelector:(SEL)selector
{
    NSValue* selValue = [NSValue valueWithPointer:selector];
    [self.selectors addObject:selValue];
}

@end

@interface Calculator : NSObject
- (NSNumber *) sumAddend1:(NSNumber *)a1 addend2:(NSNumber *)a2;
- (NSNumber *) sumAddend1:(NSNumber *)a1 :(NSNumber *)a2;
@end

@implementation Calculator

- (NSNumber *) sumAddend1:(NSNumber *)adder1 addend2:(NSNumber *)adder2
{
    NSLog(@"Invoking method on %@ object with selector %@", [[self class] description],
          NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] +
                                        [adder2 integerValue])];
}

- (NSNumber *) sumAddend1:(NSNumber *)adder1 :(NSNumber *)adder2
{
    NSLog(@"Invoking method on %@ object with selector %@", [[self class] description],
          NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] +
                                        [adder2 integerValue])];
}

@end


////////////////////////////////////////////////


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Create Calculator object
    Calculator *calculator = [[Calculator alloc] init];
    NSNumber *addend1 = [NSNumber numberWithInteger:-25];
    NSNumber *addend2 = [NSNumber numberWithInteger:10];
    NSNumber *addend3 = [NSNumber numberWithInteger:15];
    
    // Create proxy for object
    NSValue* selValue1 = [NSValue valueWithPointer:@selector(sumAddend1:addend2:)];
    NSArray *selValues = @[selValue1];
    AuditingInvoker *invoker = [[AuditingInvoker alloc] init];
    id calculatorProxy = [[AspectProxy alloc] initWithObject:calculator
                                                   selectors:selValues
                                                  andInvoker:invoker];
    
    // Send message to proxy with given selector
    [calculatorProxy sumAddend1:addend1 addend2:addend2];
    
    // Now send message to proxy with different selector, no special processing!
    [calculatorProxy sumAddend1:addend2 :addend3];
    
    // Register another selector for proxy and repeat message
    [calculatorProxy registerSelector:@selector(sumAddend1::)];
    [calculatorProxy sumAddend1:addend1 :addend3];
    
    return YES;
}


