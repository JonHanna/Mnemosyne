﻿// Overloads.il
//
// Generated File. DO NOT EDIT THIS FILE. Edit Overloads.tt to change the produced file.
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
        .method public hidebysig static void CopyAligned(native int dest, native int source, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::CopyAligned(void*, void*, int32)
            ret
        }

        .method public hidebysig static void Copy(native int dest, native int source, int32 length)
        {
            
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Copy(void*, void*, int32)
            ret
        }

        .method public hidebysig static void SetAligned(native int dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::SetAligned(void*, uint8, int32)
            ret
        }

        .method public hidebysig static void Set(native int dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Set(void*, uint8, int32)
            ret
        }

        .method public hidebysig static void ZeroAligned(native int dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::ZeroAligned(void*, int32)
            ret
        }

        .method public hidebysig static void Zero(native int dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::Zero(void*, int32)
            ret
        }
        .method public hidebysig static void CopyAligned(native int dest, native int source, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::CopyAligned(void*, void*, uint32)
            ret
        }

        .method public hidebysig static void Copy(native int dest, native int source, uint32 length)
        {
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Copy(void*, void*, uint32)
            ret
        }

        .method public hidebysig static void SetAligned(native int dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::SetAligned(void*, uint8, uint32)
            ret
        }

        .method public hidebysig static void Set(native int dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Set(void*, uint8, uint32)
            ret
        }

        .method public hidebysig static void ZeroAligned(native int dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::ZeroAligned(void*, uint32)
            ret
        }

        .method public hidebysig static void Zero(native int dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::Zero(void*, uint32)
            ret
        }
        .method public hidebysig static void CopyAligned(native uint dest, native uint source, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::CopyAligned(void*, void*, int32)
            ret
        }

        .method public hidebysig static void Copy(native uint dest, native uint source, int32 length)
        {
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Copy(void*, void*, int32)
            ret
        }

        .method public hidebysig static void SetAligned(native uint dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::SetAligned(void*, uint8, int32)
            ret
        }

        .method public hidebysig static void Set(native uint dest, uint8 'value', int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Set(void*, uint8, int32)
            ret
        }

        .method public hidebysig static void ZeroAligned(native uint dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::ZeroAligned(void*, int32)
            ret
        }

        .method public hidebysig static void Zero(native uint dest, int32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::Zero(void*, int32)
            ret
        }
        .method public hidebysig static void CopyAligned(native uint dest, native uint source, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::CopyAligned(void*, void*, uint32)
            ret
        }

        .method public hidebysig static void Copy(native uint dest, native uint source, uint32 length)
        {
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Copy(void*, void*, uint32)
            ret
        }

        .method public hidebysig static void SetAligned(native uint dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::SetAligned(void*, uint8, uint32)
            ret
        }

        .method public hidebysig static void Set(native uint dest, uint8 'value', uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 3
            ldarg.0
            ldarg.1
            ldarg.2
            tail.
            call void Mnemosyne.Memory::Set(void*, uint8, uint32)
            ret
        }

        .method public hidebysig static void ZeroAligned(native uint dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::ZeroAligned(void*, uint32)
            ret
        }

        .method public hidebysig static void Zero(native uint dest, uint32 length)
        {
            .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
            .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 00 00 00)
            .maxstack 2
            ldarg.0
            ldarg.1
            tail.
            call void Mnemosyne.Memory::Zero(void*, uint32)
            ret
        }
    }
}
