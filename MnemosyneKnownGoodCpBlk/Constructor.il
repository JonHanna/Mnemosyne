// Constructor.il
//
// Author:
//     Jon Hanna <jon@hackcraft.net>
//
// © 2014–2017 Jon Hanna
//
// Licensed under the MIT license. See the LICENSE file in the repository root for more details.

// This file contains a test for the type of chip we are on. One reason is to set the mask to detect misaligned reads
// and the other is implementations specific to x86 (including x86-64 in 32-bit mode) with the Microsoft framework.
// With other processors, and with other frameworks (or at least, with Mono) then using cpblk is the most performant,
// but in the x86 on MS case, the cpblk implementation is poor. We detect this case, and use the separate X86Memory
// class when appropriate.

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
        // 7 on 64-bit, 3 on 32-bit
        .field private static initonly native uint AlignmentMask

        // Static constructor. Calculate alignment mask and detect if we are on x86 (including x86-64 in 32-bit mode) on
        // .NET
        .method private hidebysig specialname rtspecialname static void .cctor() cil managed 
        {
            .maxstack 3
            .locals(string processor)
            
            // ∧ing a address with a mask of 3 for 32-bit or 7 for 64-bit, detects misaligned addresses. 
            sizeof [mscorlib]System.Object
            ldc.i4.1
            sub
            stsfld native uint Mnemosyne.Memory::AlignmentMask
            ret
        }
    }
}
