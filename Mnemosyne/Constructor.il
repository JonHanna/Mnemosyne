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
        // Running on x86, on .NET
        .field private static initonly bool X86Net
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
            dup
            ldc.i4.1
            sub
            stsfld native uint Mnemosyne.Memory::AlignmentMask

            // If we aren’t on 32-bit (size of a referene isn’t 4) we don’t care about the rest of this.
            ldc.i4.4
            bne.un.s Done

            // Mono doesn’t have the noted problem with x86
            ldstr "Mono.Runtime"
            call class [mscorlib]System.Type [mscorlib]System.Type::GetType(string)
            brinst.s Done
        
            // This only works on Windows, but we only care about Windows. 
            ldstr "PROCESSOR_ARCHITECTURE"
            call string [mscorlib]System.Environment::GetEnvironmentVariable(string)
            stloc.0

            // x86 and x86-64 ("AMD64") are the two cases we care about.
            ldloc.0
            ldstr "x86"
            call bool [mscorlib]System.String::op_Equality(string, string)
            brtrue.s IsX86Net
        
            ldloc.0
            ldstr "AMD64"
            call bool [mscorlib]System.String::op_Equality(string, string)
            brfalse.s Done
        
        IsX86Net:
            // Mark X86Net as true
            ldc.i4.1
            stsfld bool Mnemosyne.Memory::X86Net
        Done:
            ret
        }
    }
}