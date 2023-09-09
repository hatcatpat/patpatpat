# the seemingly mystical world of virtual machines

## links

- [chip-8 wikipedia](https://en.wikipedia.org/wiki/chip-8)
- [hundred rabbits](https://100r.co/site/home.html)
- [uxn](https://wiki.xxiivv.com/site/uxn.html)
- [varvara](https://100r.co/site/uxn.html)

## uxn

my exploration began when i discovered the **uxn** virtual machine +
language, made by the ingenious and oft eccentric duo of swashbuckling
techno-sailors known as **hundred rabbits**. the **uxn** project
consists of a stack machine with:

- 256 bytes of working stack, and 256 bytes of return stack
- 64kb of ram
- 32 opcodes
- 16 devices, each with 16 bytes of memory

on top of this, they have created a **forth** style language called
**uxntal**. at its core **uxntal**, and in fact all programming
languages, are simply an elaborate series of **push/pop** and
**read/write** calls: i.e, adding/removing things from the stack or
storing/reading things from memory

finally, they had to create a program to emulate this
**virtual machine**. the approach is the exact same as an emulator for
any **physical machine** (like a game boy, nes, n64, etc). you set up
all the required data, you connect up all the required *devices*, and
just like that bob is quite firmly your uncle. the folks over at
**hundred rabbits** made a perfectly good emulator called
**varvara**

you may well be thinking "isn't it a bit overkill to create an entire virtual
machine just to make a program/game?", and the answer to that thought is,
maybe. however, the magic of this approach lies in the emulator. okay, so
lets imagine that you are (hypothetically) using a *brand new* (or
*brand old* i guess) operating system called *pat-os*, but
**varvara** only works on linux, mac, and windows. you may very well be
thinking, "great, all my old **uxn** programs are useless :(". but fret
not, my dear, for **virtual machines** are magical and wondrous things!
all you have to do is write a new *emulator*, not a new program. in fact,
you don't even have to look at a single line of **uxntal**. you just
have to find a *pat-os* way of implementing the various stacks, memory
stores and devices. once you've done that, any and all
**uxntal** programs will work exactly the same as before: provided you
do it correctly, which i have absolute faith that you will

## chip8

i may seem cheery now (with the delicious strawberry aftertaste of hindsight),
but at the time this all seemed to me like an absurdly impossible task. and
so, i went searching for the oracles of the internet. they told me (through
various visions and dreams) to gaze upon *chip8*

**chip8** is an 8bit virtual machine and language from the 70's, and it
was designed for an obscure home computer called the *cosmac vip*. why
then, i hear you ask, did the oracles recommend such an archaic system? the
answer, my dear friends, is that the **chip8** is a perfect example of
what a virtual machine *actually* is. in fact, the
[wikipedia](https://en.wikipedia.org/wiki/chip-8) page is all you
need to create a **chip8** emulator for yourself!

### first, the hardware:

- memory: the **chip8** has **0x1000** bytes of memory, and
traditionally the first **0x200** bytes contained the interpreter itself.
this means that our program (and all the 'data' like sprites, fonts, etc)
must be contained within the range (**0x200**,**0x1000**)

- registers: there are **16** registers (**v0** to **vf**),
however the last register is also used as a flag for some operations. for
instance, if you change a pixel (from **1** to **0**, or from
**0** to **1**), vf will be set to **1**. there is also an 'address
register' called **i**, which is **12** bits. and finally, a 'program
counter' called **pc** which records the current 'line' (in this case,
the byte) that the program is on

- *(return) stack*: this stack is used to return from a function (i.e,
its a stack that only stores addresses to functions), and is large enough to
go **12** functions deep

- timers: the **chip8** has **2** 'timers', which are
numbers that decrease at **60hz**: one is used as a generic timer, and
one controls the sound

- input: there are **16** keys [**0**,**f**], each stored as
single bit

- video/audio: the screen is **64x32** **1bit** color, and you
draw to it using sprites of width **8** and height in the range
[**1**,**16**]. the audio is a painful beep, and is enabled whenever
the sound timer is non-zero

### now, the software:

okay, now that the hardware is out of the way...how do we program the dang
thing? well, we use **opcodes** of course! everyone loves
**opcodes**. an **opcode** is just a number that represents an
instruction. i.e **7 = pet dog**, **42 = kill jester**, etc etc.
the [wikipedia](https://en.wikipedia.org/wiki/chip-8)
entry (is excellent) and lists all of the **35**
**opcodes**, as well as a c-pseudo code implementation of each. note:
**uxntal** only has 32 **opcodes**!

a *program* then, is simply a list of **opcodes**. the following
describes how to *run* a program:

- load the program into memory (i.e, by reading a file, or a floppy disk, or a
vinyl, or a stone tablet, etc)

- reset the **registers**, **pc = 0; i = 0; v0 = 0; ... vf = 0;**

- read the first byte of the program. oh look, its **0x6034**! i love
**0x6034**! this is an **opcode** which means "set **v0** to
the data stored at the **0x34**-th byte of our program". i.e, the
**6** means "set", the **0** means "**v0**", and the
**34** means "**0x34**-th byte of our program" (remember, these
opcodes are all on the [wikipedia](https://en.wikipedia.org/wiki/chip-8)
*;^)* )

- okay, we did that **opcode** really well! lets do the next one: to do
this, we have to increment **pc** and then do the **opcode** that
stored in memory at that location

- then we just repeat this process forever and foreverever and forevereverever
(well, until we get bored, the program ends, or the heat death of the
universe)
