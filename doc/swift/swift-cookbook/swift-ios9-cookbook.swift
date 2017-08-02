/*
Chapter 1. Swift 2.0, Xcode 7, and Interface Builder
*/

guard let data = data,
      let str = NSString(data: data, encoding: NSUTF8StringEncoding)
      where data.length > 0 else{
      return nil
    }

