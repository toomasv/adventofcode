Red []
system/lexer/pre-load: func [src part][
	digit: charset "0123456789"
	int: [some digit]
	parse src [some [change ["@ " copy x int comma copy y int ":"] (as-pair to-integer x to-integer y) | skip]]
]
input: load %day3.input
;input: load "#1 @ 1,3: 4x4^/#2 @ 3,1: 4x4^/#3 @ 5,5: 2x2"

overlap: func [a b c d][e: max a c f: (min a + b c + d) - e reduce [e f]]

overlaps1: collect [
	while [box: take/part input 3] [
		foreach [id start size] input [
			over: overlap box/2 box/3 start size
			if all [over/2/1 > 0 over/2/2 > 0][
				keep (over)
			]
		]
	]
]

largest: 0x0
boxes: parse overlaps1 [
	collect some [
		keep ('box)
		keep set start pair!
		set size pair! 
		keep (end: start + size)
		(largest: max largest end)
	]
]
;view/tight compose/deep [box (largest + 1) draw [(boxes)]]
img: draw largest + 1 compose [anti-alias off pen off fill-pen black (boxes)]
;view/tight [image img]
cnt: 0
forall img [if img/1 = black [cnt: cnt + 1]]
probe cnt
;}