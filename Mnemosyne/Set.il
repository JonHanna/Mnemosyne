// Set.il
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

.assembly extern mscorlib {}

.namespace Mnemosyne
{
    // This is very much analogous to the code in Copy.il, but with initblk instead of cpblk. See that file for detailed
    // explanations of the code, bar one difference in the last method here.
    .class public auto ansi abstract sealed beforefieldinit Memory extends [mscorlib]System.Object
    {
        .method public hidebysig static void SetAligned(void* dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            initblk
            ret
        }

        .method public hidebysig static void SetAligned(void* dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.2
            ldc.i4.0
            blt.s OutOfRange
            jmp void Mnemosyne.Memory::SetAligned(void*, uint8, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        .method public hidebysig static void Set(void* dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.2
            ldc.i4.0
            blt.s OutOfRange
            jmp void Mnemosyne.Memory::Set(void*, uint8, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        .method public hidebysig static void Set(void* dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 5
            ldarg.0
            ldarg.1
            ldarg.2
            ldarg.0
            // Note that we have only one address, so there's no need to ∨ to find the worse, just ∧ to find the degree
            // of misalignment.
            ldsfld native uint Mnemosyne.Memory::AlignmentMask
            and
            switch(
                Aligned,
                Unaligned1Byte,
                Unaligned2Byte,
                Unaligned1Byte,
                Unaligned4Byte,
                Unaligned1Byte,
                Unaligned2Byte,
                Unaligned1Byte)

        Aligned:
            initblk
            ret

        Unaligned4Byte:
            unaligned. 4
            initblk
            ret

        Unaligned2Byte:
            unaligned. 2
            initblk
            ret

        Unaligned1Byte:
            unaligned. 1
            initblk
            ret
        }
    }
}