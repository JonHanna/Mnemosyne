// AssemblyInfo.il
//
// Author:
//     Jon Hanna <jon@hackcraft.net>
//
// © 2014–2017 Jon Hanna
//
// Licensed under the MIT license. See the LICENSE file in the repository root for more details.

.assembly extern mscorlib { }

.module Mnemosyne.dll
.imagebase 0x72180000
.corflags 0x1
.custom instance void [mscorlib]System.Security.UnverifiableCodeAttribute::.ctor() = (
    01 00 00 00
)

.assembly Mnemosyne
{
    .custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = (01 00 01 00 00)
    .custom instance void [mscorlib]System.Reflection.AssemblyConfigurationAttribute::.ctor(string) = (
        01 00 07 52 65 6c 65 61 73 65 00 00
    )
    .custom instance void [mscorlib]System.Reflection.AssemblyCopyrightAttribute::.ctor(string) = (
        01 00 39 C2 A9 20 32 30 31 34 E2 80 93 32 30 31 37 20 4A 6F 6E 20 48 61 6E 6E 61 2E 20 4C 69 63
        65 6E 73 65 64 20 75 6E 64 65 72 20 74 68 65 20 4D 49 54 20 6C 69 63 65 6E 73 65 2E
    )
    .custom instance void [mscorlib]System.Reflection.AssemblyDescriptionAttribute::.ctor(string) = (
        01 00 29 45 66 66 69 63 69 65 6e 74 20 75 6e 76 65 72 69 66 69 61 62 6c 65 20 6d 65 6d 6f 72 79
        20 6f 70 65 72 61 74 69 6f 6e 73 2e 00 00
    )
    .custom instance void [mscorlib]System.Reflection.AssemblyProductAttribute::.ctor(string) = (
        01 00 09 4D 6E 65 6D 6F 73 79 6E 65 00 00
    )
    .custom instance void [mscorlib]System.Reflection.AssemblyTitleAttribute::.ctor(string) = (
        01 00 09 4D 6E 65 6D 6F 73 79 6E 65 00 00
    )
    .custom instance void [mscorlib]System.Runtime.InteropServices.ComVisibleAttribute::.ctor(bool) = (
        01 00 01 00 00
    )
    .custom instance void [mscorlib]System.Runtime.CompilerServices.CompilationRelaxationsAttribute::.ctor(int32) = (
        01 00 08 00 00 00 00 00
    )
    .custom instance void [mscorlib]System.Runtime.CompilerServices.RuntimeCompatibilityAttribute::.ctor() = (
        01 00 01 00 54 02 16 57 72 61 70 4e 6f 6e 45 78 63 65 70 74 69 6f 6e 54 68 72 6f 77 73 01
    )
    .custom instance void [mscorlib]System.Security.SecurityCriticalAttribute::.ctor() = (01 00 00 00)
    .permissionset reqmin = {
        [mscorlib]System.Security.Permissions.SecurityPermissionAttribute = {
            property bool SkipVerification = bool(true)
        }
    }
    .hash algorithm 0x8004
    .ver 1:1:0:1
}
