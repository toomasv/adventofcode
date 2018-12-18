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
loop 10 [
	repeat row length? lines [
		parse lines/:row [
			some [s: (col: index? s)
				#"." (new/:row/:col: either 3 <= count row col #"|" [#"|"][#"."])
			|	#"|" (new/:row/:col: either 3 <= count row col #"#" [#"#"][#"|"])
			|	#"#" (new/:row/:col: either all [1 <= count row col #"#" 1 <= count row col #"|"] [#"#"][#"."])
			]
		]
	]
	lines: copy/deep new
]
resource: charset "#|"
cnt1: 0
cnt2: 0
foreach line lines [
	print line
	foreach char line [switch char [#"#" [cnt1: cnt1 + 1] #"|" [cnt2: cnt2 + 1]]]
]
print cnt1 * cnt2