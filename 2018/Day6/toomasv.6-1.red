Red []
; Normalize
system/lexer/pre-load: func [src _][replace/all src ", " "x"]
input: load %Day6.input

comment {
input: load {1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
}
}

; Bounding box
end: 0x0 
forall input [end: max end input/1]

; Collect coords with infinite areas (don't need to look at these)
pair-sum: func [pair][pair/1 + pair/2]
distance: func [loc1 loc2][pair-sum absolute loc1 - loc2]

infinite: make map! 100
res: make map! 100
locs: copy []

repeat y end/y + 1 [
	repeat x end/y + 1 [
		loc: as-pair (x - 1) (y - 1)
		collect/into [
			forall input [
				d: distance loc input/1
				keep d keep input/1
			]
		] clear locs
		sort/skip locs 2
		if locs/1 < locs/3 [
			either any [loc/x = 0 loc/y = 0 loc/x = end/x loc/y = end/y][
				infinite/(locs/2): true
			][
				if not infinite/(locs/2) [
					either not cnt: res/(locs/2) [res/(locs/2): 1][res/(locs/2): cnt + 1]
				]
			]
		]
	]
]
foreach key keys-of infinite [res/(key): none]
sort/reverse/skip body-of res 2
