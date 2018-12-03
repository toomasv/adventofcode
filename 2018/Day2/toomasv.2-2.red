Red []
input: read/lines %day2.input
;input: ["abcde" "fghij" "klmno" "pqrst" "fguij" "axcye" "wvxyz"]

seek: func [input] [
	while [
		probe id: take head input
	][
		forall input [
			cnt: 0
			repeat i length? id [
				if (ch: id/:i) <> probe input/1/:i [
					if 1 < cnt: cnt + 1 [break]
				]
			]
			if cnt = 1 [return probe reduce [id input/1 ch]]
		]
	]
]
match: seek input
head remove find match/1 match/3
