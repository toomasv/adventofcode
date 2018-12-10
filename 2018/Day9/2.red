Red [Day: 9 Part: 2 Problem: "Hangs for part 2 (7179000) but works for part 1 (71790)"]
players: 459
final: 7179000
scores: make map! repeat i players [append [] reduce [i 0]]
circle: make vector! final
append circle 0
repeat marble final [
	either 0 = (marble % 23) [
		player: marble - 1 % players + 1
		circle: either 8 > i: index? circle [
			skip tail circle i - 9 
		][
			skip circle -8
		]
		scores/:player: scores/:player + marble + take circle
		circle: next circle
	][
		circle: insert either tail? circle [
			next head circle
		][
			next circle
		] marble
	]
]
probe first sort/reverse values-of scores
