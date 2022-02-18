/*
Quicksave manipulation is possible because the game doesn't save the floor RNG at 0203B458, and sets it to 1 when you start the game. But there's an alternative: at the start of a dungeon, a "dungeon seed" is created (using the per-frame RNG, 0203B07C), and recorded at 02004170, which is used to make the floor layouts of player rescue missions identical to the floor layouts the player was defeated in. 
While the floor RNG is not saved, the dungeon seed IS. My code takes the dungeon seed and recreates the RNG for the current floor by throwing it through the algorithm a number of times equal to the current floor the player is on.
Make sure to relocate my code if the area it's in is too inconvenient or already taken.
*/
.gba
.open "RRT.gba","RRT_P.gba",08000000h


.org 08081C66h
	bl @SeedPreserver

.org 08273CD0h	;<<<<<<<<<<<<RELOCATE THIS IF NEEDED
@SeedPreserver:
	push r14
	bl 08082FE0h		;when resuming a quicksave, this loads a bunch of data into ram
	push r0-r4		;replaced its jump at 81C66 with a jump to my code
	ldr r0,=02004170h	;dungeon's seed
	ldr r0,[r0]
	ldr r4,=02004139h	;current floor
	ldrb r4,[r4]
	bl 0808408Ch		;This function stores r0 to 0203B458. It uses r1 and r2 without pushing them.
notyet:
	bl 080840A4h		;This function puts the seed through its algorithm. Uses r0-r3
	sub r4,r4,1h
	cmp r4,0h
	beq itsdone
	b notyet
itsdone:
	pop r0-r4
	pop r15
.pool

.close
