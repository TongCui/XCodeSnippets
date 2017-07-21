
/*

Literal        Type     Value

#file          String   The name of the file in which it appears.
#line          Int      The line number on which it appears.
#column        Int      The column number in which it begins.
#function      String   The name of the declaration in which it appears.
#dsohandle     String   The dso handle.


*/

public func track(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) { 
    print("\(message) called from \(function) \(file):\(line)") 
}

track("enters app")
