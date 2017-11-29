# Mnemosyne

Efficient memory copying, setting and zeroing operations for .NET and Mono.

# License

> Licensed under the MIT license. See the LICENSE file in the repository root for more details.

# NuGet Package

Mnemosyne is available as a [NuGet package](https://www.nuget.org/packages/Mnemosyne)

Run `Install-Package Mnemosyne` in the [Package Manager Console](http://docs.nuget.org/docs/start-here/using-the-package-manager-console) or search for “Mnemosyne” in your IDE’s package management plug-in.

# Usage

This assembly is unverifiable code, and can only be used if it is given full trust, and only by fully-trusted assemblies, as by its very nature it allows writing to arbitrary addresses in memory.  

There are a variety of overloads of the static methods `Copy`, `CopyAligned`, `Set`, `SetAligned`, `Zero` and `ZeroAligned`. They differ in whether they represent addresses as `void*`, `IntPtr` or `UIntPtr`, and whether the sizes involved are represented by signed or unsigned integers. Of these only those using `IntPtr` and signed integers are CLS-Compliant, so some overloads may not be available in your language of choice.

With each of these, the “Aligned” form assumes that the addresses are correctly aligned for the type of CPU it is running on. The other forms detect whether or not the addresses are mis-aligned, and by how much, and react appropriately. Possible consequences of calling the “Aligned” with misaligned addresses include:

1. It makes no difference.
2. It runs much slower.
3. It gives incorrect results.
4. It raises a NullReferenceException or an AccessViolationException.
5. The application dies without a stack-trace.
6. A Stop Screen (Blue Screen of Death or equivalent).
7. The computer goes into shut-down.

Generally though, they are safe if the address is of a single value, the start of an array, or any point within an array where the size of each element is at least as large as the word size for the CPU (4 bytes on 32-bit including 64-bit CPUs running 32-bit processes, 8 bytes for 64-bit CPUs).

Note that lack of an error on x86 or x86-64 does not prove you are using them safely, as those two processors tolerate mis-aligned access well.

Those forms taking signed sizes are checked for negative values. Aside from this, no parameter checking is done. Attempts to use a zero pointer will result in a `NullReferenceException`, rather than a `ArgumentNullException`. This is unusual in .NET/Mono libraries, but justified for a few reasons:

1. The sort of code that would use this library, is the sort of performance-critical code that would be prepared to skip some checks (it can skip the negative value check too by using an unsigned length).
2. Detecting null is easy, but detecting a too-low pointer caused by an offset from a null pointer is platform-dependent. As such we risk either refusing valid code (we blocked too high) or confusing users by throwing `NullReferenceException` instead of `ArgumentNullException` if we block too low. Better to just document that we throw `NullReferenceException` (i.e. right here).
3. As well as the possibility of `NullReferenceException`, and `AccessViolationException`, there’s the possibility of allowed but incorrect writes that cause strange fandango-on-the-core bugs. Since we can’t protect the user from all possibilities caused by incorrect arguments for destination and source, we don’t make an incomplete attempt.

# How It Works

Generally these methods wrap uses of `cpblk` or `initblk`. These IL instructions are unverifiable and therefore will not be produced when compiling most .NET languages. They do though give very good performance, and so are appropriate when performance matters, and unverifiable code is not a problem, or you already have it anyway (it is after all meant to help in writing to arbitrary addresses).

However, the Microsoft implementation of `cpblk` on x86 (including 32-bit processes running on x86-64) is relatively poor. Hence if the code is running on .NET (as opposed to Mono) on x86, we behave as follows:

1. If memcpy is available from msvcrt.dll (this is tested for on start-up) and the amount to copy is more than 640 bytes, that is used.
2. If memcpy is unavailable, or the amount to copy is less than 640 bytes, then a highly-unwound loop is used to perform the copying. This loop is faster than memcpy below 640 bytes due to the cost of P/Invoke, and faster than the MS x86 implementation of cpblk for all sizes of copies.
