Red []
lines: read/lines %input
new: copy/deep lines
count: func [row col mark /local acc r0 c0 r c][
	acc: 0 c0: col - 2 r0: row - 2
	repeat r 3 [
		repeat c 3 [
			if all [
				(as-pair c0 + c r0 + r) <> as-pair col row
				attempt [lines/(r0 + r)/(c0 + c) = mark]
			][acc: acc + 1]
		]
	]
	acc
]
scores: make block! 600
res: make block! 6
stop?: no
i: rpt: val: 0
until [
	i: i + 1
	repeat row length? lines [
		parse lines/:row [
			some [s: (col: index? s)
				#"." (new/:row/:col: either 3 <= count row col #"|" [#"|"][#"."])
			|	#"|" (new/:row/:col: either 3 <= count row col #"#" [#"#"][#"|"])
			|	#"#" (new/:row/:col: either all [1 <= count row col #"#" 1 <= count row col #"|"] [#"#"][#"."])
			]
		]
	]
	forall lines  [insert clear lines/1 new/(index? lines)]
	cnt1: 0
	cnt2: 0
	foreach line lines [
		foreach char line [switch char [#"#" [cnt1: cnt1 + 1] #"|" [cnt2: cnt2 + 1]]]
	]
	cnt: cnt1 * cnt2 
	if found: find scores cnt [
		either i - (index? found) = val  [
			rpt: rpt + 1 
			append res reduce [i i - (index? found) cnt]
			case [
				rpt = 3 [countdown: 1000000000 - (res/1 - res/2) % res/2 - 2]
				rpt > 3 [countdown: countdown - 1 if countdown = 0 [stop?: yes]]
			]
		][
			val: i - (index? found)
		]
	]
	append scores cnt
	stop?
]
last res