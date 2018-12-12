Red [Comment: {Solution idea not mine.}]
input: read %input
remove back tail rule: parse input [
	thru ": " copy row to newline 2 skip
	collect some [
		keep copy r 5 skip   4 skip   set pot skip  
		keep (to-paren compose [change at new-row (quote (2 + index? s)) (pot)]) keep ('|) newline
	]
]
rule: compose/deep/only [some [s: [
	ahead (rule) 
|   if (quote (2 <= length? s)) (quote (change at new-row (2 + index? s) #".")) 
|   none
] skip]]

insert/dup row #"." 10
append/dup row #"." 10
new-row: copy row

result0: 0 
repeat j 150 [
	parse row rule 

	result: 0 
	forall new-row [
		if new-row/1 = #"#" [
			result: result - 11 + index? new-row 
		]
	]
	diff: result - result0
	result0: result
	append clear row new-row
]
50'000'000'000 - 150 * diff + result