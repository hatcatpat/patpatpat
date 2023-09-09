# and 6502 assembly

## usefuls
- **assembler**: [asm6](https://github.com/parasyte/asm6)
- **examples**: [famicom cookbook](https://git.sr.ht/~rabbits/famicom-cookbook/tree/master/item/docs)
- **emulator**: [fceux](https://fceux.com/web/home.html)
- **the font of all knowledge**: [nesdev wiki](https://www.nesdev.org/wiki/Nesdev_Wiki)
- **sprite/chr editor**: [nasu](https://git.sr.ht/~rabbits/nasu), or maybe [spr](https://github.com/hatcatpat/spr) or even [chrmkr](https://github.com/hatcatpat/chrmkr)
- **6502 opcodes**: [masswerk](https://www.masswerk.at/6502/6502_instruction_set.html)
- **tutorial**: [nerdy nights](https://nerdy-nights.nes.science/downloads/Nerdy-Nights-NES-Tutorials-v1.pdf) (be warned: it uses a different assembler!)

## specs
- cpu: **6502 8-bit**
- colors: **52**
- colors per sprite: **4**
- sprite size: **8x8** or **8x16**
- sprite format: **.chr**, [see spr for an explanation](https://github.com/hatcatpat/spr)
- number of sprites: **64**
- resolution: **256x240 (pal)** and **256x224 (ntsc)**
- input: **2 controllers, with 4-way directions, start, select, a and b**. oh, and a **robot**, a **gun**, a **dancepad**, etc

## how

a program is a series of bytes

some of those bytes are instructions (opcodes), some are data (sprites, palette colors, background tiles, etc)

this means that a "function" is simply a location in memory. these are called labels. but note, labels can in fact be to any location in memory, i.e. a sprite.

the command **db** allows you to write a byte, or series of bytes, to your program. you can also use **dw** to write a word (two bytes)

the first few bytes of the program must contain the **nes header**, which describes things like rom size and video settings

your program will also contain a list of colors (for the palette), and sprite tables (for sprites, and background sprites). it will also probably have a list of sprites to use as a background. these can all be loaded using a simple loop

whenever the nes boots, it will cause a reset interrupt. this will jump to the location specified by the **reset vector**

whenever the nes refreshes the screen, it will cause an nmi interrupt. this will jump to the location specified by the **nmi vector**

thus, the flow of the program is roughly:
- when reset interrupt occurs, run init code and halt
- when nmi interrupt occurs, perform one frame

## misc

### input

i was used to handling input through callbacks, i.e. when a key is pressed, trigger function pressed(key). however, the nes does not trigger any interrupts for things like that. so, the method i have been using is:
- each frame, cache the input state
- a key has been pressed means that: (previous is false) and (current is true)

unfortunately, this means that i have to copy the input state and perform the check every frame.

### macros

macros can be used to define constants (i.e., make a human-readable name for a common memory location).

function-like macros, however, are a gift and a curse. if you pepper your code with them, you run the risk of increasing the size of your program unnecessarily. if code needs to be reused, make it a proper "function" like so

```
function:
    do thing
    rts
```
