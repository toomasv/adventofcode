Red []
input: 793031
number-of: :length?
recipes: [3 7]
e1: recipes
e2: next recipes
go: func [e][loop e/1 + 1 [e: next e if 0 = length? e [e: head e]] e]
add-recipes: func [/local n][
	;append recipes either 9 < n: e1/1 + e2/1 [reduce [1 n % 10]][n]
	foreach n to-string (e1/1 + e2/1) [
		append recipes to-integer n - 48
	]
]
until [
	add-recipes
	e1: go e1 e2: go e2
	input + 10 <= number-of recipes
]
rejoin copy/part at head recipes input + 1 10