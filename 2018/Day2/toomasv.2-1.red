Red []
input: read/lines %day2.input
;input: ["abcdef" "bababc" "abbcde" "abcccd" "aabcdd" "abcdee" "ababab"]
count: func [str char /local cnt][
	cnt: 0 
	while [str: find/tail str char][cnt: cnt + 1] 
	cnt
]
twos: 0
threes: 0
forall input [
	str: input/1
	done2: done3: no
	while [char: take str][
		if 0 < cnt: count str char [ 
			switch cnt [
				1 [unless done2 [twos: twos + 1 done2: yes]]
				2 [unless done3 [threes: threes + 1 done3: yes]]
			]
			replace str char ""
		]
	]
]
print [twos threes twos * threes]
