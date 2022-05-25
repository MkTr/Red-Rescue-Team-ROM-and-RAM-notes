# Cipnit's Red Rescue Team RAM and ROM notes
A bunch of things I found while hacking PMD RRT (american/australian localization) to develop the Complete Team Control and Advanced Rescue Team romhacks. The primary focus is the game's ASM code and the game's dungeon phase - this should be useful for making ASM hacks, datamining, and cheating in general. Instantly giving your pokemon EXP, warping to the next floor, giving pokemon moves and finding move IDs based on pointers to their names should be especially helpful for testing. 

This isn't supposed to be a complete documentation of RRT, it's just my personal notes - I'm not expecting anyone to submit things they found, unless you found a few things and don't know where else to share it. I'm not planning on making the notes perfect, but I will change something if it's blatantly wrong. The RRT decompilation project probably covers all of this with a lot less speculation, you can check it out here: https://github.com/pret/pmd-red

Also included are armips patches which fix two of RRT's bugs: quicksave manipulation and the infinite money glitch. Read their files for explanations, and armips install instructions for armips install instructions.

Github unfortunately doesn't wrap the text on txt files, but you can use the left/right arrow keys to scroll horizontally, or edit the file and select soft wrap.



### Getting started

If you're new to assembly hacking, you can try figuring this stuff out. I might make a tutorial someday.

An introduction to ARM & Thumb assembly: https://github.com/Touched/asm-tutorial/blob/master/doc.md

no$gba's debug version, which you'll use to set breakpoints for any reads to / writes from addresses so you can see the game's code: http://problemkaputt.de/gba.htm

(a few notes about no$gba's debugger: it has a bug where, if you set or delete an operation breakpoint (not a read/write one) at code which is supposed to be in Thumb mode while the game is paused in ARM mode, nocash will bug up or crash eventually. GBA games are mostly in thumb, but whenever you pause RRT, it always starts in ARM mode: hold F3 for a few seconds until the code switches to Thumb mode, then set your breakpoint. It also doesn't have a way of finding variables in RAM like VBA's cheat finder can. Also its Help tab is extremely useful, check out Help -> Debugging -> Breakpoints.)

armips, which can be used to convert .asm source code files into machine code and insert it into a ROM: https://github.com/Kingcom/armips/releases

A quick reference for common operations and comparisons: https://www.gbadev.org/docs.php?showinfo=19

A complete list of Thumb and ARM operations in no$gba's help (note that GBA games are almost always in Thumb mode): http://problemkaputt.de/gbatek.htm#thumbinstructionsummary  http://problemkaputt.de/gbatek.htm#arminstructionsummary

Official ARM&Thumb manual: https://www.gbadev.org/docs.php?showinfo=17

I didn't read through this stuff, but it's probably useful: https://gbatemp.net/threads/beginner-at-gba-asm-hacking-question-about-break-points.418824/

You can also look at the team control hack's armips file in the attachment here, though some of the code is really wonky: https://www.pokecommunity.com/showthread.php?p=9979603

Or for simpler code, here's a starter pokemon randomizer (I accidentally put it in an area which overlaps with code I made for advanced rescue team, so you'll need to relocate the code if you want to combine these hacks - instructions are in the readme file): https://cdn.discordapp.com/attachments/714222451965558856/862897631189663784/RRT_Starter_Randomizer.zip

Also here's a mod which makes gummis give exp, recommended if you're using the pokemon randomizer due to how awful RRT's exp curves are: 
https://cdn.discordapp.com/attachments/714222451965558856/862907072722632714/gummi_exp_mod.zip
