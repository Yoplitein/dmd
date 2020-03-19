/*
REQUIRED_ARGS: -betterC
POST_SCRIPT: runnable/extra-files/test17868-postscript.sh
RUN_OUTPUT:
---
init
init
main
fini
fini
---
*/

import core.stdc.stdio;

extern(C):

pragma(crt_constructor)
pragma(crt_destructor)
void ctor_dtor_1()
{
    __gshared bool initialized;
    puts(initialized ? "fini" : "init");
    initialized = true;
}

pragma(crt_constructor)
__gshared int var; // ignored for anything but functions

pragma(crt_constructor)
{
    version (all) void init()
    {
        puts("init");
    }
}

template fini()
{
    pragma(crt_destructor)
    void fini()
    {
        puts("fini");
    }
}

alias instantiate = fini!();

int main()
{
    puts("main");
    return 0;
}