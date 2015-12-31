// Zero.il
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
    // Essentially these are overloads of the methods in Set.il, but with a hard-coded value of 0 for value, as a common
    // case.
    .class public auto ansi abstract sealed beforefieldinit Memory extends [mscorlib]System.Object
    {
        .method public hidebysig static void ZeroAligned(void* dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldc.i4.0
            ldarg.1
            initblk
            ret
        }

        .method public hidebysig static void ZeroAligned(void* dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.1
            ldc.i4.0
            blt.s OutOfRange
            jmp void Mnemosyne.Memory::ZeroAligned(void*, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        .method public hidebysig static void Zero(void* dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.1
            ldc.i4.0
            blt.s OutOfRange
            jmp void Mnemosyne.Memory::Zero(void*, uint32)

        OutOfRange:
            ldstr "length"
            newobj instance void [mscorlib]System.ArgumentOutOfRangeException::.ctor(string)
            throw
        }

        .method public hidebysig static void Zero(void* dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 5
            ldarg.0
            ldc.i4.0
            ldarg.1
            ldarg.0
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