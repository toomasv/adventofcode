Red []
system/lexer/pre-load: func [src part][
	parse src [some [
		change "pos=<" #"[" 
	| 	change #"," #" " 
	| 	change #">" #"]" 
	| 	remove "r=" 
	| 	skip
	]]
]
data: load %input
system/lexer/pre-load: none
max-data: copy [0 0] 
i: 0 
foreach [_ bot] data [
	i: i + 1 
	if bot > max-data/2 [
		max-data/1: i * 2 - 1 
		max-data/2: bot
	]
]
max-pos: copy first at data max-data/1
max-bot: max-data/2
count: 0
foreach [pos bot] data [
	distance: 0
	forall pos [distance: distance + absolute max-pos/(index? pos) - pos/1]
	if max-bot >= distance [count: count + 1]
]
print count