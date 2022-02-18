/*
The infinite money glitch is performed with the following steps:
-Find a kekcleon shop in a dungeon
-Place an item on a shop tile
-Quicksave the game
-Load the game
-Exit the shop, sell your item, go back to the shop, repeat
The first time you sell your items, Kecleon will give you two times the money your items are worth, and give you the price your items were worth every time you leave the shop afterwards. This is due to multiple accidents in the code: 
When you place an item in kecleon's shop, the price of the item is immediately added to 02004184. When you leave Kecleon's shop, the game calls the function 0807EFFC: this function does nothing if 02004184 is zero, but if it's not zero, Kecleon will buy your items for the amount 02004184 is at, and after you accept, the game looks through all of the shop tiles; upon finding an item you placed, the function marks it as a shop item, and subtacts 02004184 by its cost.
When quicksave data is loaded, the game runs 08082060: I'm not entirely sure what it does, but it appears to cycle through items in the shop (or tiles in the entire dungeon?), and during this process, when it finds an item on a shop tile which doesn't belong to kecleon, its price is added to 02004184. 02004184 is now double what it's supposed to be, and can be incremented further every time you quicksave and resume. You can see where this is going.
The first time you leave the shop, Kecleon gives you money equal to 02004184, and the number is decreased by the cost of your shop items, before they're sold. The second time, Kecleon gives you 02004184, and 02004184 is never reduced, as you don't have any items left to sell. 

This code fixes the bug by zeroing 02004184 before 08082060 is called. Make sure to relocate my code if the area it's in is too inconvenient or already taken.
*/


.gba
.open "RRT.gba","RRT_P.gba",08000000h


.org 08081C28h
	bl @stopyouviolatedthelaw

.org 08273930h	;<<<<<<<<<<<<<RELOCATE THIS IF NEEDED
@stopyouviolatedthelaw:
	push r0-r1,r14
	ldr r0,=02004184h
	mov r1,0h
	str r1,[r0]
	pop r0-r1
	bl 08082060h
	pop r15
.pool

.close
