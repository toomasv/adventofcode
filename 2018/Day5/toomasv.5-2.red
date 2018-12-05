Red []
;initial: "dabAcCaCBAcCcaDA"
initial: read %Day5.input
if newline = last initial [remove back tail initial]
input: make string! 50000
;probe alphabet: unique lowercase copy initial
alphabet: make string! 30
alpha: charset [#"a" - #"z"]
repeat i length? alpha [if alpha/:i [append alphabet to-char i]]
lens: make block! length? alphabet 
foreach lower alphabet [
	upper: uppercase lower
	input: append clear head input initial
	replace/all input [lower | upper] ""
	while [1 < length? input][
		either all [
			equal? lowercase input/1 lowercase input/2 
			input/1 <> input/2
		][
			remove/part input 2 
			input: skip input -2
		][
			input: next input
		]
	]
	append lens length? head input
]
first probe sort lens