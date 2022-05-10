import UIKit

/*
 * Value Types
 */

//greeting is a place in memeoty, consuming few bytes
var greeting = "Hello, playground"

//num consume 1 byte in memory
var num: Int8 = 3
//num2 is another byte in memory
var num2 = num


/*
 * Reference Types
 */

//UILabel is a class
//label is a pointer, that points to an address in memeoty where some bytes are representing the UILabel instance
let label = UILabel(frame: .zero)

//allocate 10 bytes
let ref = malloc(10)
//now we may write 10 bytes to ref

//Those 10 bytes are protected from other processes , and no one will accidently write there.

//when done, clear the allocation
free(ref)

class Person{
    
    var name = ""
    
    func doSomething() {}
    
}

func myFunc() {
    //memory for Person allocated
    let p = Person()
    p.doSomething()
    //the memory allocated for Person got free
}

myFunc()

/*
 Obj-C, pre ARC (Automatic Reference Counting)
 
 //memory allocated
 NSString *myStr = [[NSString alloc] init];
 //...
 //...
 
 //memory got free
 [myStr release];
 
 //A function to create something and return it
 - (void)spawnProbe {
    return [[Probe alloc] init];
 }
 
 Probe *probe = [factory spawnProbe];
 //...
 [probe release];
 
 - (void)spawnProbe2 {
 //object is candidate to be released when no one will refer it, meanwhile , the project will be in the pool, until the poll will drain
    return [[[Probe alloc] init] autorelease];
 }
 
 int main() {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [factory spawnProbe2];
    [NSString string];
    [pool drain];
 
    [factory spawnProbe2];
    [NSString string];
 
    [pool release];
 
 }
 
 */

/*
 ARC - Automatic Reference Counting
 
 - count allocations
 - an allocated memory that no pointer is refering it - will be released, immidiately
 
 */

/*
 Strong Reference
 */

class Student {
    
}

func createStudent() -> Student{
    //st1 is strong reference
    //while st1 is around, the allocated memeoty (Size of Student) will be retained
    let st1 = Student()
    sleep(2)
    return st1
}

//myStudent is keeping a reference to the one that st1 pointed to, so memory is still retained
var myStudent: Student? = createStudent()

//no one is pointing to the allocated memoty anynore, memory will be free
myStudent = nil
