Red []
;;;; Part 1
input: replace/all read %input comma ""
ops: [
	addr [before/(C + 1): before/(A + 1) + before/(B + 1)]
	addi [before/(C + 1): before/(A + 1) + B]
	mulr [before/(C + 1): before/(A + 1) * before/(B + 1)]
	muli [before/(C + 1): before/(A + 1) * B]
	banr [before/(C + 1): before/(A + 1) and before/(B + 1)]
	bani [before/(C + 1): before/(A + 1) and B]
	borr [before/(C + 1): before/(A + 1) or before/(B + 1)]
	bori [before/(C + 1): before/(A + 1) or B]
	setr [before/(C + 1): before/(A + 1)]
	seti [before/(C + 1): A]
	gtir [before/(C + 1): make integer! A > before/(B + 1)]
	gtri [before/(C + 1): make integer! before/(A + 1) > B]
	gtrr [before/(C + 1): make integer! before/(A + 1) > before/(B + 1)]
	eqir [before/(C + 1): make integer! A = before/(B + 1)]
	eqri [before/(C + 1): make integer! before/(A + 1) = B]
	eqrr [before/(C + 1): make integer! before/(A + 1) = before/(B + 1)]
]
op-nums: repeat i 16 [append [] i - 1]
foreach [op _] ops [set op copy op-nums]

count0: 0
cycle: 0
parse input [some [
	copy before thru newline (do before)
	copy instruction thru newline (set [op* A B C] load instruction)
	copy after thru 2 newline (do after)
	(	
		count: 0
		_C: before/(C + 1)
		foreach [op code] ops [
			do code 
			either after = before [count: count + 1][remove find get op op*]
			before/(C + 1): _C
		]
		count0: count0 + make integer! count >= 3
	)
]]
print ["Part 1:" count0]

;;;; Part 2
op-list: foreach [op _] ops [append [] op]
sort/compare op-list func [a b][(length? get a) < (length? get b)]
forall op-list [
	sort/compare either 1 = length? get op-list/1 [next op-list][op-list] 
		func [a b][(length? get a) < (length? get b)]
	foreach op next op-list [remove find get op first get op-list/1]
]
oper: make map! 16
foreach op op-list [oper/(first get op): select ops op]
before: [0 0 0 0]
foreach [op A B C] load %tests [do oper/:op]
print ["Part 2:" before/1]
