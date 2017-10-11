/* TEST_OUTPUT:
---
fail_compilation/fail17769.d(21): Error: cannot implicitly convert expression `s.method()` of type `shared(int)*` to `int*`
fail_compilation/fail17769.d(25): Error: cannot implicitly convert expression `foo1` of type `shared(int)*` to `int*`
fail_compilation/fail17769.d(26): Error: cannot implicitly convert expression `s.ptr` of type `shared(int)*` to `int*`
---
*/

// https://issues.dlang.org/show_bug.cgi?id=17769

struct S()
{
    shared(int)* method() { return ptr; }
    shared(int)* ptr;
}

void main()
{
    S!() s;
    // Correctly rejected - new behaviour
    int* foo = s.method();

    // Correctly rejected - previous behaviour
    auto foo1 = s.method();
    int* bar = foo1; // rejected as expected
    int* baz = s.ptr; // ditto
}
