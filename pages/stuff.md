# stuff what ive done made, new to old

---

**sio** - [git](https://github.com/hatcatpat/sio)
- software rendering single-header c library
- designed for making quick and little gui applications
- includes a utility for converting .tga images into static c arrays
- uses a wierd rgb222 colour range, the 6th bit allows for "invisible" pixels
- aiming to be as portable as possible

---

**chrmkr** - [git](https://github.com/hatcatpat/chrmkr)
- a commandline utility written in c to convert images to .chr format
- currently supports .tga, .bmp, and .png

---

**patos** - [git](https://github.com/hatcatpat/patos)
- x86 "operating system", for fun and learning
- bootloader, drawing to screen, exceptions and isr

---

**el** - [git](https://github.com/hatcatpat/el)
- an l-system library
- designed to be general purpose, although im not sure what other uses it has outside of drawing (perhaps conductive?)
- might be nice to make a little js version for drawing and quick prototyping

---

**feab** - [git](https://github.com/hatcatpat/feab)
- a fantasy console/virtual machine and assembly languge
- a key feature is that all memory is accessible (program and internals)
- opcodes do not have address modes, instead they have argument types  (byte + byte, byte + word, word + byte, or word + word) that determine how the opcode functions
- 16 sprites, consisting of (x,y), enabled, and sprite id (which sprite to draw)
- sprites are 4x4 pixels, with 4 colours available (one being the bg)

---

**stak** - [git](https://github.com/hatcatpat/stak)
- forth-style audio synthesis livecoding language
- inspired by sporth and proxyspace
- homemade synthesis engine
- interaction needs work (im a fan of a udp server sent from vim)

---

**spr** - [git](https://github.com/hatcatpat/spr)
- ncurses based terminal sprite editor, for .chr files
- pretty happy with how this turned out :)
- could do with some more hotkeys to make up for lack of mouse controls

---

**patpatpat** - [git](https://github.com/hatcatpat/patpatpat)
- sh static website generator
- made this website
- allows .md files (uses smu), executable files (takes raw output from stdout), and .html files

---

**countdown** - [git](https://github.com/hatcatpat/countdown)
- a countdown (numbers game) generator

---

**column** - [git](https://github.com/hatcatpat/column)
- a column addition generator
- i wanted a way to generate worked answers to column addition for use in teaching

---

**markus** - [git](https://github.com/hatcatpat/markus)
- a markdown sort of wysiwyg transpiler to html
- made in haskell

---

**jisp** - [git](https://github.com/hatcatpat/jisp)
- a lisp -> js transpiler
- made in js

---

**compakt** - [git](https://github.com/hatcatpat/compakt)
- a simple c library for audio/gui applications
- designed to make "one-shot" audio "instruments", similar to pd/max
- includes pitch shifters and fft stuff
- performed live in manchester/salford at the entertainment club

---

**ca** - [git](https://github.com/hatcatpat/ca)
- livecoding c audio using hot reloading dynamic libraries
- inspired by clive, however functionally different
- very dangerous, but not as dangerous as it could be which i think is impressive
