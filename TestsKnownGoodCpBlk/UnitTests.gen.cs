﻿// UnitTests.gen.cs
//
// Generated File. DO NOT EDIT THIS FILE. Edit Overloads.tt to change the produced file.
//
// Licensed under the MIT license. See the LICENSE file in the repository root for more details.

using System;
using Mnemosyne;
using NUnit.Framework;

namespace Mnemosyne.Tests
{
    [TestFixture]
    public unsafe class MnemosyneTests
    {
        private const int SourceLen = 1024;
        private const int SourceByteLen = SourceLen * 2;
        private static string Source = new string('ሴ', SourceLen);// U+1234, meaning each byte is set, and easily determined.
        private static string ByteRepString = new string('ሒ', SourceLen); // U+1212, so each byte is set the same.
        private static string AllNullString = new string('\0', SourceLen); // each byte is zero.
        [Test]
        public void SimpleCopyIntPtr()
        {
            for(int len = 0; len != SourceLen; ++len)
            {
                char[] output = new char[len];
                fixed(char* source = Source)
                {
                    fixed(char* dest = output)
                        Memory.CopyAligned((IntPtr)dest, (IntPtr)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                    output = new char[len];
                    fixed(char* dest = output)
                        Memory.Copy((IntPtr)dest, (IntPtr)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                }
            }
        }
        [Test]
        public void SimpleSetIntPtr()
        {
            char[] output = new char[SourceLen];
            fixed(char* dest = output)
                Memory.SetAligned((IntPtr)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.ZeroAligned((IntPtr)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
            fixed(char* dest = output)
                Memory.Set((IntPtr)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.Zero((IntPtr)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
        }
        [Test]
        public void SimpleCopyUIntPtr()
        {
            for(int len = 0; len != SourceLen; ++len)
            {
                char[] output = new char[len];
                fixed(char* source = Source)
                {
                    fixed(char* dest = output)
                        Memory.CopyAligned((UIntPtr)dest, (UIntPtr)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                    output = new char[len];
                    fixed(char* dest = output)
                        Memory.Copy((UIntPtr)dest, (UIntPtr)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                }
            }
        }
        [Test]
        public void SimpleSetUIntPtr()
        {
            char[] output = new char[SourceLen];
            fixed(char* dest = output)
                Memory.SetAligned((UIntPtr)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.ZeroAligned((UIntPtr)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
            fixed(char* dest = output)
                Memory.Set((UIntPtr)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.Zero((UIntPtr)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
        }
        [Test]
        public void SimpleCopyVoidPointer()
        {
            for(int len = 0; len != SourceLen; ++len)
            {
                char[] output = new char[len];
                fixed(char* source = Source)
                {
                    fixed(char* dest = output)
                        Memory.CopyAligned((void*)dest, (void*)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                    output = new char[len];
                    fixed(char* dest = output)
                        Memory.Copy((void*)dest, (void*)source, 2 * len);
                    Assert.AreEqual(Source.Substring(0, len), new string(output));
                }
            }
        }
        [Test]
        public void SimpleSetVoidPointer()
        {
            char[] output = new char[SourceLen];
            fixed(char* dest = output)
                Memory.SetAligned((void*)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.ZeroAligned((void*)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
            fixed(char* dest = output)
                Memory.Set((void*)dest, 0x12, SourceByteLen);
            Assert.AreEqual(ByteRepString, new string(output));
            fixed(char* dest = output)
                Memory.Zero((void*)dest, SourceByteLen);
            Assert.AreEqual(AllNullString, new string(output));
        }
    }
}
