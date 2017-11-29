// Constructor.il
//
// Author:
//     Jon Hanna <jon@hackcraft.net>
//
// © 2014–2017 Jon Hanna
//
// Licensed under the MIT license. See the LICENSE file in the repository root for more details.

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

        // Static constructor. Calculate alignment mask
        .method private hidebysig specialname rtspecialname static void .cctor() cil managed 
        {
            .maxstack 3

            // ∧ing a address with a mask of 3 for 32-bit or 7 for 64-bit, detects misaligned addresses. 
            sizeof [mscorlib]System.Object
            dup
            ldc.i4.1
            sub
            stsfld native uint Mnemosyne.Memory::AlignmentMask
            ret
        }
    }
}
