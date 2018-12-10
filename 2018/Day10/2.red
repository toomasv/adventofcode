Red [Day: 10 Task: "Digital detection"]
data: parse read %input [collect some [
	["position=<" | " velocity=<"] opt space 
	copy x to "," skip some space copy y to #">" 
	keep (as-pair load x load y) skip 
| 	newline
]]

positions: extract data 2
movements: extract/index data 2 2
steps: 0
size: size1: 1000000x1000000
add-move: func [dir][
	steps: steps + dir
	end: 0x0
	repeat i length? movements [
		end: max end positions/:i: movements/:i * dir + positions/:i
		start: either i = 1 [positions/1][min start positions/:i]
		end - start
	]
]
add-move 10000
until [
	size: size1
	size1: add-move 1
	size < size1
]
steps - 1