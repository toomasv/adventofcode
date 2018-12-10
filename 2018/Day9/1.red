Red [Day: 9 Part: 1]
do %ring.red ; Using my gist https://gist.github.com/toomasv/6a530ebc8cbb48a273d1cc449d8f204d
circle: ring [0]
players: 459
final: 71790
scores: make map! repeat i players [append [] reduce [i 0]]
repeat marble final [
	either 0 = (marble % 23) [
		player: marble - 1 % players + 1
		scores/:player: scores/:player + marble + take circle/skip -7
	][
		insert circle/skip 2 marble
	]
]
first sort/reverse values-of scores