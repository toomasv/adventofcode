Red []
;input: "dabAcCaCBAcCcaDA"
input: read %Day5.input
if newline = last input [remove back tail input]
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

length? head input