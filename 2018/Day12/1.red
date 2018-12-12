Red []
input: read %input
remove back tail rule: parse input [
	thru ": " copy initial to newline 2 skip
	collect some [
		keep 5 skip   4 skip   set pot skip  
		keep (to-paren compose [change at gen (quote (2 + index? s)) (pot)]) keep ('|) newline
	]
]
rule: compose/deep/only [some [s:[
	ahead (rule) 
| 	if (quote (2 <= length? s)) (quote (change at gen (2 + index? s) #".")) 
| 	none
] skip]]

len: 2 + length? initial
insert/dup initial #"." 10
append/dup initial #"." 10
gen: copy initial

loop 20 [parse initial rule append clear initial gen]

res: 0 
forall gen [
	if gen/1 = #"#" [
		res: either 12 > i: (index? gen) [res - (11 - i)][res + i - 11]
	]
]
res