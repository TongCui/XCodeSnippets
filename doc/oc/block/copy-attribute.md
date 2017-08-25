Short Answer

The answer is it is historical, you are completely correct that in current ARC code there is no need to use copy and a strong property is fine. The same goes for instance, local and global variables.

Long Answer

Unlike other objects a block may be stored on the stack, this is an implementation optimisation and as such should, like other compiler optimisations, not have direct impact on the written code. This optimisation benefits a common case where a block is created, passed as a method/function argument, used by that function, and then discarded - the block can be quickly allocated on the stack and then disposed of without the heap (dynamic memory pool) being involved.

Compare this to local variables, which (a) created on the stack, (b) are automatically destroyed when the owning function/method returns and (c) can be passed-by-address to methods/functions called by the owning function. The address of a local variable cannot be stored and used after its owning function/method has return - the variable no longer exists.

However objects are expected to outlast their creating function/method (if required), so unlike local variables they are allocated on the heap and are not automatically destroyed based on their creating function/method returning but rather based on whether they are still needed - and "need" here is determined automatically by ARC these days.

Creating a block on the stack may optimise a common case but it also causes a problem - if the block needs to outlast its creator, as objects often do, then it must be moved to the heap before its creators stack is destroyed.

When the block implementation was first released the optimisation of storing blocks on the stack was made visible to programmers as the compiler at that time was unable to automatically handle moving the block to the heap when needed - programmers had to use a function block_copy() to do it themselves.

While this approach might not be out-of-place in the low-level C world (and blocks are C construct), having high-level Objective-C programmers manually manage a compiler optimisation is really not good. As Apple released newer versions of the compiler improvements where made. Early on it programmers were told they could replace block_copy(block) with [block copy], fitting in with normal Objective-C objects. Then the compiler started to automatically copy blocks off stack as needed, but this was not always officially documented.

There has been no need to manually copy blocks off the stack for a while, though Apple cannot shrug off its origins and refers to doing so as "best practice" - which is certainly debatable. In the latest version, Sept 2014, of Apple's Working with Blocks, they stated that block-valued properties should use copy, but then immediately come clean (emphasis added):

Note: You should specify copy as the property attribute, because a block needs to be copied to keep track of its captured state outside of the original scope. This isn’t something you need to worry about when using Automatic Reference Counting, as it will happen automatically, but it’s best practice for the property attribute to show the resultant behavior.
There is no need to "show the resultant behavior" - storing the block on the stack in the first place is an optimisation and should be transparent to the code - just like other compiler optimisations the code should gain the performance benefit without the programmer's involvement.

So as long as you use ARC and the current Clang compilers you can treat blocks like other objects, and as blocks are immutable that means you don't need to copy them. Trust Apple, even if they appear to be nostalgic for the "good old days when we did things by hand" and encourage you to leave historical reminders in your code, copy is not needed.

Your intuition was right.
