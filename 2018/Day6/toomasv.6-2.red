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

locs: copy []
cnt: 0
repeat y end/y + 1 [
	repeat x end/y + 1 [
		loc: as-pair (x - 1) (y - 1)
		collect/into [
			forall input [
				d: distance loc input/1
				keep d
			]
		] clear locs
		if 10000 > sum locs [cnt: cnt + 1]
	]
]
cnt
