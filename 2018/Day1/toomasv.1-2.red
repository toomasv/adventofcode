Red []
input: load %day1.input 
nums: make hash! [0] 
sum: 0 
until [
	res: no input: head input forall input [
		either found: find nums sum: sum + input/1 [
			res: found/1 break
		][
			append nums sum
		]
	] 
	res
]
