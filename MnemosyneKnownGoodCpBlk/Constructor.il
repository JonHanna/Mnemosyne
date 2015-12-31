// Constructor.il
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