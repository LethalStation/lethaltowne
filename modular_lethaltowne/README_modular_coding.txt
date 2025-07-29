a quick note on modular coding for anyone who hasn't done it before:

the purpose is to ensure that this codebase can be kept at parity with Azure Peak using as little effort on the part of anyone maintaining it, to benefit from ongoing
code improvements, and the best way to do that is to make as many changes as possible contained in their own neat little .dms that will either not conflict with the
original code at all, or will override old bits of code that we do not want. here's a quick rundown on the techniques involved:

MODULAR OVERRIDES:
byond basically compiles this project top to bottom; it starts at the top of the filetree, and ends at the bottom. that means that by placing our .dms in a folder named
modular_lethaltowne, we're further down the tree than .dm used in base roguetown as well as the modular_hearthstone and modular_azurepeak and thus changes we make in
our .dms will override previous one. For example, you can redefine something like the hunting knife to have more or less force or to use a different icon, or override an 
entire proc by calling it back up and rewriting the block. This is done to cut down on nonmodular edits, which we want to make as sparingly as possible. Large redefines 
may be undesirable if they incur a significant init cost.

NONMODULAR EDITS:
sometimes we can achieve things we want with the code by making surgical changes to one or to a few lines in .dms we inherited from upstream. In these cases, our edits
should be marked in some way that makes them obvious, such as // LETHALTOWNE EDIT - followed by a description of what we changed and why. This makes it easier for future
code maintainers to understand why we made our edits, where we made our edits, and so on.
