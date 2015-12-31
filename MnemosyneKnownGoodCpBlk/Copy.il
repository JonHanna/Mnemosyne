// Copy.il
//
// Author:
//     Jon Hanna <jon@hackcraft.net>
//
// © 2014 Jon Hanna
//
// Licensed under the EUPL, Version 1.1 only (the “Licence”).
// You may not use, modify or distribute this work except in compliance with the Licence.
// You may obtain a copy of the Licence at:
// <http://joinup.ec.europa.eu/software/page/eupl/licence-eupl>
// A copy is also distributed with this source code.
// Unless required by applicable law or agreed to in writing, software distributed under the
// Licence is distributed on an “AS IS” basis, without warranties or conditions of any kind.

.assembly extern mscorlib
{
    .publickeytoken = (
        b7 7a 5c 56 19 34 e0 89
    )
}

.namespace Mnemosyne
{
    .class public auto ansi abstract sealed beforefieldinit Memory extends [mscorlib]System.Object
    {
        .method public hidebysig static void CopyAligned(void* dest, void* source, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            // If length < 0 we throw an exception. Note that we don’t throw an exception for null pointers. This is for
            // three reasons:
            // 1. The sort of code that would use this library, would be prepared to skip some checks (they can skip
            // this check too by using an unsigned length).
            // 2. Detecting null is easy, but detecting a too-low pointer caused by an offset from a null pointer is
            // platform-dependent. As such we risk either refusing valid code (we blocked too high) or confusing users
            // by throwing NullReferenceException instead of ArgumentNullException if we block too low. Better to just
            // document that we throw NullReferenceException.
            // 3. As well as the possibility of NullReferenceException, and AccessViolationException, there’s the
            // possibility of allowed but incorrect writes that cause strange fandango-on-the-core bugs. Since we can’t
            // protect the user from all possibilities caused by incorrect arguments to dest and source, we don’t make
            // an incomplete attempt.
            ldarg.2
            ldc.i4.0
            blt.s OutOfRange
            // This assembly isn’t verifiable anyway, so we might as well jmp, as Van Halen said. Note this type-puns
            // the signed integer into an unsignd integer of equal value.
            jmp void Mnemosyne.Memory::CopyAligned(void*, void*, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        // To be called only when the calling code is sure that it already knows the source and destination to be
        // correctly aligned. This is in the general spirit that this assembly is not going to protect users from many
        // mistakes that generally .NET/Mono code should catch early; if they insist they need the micro-optimisation,
        // we give them the micro-optimisation.
        .method public hidebysig static void CopyAligned(void* dest, void* source, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            cpblk
            ret
        }

        .method public hidebysig static void Copy(void* dest, void* source, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.2
            ldc.i4.0
            blt.s OutOfRange
            // Kris Kross will make you...
            jmp void Mnemosyne.Memory::Copy(void*, void*, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        .method public hidebysig static void Copy(void* dest, void* source, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 5
            // Okay, about the only thing that approaches real work in this file. First we’ll push all arguments unto
            // the stack, as all following code paths will be wanting them.
            ldarg.0
            ldarg.1
            ldarg.2
            // Now we ∨ the two values. The result is a value that will have the worse alignment of the two addresses.
            // E.g. if one is 4-bytes out of alignmnt and one is 3-bytes out, the result will be 7. Since we only care
            // about the lowest set bit, 3 and 7 both count as 1-byte misalignment, which is the answer we’ll get. 
            ldarg.0
            ldarg.1
            or
            // Then we ∧ that with the alignment mask (3 for 32-bit, 7 for 64-bit). The result leaves us with a measure
            // of the misalignment.            
            ldsfld native uint Mnemosyne.Memory::AlignmentMask
            and
            switch(
                Aligned,        // 0
                Unaligned1Byte, // 1
                Unaligned2Byte, // 2
                Unaligned1Byte, // 3
                Unaligned4Byte, // 4
                Unaligned1Byte, // 5
                Unaligned2Byte, // 6
                Unaligned1Byte) // 7

        Aligned:
            // We aren’t misaligned, so we just cpblk
            cpblk
            ret

        Unaligned4Byte:
            // At least one of the addresses is 4-byte misaligned, so use the appropriate unaligned. directive, and then
            // cpblk. And so on.
            unaligned. 4
            cpblk
            ret

        Unaligned2Byte:
            unaligned. 2
            cpblk
            ret

        Unaligned1Byte:
            unaligned. 1
            cpblk
            ret
        }
    }
}