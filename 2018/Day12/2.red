Red [Comment: {Solution idea not mine.}]
input: read %input
remove back tail rule: parse input [
	thru ": " copy initial to newline 2 skip
	collect some [
		keep copy r 5 skip   4 skip   set pot skip  
		keep (to-paren compose [change at gen (quote (2 + index? s)) (pot)]) keep ('|) newline
	]
]
rule: compose/deep/only [
	ahead (rule) 
| 	if (quote (2 <= length? s)) (quote (change at gen (2 + index? s) #".")) 
| 	none
]
rule: compose/deep/only [some [s: (rule) skip]]

len: 2 + length? initial
insert/dup initial #"." 50
append/dup initial #"." 50
gen: copy initial
found: no

res: 0 
repeat j 150 [
	parse initial rule 

	res: 0 
	forall gen [
		if gen/1 = #"#" [
			res: either 52 > i: (index? gen) [res - (51 - i)][res + i - 51]
		]
	]
	diff: res - res0
	res0: res
	append clear initial gen
]
50'000'000'000 - 150 * diff + res