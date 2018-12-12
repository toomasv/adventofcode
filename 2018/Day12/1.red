Red []
input: read %input
remove back tail rule: parse input [
	thru ": " copy row to newline 2 skip
	collect some [
		keep 5 skip   4 skip   set pot skip  
		keep (to-paren compose [change at new-row (quote (2 + index? s)) (pot)]) keep ('|) newline
	]
]
rule: compose/deep/only [some [s:[
	ahead (rule) 
|   if (quote (2 <= length? s)) (quote (change at new-row (2 + index? s) #".")) 
|   none
] skip]]

insert/dup row #"." 10
append/dup row #"." 10
new-row: copy row

loop 20 [parse row rule append clear row new-row]

result: 0 
forall new-row [
	if new-row/1 = #"#" [
		result: result: result - 11 + index? new-row 
	]
]
result