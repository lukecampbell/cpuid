cpuid
=====

An example project demonstrating how to include assembly code into a
Python-compatible shared library which can be imported into the CPython runtime
execution.

This project doesn't do much except it can run an x86/64 instruction that is
normally unavailable to processes. This project is mostly to see if it could be
done, it doesn't have much use other than a template, so far.

Dependencies
------------

This project requires an installation of Python 3, and the build-essentials
package (gcc, gnu-make)

Building
--------

```
make
```

Running
-------

The make process produces a `cpuid.so` which can be imported by CPython:

```python
import cpuid
cpuid.cpuid()
```

API
---

`cpuid.cpuid()` returns a tuple of 3 values:

- The CPU vendor string
- CPU feature information (see EDX, and ECCX columns in the "additional inforamation" table [here](https://en.wikipedia.org/wiki/CPUID#EAX=1:_Processor_Info_and_Feature_Bits).)
- CPU extended feature information (See EBX, ECX, EDX colums in the "extended features" table [here](https://en.wikipedia.org/wiki/CPUID#EAX=7,_ECX=0:_Extended_Features).)