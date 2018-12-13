Red []

tracks: read/lines %input
dir: copy []
turn: copy []
collision: no

cart: charset "<>^^v"
carts: collect [
	repeat row length? tracks [
		parse tracks/:row [some [s:
			set c cart (keep as-pair index? s row append dir c append turn 0)
		|	skip
		]]
	]
]
mark: copy dir
forall mark [mark/1: switch mark/1 [#"<" #">" [#"-"] #"^^" #"v" [#"|"]]]
tick: 0
until [
	tick: tick + 1
	forall carts [
		cart: index? carts
		pos: carts/1
		next-pos: switch dir/:cart [
			#"^^" [pos - 0x1]
			#"v" [pos + 0x1]
			#"<" [pos - 1x0]
			#">" [pos + 1x0]
		]
		either find head carts next-pos [
			collision: yes break
		][
			row: next-pos/y col: next-pos/x
			cur-dir: dir/:cart
			
			switch next-mark: tracks/:row/:col [
				#"/" [dir/:cart: switch dir/:cart [#"^^" [#">"] #"v" [#"<"] #"<" [#"v"] #">" [#"^^"]]]
				#"\" [dir/:cart: switch dir/:cart [#"^^" [#"<"] #"v" [#">"] #"<" [#"^^"] #">" [#"v"]]]
				#"+" [
					switch turn/:cart [
						0 [dir/:cart: switch dir/:cart [#"^^" [#"<"] #"v" [#">"] #"<" [#"v"] #">" [#"^^"]]]
						2 [dir/:cart: switch dir/:cart [#"^^" [#">"] #"v" [#"<"] #"<" [#"^^"] #">" [#"v"]]]
					]
					turn/:cart: turn/:cart + 1 % 3
				]
			]
			tracks/(pos/y)/(pos/x): mark/:cart
			mark/:cart: next-mark
			tracks/:row/:col: dir/:cart
			carts/1: next-pos
		]
	]
	collision 
]
res: next-pos - 1
print [tick rejoin [res/x comma res/2]]