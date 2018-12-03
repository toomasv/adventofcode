Red []
system/lexer/pre-load: func [src part][
	digit: charset "0123456789"
	int: [some digit]
	parse src [some [change ["@ " copy x int comma copy y int ":"] (as-pair to-integer x to-integer y) | skip]]
]
input: load %day3.input
;input: load "#1 @ 1,3: 4x4^/#2 @ 3,1: 4x4^/#3 @ 5,5: 2x2"

overlap: func [a b c d][e: max a c f: (min a + b c + d) - e reduce [e f]]

ids: copy []

overlaps: collect [
	while [box: take/part input 3] [
		append ids box/1
		foreach [id start size] input [
			over: overlap box/2 box/3 start size
			if all [over/2/1 > 0 over/2/2 > 0][
				keep (box/1)
				keep (id)
			]
		]
	]
]

probe exclude ids unique overlaps
