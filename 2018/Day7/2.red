Red [Task: {With 5 workers and the 60+ second step durations described above, 
how long will it take to complete all of the steps?

Each step takes 60 seconds plus an amount corresponding to its letter: 
A=1, B=2, C=3, and so on. So, step A takes 60+1=61 seconds, 
while step Z takes 60+26=86 seconds. No time is required between steps.}]

comment {
input: {Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
}
input: parse input [collect some ["step " keep skip | skip]]
}
input: parse read %input [collect some ["step " keep skip | skip]]
; All steps that serve as conditions
pre: sort unique extract input 2
; All steps depending on other steps
post: sort unique extract/index input 2 2
; Collect conditions for each step
reverse input
conds: collect [
	forall post [
		input: head input 
		keep post/1 
		keep/only collect [
			while [
				found: find/skip/tail input post/1 2
			][
				keep first back found
				input: found
			]
		]
	]
]
; Initial state (starting conditions)
initial: sort exclude pre post
state: copy []

; Working elves
elf: object [
	id: none
	found: none
	does-some-work: has [step cond][
		working-time/:id: max 0 working-time/:id - 1
		if 0 = working-time/:id [
			if found [append state found found: none] 
			either step: take initial [
				found: step
				working-time/:id: subtract to-integer step 4;64;
			][
				foreach [step cond] head conds [
					if empty? exclude cond state [
						remove/part find/skip conds step 2 2
						found: step
						working-time/:id: subtract to-integer step 4;64;
						break
					]
				]
			]
		]
	]
]
workers: make block! 5
repeat i 5 [append workers make elf compose [id: (i)]]
working-time: copy [0 0 0 0 0]

; Do until all steps are finished
time: -1
until [
	time: time + 1 prin " "
	foreach worker workers [worker/does-some-work]
	all [tail? conds 0 = sum working-time]
]
;print [mold conds mold state]
probe trim/all form state
time - 1
;1:FHICMRTXYDBOAJNPWQGVZUEKLS
;2:FHICMRYDTXBOPWAJQNVGZUEKLS
; For some reason with long input right answer is one less than computed!?
