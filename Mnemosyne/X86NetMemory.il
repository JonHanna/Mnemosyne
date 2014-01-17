// X86NetCopy.il
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

// This file contains implementations specific to x86 (including x86-64 in 32-bit mode) with the Microsoft framework.
// With other processors, and with other frameworks (or at least, with Mono) then using cpblk is the most performant,
// but in the x86 on MS case, the cpblk implementation is poor. We detect this case, and then we call into the msvcrt
// implementation of memcpy as long as it’s available (we do a test copy in the static constructor) and the length to
// copy is greater than 640 bytes, below which the cost of P/Invoke outweighs the advantages. Otherwise a highly-unwound
// loop is used.

.assembly extern mscorlib
{
    .publickeytoken = (
        b7 7a 5c 56 19 34 e0 89
    )
}

.namespace Mnemosyne
{
    .class private auto ansi abstract sealed beforefieldinit X86Memory extends [mscorlib]System.Object
    {
        .field private static initonly bool CanUseMemCpy
    
        .method private hidebysig static pinvokeimpl("msvcrt.dll" nomangle cdecl) 
        void* memcpy(void* dest, void* src, native uint count) cil managed preservesig 
        {
            .custom instance void [mscorlib]System.Security.SuppressUnmanagedCodeSecurityAttribute::.ctor() = (
                01 00 00 00 ) 
        }

        // Static constructor. Test whether we can call into msvcrt’s implementation of memcpy
        .method private hidebysig specialname rtspecialname static void .cctor() cil managed 
        {
            .maxstack 3
            .locals(int32 testDest, int32 testSource)

            .try
            {
                ldloca.s testDest
                ldloca.s testSource
                ldc.i4.4
                call void* Mnemosyne.X86Memory::memcpy(void*, void*, native uint)
                pop
                // If we got here, then we know using memcpy works.
                ldc.i4.1
                stsfld bool Mnemosyne.X86Memory::CanUseMemCpy
                leave.s Done
            }
            catch [mscorlib]System.Object
            {
                // If we got here, then there’s some problem with using memcpy. We don’t actually care what that problem
                // is, so we just eat the exception.
                pop
                leave.s Done
            }
            Done:
                ret
        }

        .method private hidebysig static void Copy(void* dest, void* source, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 3
            
            // Up to around 640 bytes or so, the implementation in this assembly is fast enough that its being not quite
            // as good as memcpy is outweighed by the cost of P/Invoke, so we use that.
            ldarg.2
            ldc.i4 640
            ble.s DoInternal
            // If we can’t use memcpy, then we don’t try.
            ldsfld bool Mnemosyne.X86Memory::CanUseMemCpy
            brfalse.s DoInternal
            // Otherwise use memcpy, and then discard its return value.
            ldarg.0
            ldarg.1
            ldarg.2
            call void* Mnemosyne.X86Memory::memcpy(void*, void*, native uint)
            pop
            ret

        DoInternal:
            // This assembly isn’t verifiable anyway, so we might as well just jmp.
            jmp void Mnemosyne.X86Memory::MemCpyInternal(void*, void*, uint32)
        }

        .method private hidebysig static void MemCpyInternal(void* dest, void* source, uint32 length) cil managed 
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 4
            .locals init(int32 scratchSpace, void* destCopy, void* sourceCopy)
            
            // Store the pointers, we’ll be doing load-increment-store (that is *dest++ = *source) on them a lot. In
            // theory just hitting the arguments should be just as good, if not better, but for some reason I found that
            // this was marginally better. 
            ldarg.0
            stloc.1
            ldarg.1
            stloc.2

            // If length is less than 4 we push the length onto the stack and then jump right to the end of this method,
            // where the last up-to-three octets are copied.
            ldarg.2
            ldc.i4.4
            bge.s Align
            ldarg.2
            br SubWord

            // We’ll only ever be in this method if we’re running on x86, and x86 is known to handle mis-aligned memory
            // access so well that any attempt to explicitly deal with that issue will be a nett loss. However, if there
            // is a shared mis-alignment (e.g. both destination and source are 3 bytes past the alignment boundary) then
            // working byte-by-byte until they’re aligned could give an improvement, both with CPU alignment, and also
            // on how we hit cache-line and page boundaries.
        Align:
            // Note that the technique here is almost the opposite of the alignment detection used in
            // Copy(void*, void*, uint32). Note also that we’ll move up 2 bytes if one is 2bytes past alignment and the
            // other 3bytes, but this is harmless, or 1 byte if one is 1byte past alignment and the other 3. This is
            // harmless, and possibly being now 2-byte misaligned is slightly better. The main thing is that if they are
            // both the same amount past alignment, we’ll move so that both are now aligned.

            // ∧ the addresses together
            ldarg.0
            ldarg.1
            and
            // ∧ them with 3
            ldc.i4.3
            and
            // Store as we’ll need it again. Skip the rest of this if the result is zero. Otherwise we want to do
            // 1-3 single-octet copies, so jump into the appropriate point in a sequence of three such copies.
            dup
            stloc.0
            switch(Aligned, Misaligned1, Misaligned2, Misaligned3)

        Misaligned1:
            // This pattern comes up repeatedly here, albeit with different increments. We load the destination,
            // duplicate, increment, and then store again. Then we do the same for the source. Then we load a value
            // from the duplicated source, and store it in the duplicated destination. In C# this is *dest++ = *source++
            ldloc.1
            dup
            ldc.i4.1
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.1
            add
            stloc.2
            ldind.u1
            stind.i1

        Misaligned2:
            ldloc.1
            dup
            ldc.i4.1
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.1
            add
            stloc.2
            ldind.u1
            stind.i1

        Misaligned3:
            ldloc.1
            dup
            ldc.i4.1
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.1
            add
            stloc.2
            ldind.u1
            stind.i1

            // We’ve done a small portion of the copying already, so we adjust the length parameter accordingly.
            // Subtract our misalignment measure from 4, then subtract that from length, and we’ve the remaining length.
            ldarg.2
            ldc.i4.4
            ldloc.0
            sub
            sub
            starg.s length

        Aligned:
            // If we’ve less than 8 octets left, jump to the end where we deal with them.
            ldarg.2
            ldc.i4.8
            blt Last7Bytes

            // We’re going to copy now a 8-byte unit at a time. The number of times we have to do that will be
            // length << 3.
            ldarg.2
            ldc.i4.3
            shr
            // There are three different attitudes to loop unwinding:
            // 1. It’s a great way to make everything faster, so one should always do it when performance matters.
            // 2. It gets in the way of the compiler/jitter/chip’s optimisations, so one should never do it.
            // 3. Both the above can be true, so one should profile. I profiled, this is faster.
            
            // ∧ our copy count with 15, and jump into the appropriate position in a set of 16 copies.
            stloc.0
            ldloc.0
            ldc.i4.s 15
            and
            switch(Remainder0, Remainder1, Remainder2, Remainder3, Remainder4, Remainder5, Remainder6, Remainder7, Remainder8, Remainder9, Remainder10, Remainder11, Remainder12, Remainder13, Remainder14, Remainder15)

        Remainder0:
            // The same *dest++ = *source++ pattern as above, but this time with 8-byte copies, and 8-byte increments.
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder15:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder14:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder13:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder12:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder11:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder10:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder9:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder8:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder7:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder6:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder5:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder4:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder3:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder2:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

        Remainder1:
            ldloc.1
            dup
            ldc.i4.8
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.8
            add
            stloc.2
            ldind.i8
            stind.i8

            // Subtract 16 from the count of copies to do. If we’ve less than 16 then we’re done here, otherwise do
            // another loop.
            ldloc.0
            ldc.i4.s 16
            sub
            dup
            stloc.0
            ldc.i4.0
            bgt Remainder0

        Last7Bytes:
            // ∧ the length with 4. If the result is zero, skip to the last 3 bytes. Otherwise, do a 4-byte copy-and-
            // increment, similar to the above.
            ldarg.2
            ldc.i4.4
            and
            brfalse.s Last3Bytes

            ldloc.1
            dup
            ldc.i4.4
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.4
            add
            stloc.2
            ldind.i4
            stind.i4

        Last3Bytes: 
            // ∧ the length with 3 to get the number (from 0 to 3) of the last few bytes to copy.
            ldarg.2
            ldc.i4.3
            and
            // Note that we may also arrive here from the check for length < 4 at the very beginning, in which case the
            // length will be on the top of the stack, and we’ll do the right thing.
        SubWord:
            switch(Done, Remaining1, Remaining2, Remaining3)

        Remaining3:
            // Again with the *dest++ = *source++ pattern.
            ldloc.1
            dup
            ldc.i4.1
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.1
            add
            stloc.2
            ldind.u1
            stind.i1

        Remaining2:
            ldloc.1
            dup
            ldc.i4.1
            add
            stloc.1
            ldloc.2
            dup
            ldc.i4.1
            add
            stloc.2
            ldind.u1
            stind.i1

        Remaining1:
            // Last byte, so don't bother incrementing the pointers.
            ldloc.1
            ldloc.2
            ldind.u1
            stind.i1

        Done:
            // Mission accomplished.
            ret
        }
    }
}