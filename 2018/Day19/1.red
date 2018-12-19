Red []
register: [0 0 0 0 0 0]
instructions: remove load %input; %test ;
ip*: take instructions
len: (length? instructions) / 4
ip: register/(ip* + 1)
ops: [
	addr [register/(C + 1): register/(A + 1) + register/(B + 1)]
	addi [register/(C + 1): register/(A + 1) + B]
	mulr [register/(C + 1): register/(A + 1) * register/(B + 1)]
	muli [register/(C + 1): register/(A + 1) * B]
	banr [register/(C + 1): register/(A + 1) and register/(B + 1)]
	bani [register/(C + 1): register/(A + 1) and B]
	borr [register/(C + 1): register/(A + 1) or register/(B + 1)]
	bori [register/(C + 1): register/(A + 1) or B]
	setr [register/(C + 1): register/(A + 1)]
	seti [register/(C + 1): A]
	gtir [register/(C + 1): make integer! A > register/(B + 1)]
	gtri [register/(C + 1): make integer! register/(A + 1) > B]
	gtrr [register/(C + 1): make integer! register/(A + 1) > register/(B + 1)]
	eqir [register/(C + 1): make integer! A = register/(B + 1)]
	eqri [register/(C + 1): make integer! register/(A + 1) = B]
	eqrr [register/(C + 1): make integer! register/(A + 1) = register/(B + 1)]
]

while [ip < len][
;loop 5 [
	;prin ["ip =" ip]
	register/(ip* + 1): ip
	;prin [" " mold register]
	instr: skip instructions ip * 4
	;op: instr/1
	set [op A B C] instr ;copy/part next instr 3
	;prin [" " op A B C]
	do ops/:op
	;print [" " mold register]
	ip: register/(ip* + 1) + 1
]
print register/1