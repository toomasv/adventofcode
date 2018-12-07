Red [Task: {In what order should the steps in your instructions be completed?
If more than one step is ready, choose the step which is first alphabetically.}]

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
state: sort exclude pre post
; Check conditions for step
until [
	foreach [step cond] head conds [
		;print [mold step mold cond mold state]
		if empty? exclude cond state [
			;prin "yes "
			append state probe step 
			remove/part find/skip conds step 2 2
			break
		]
	]
	tail? conds
]
print [mold conds mold state]
trim/all form state
;FHICMRTXYDBOAJNPWQGVZUEKLS
