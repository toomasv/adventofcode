Red []

tracks: read/lines %input;%test;
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
	carts: head carts
	tack: 0
	until [
		tack: tack + 1
		cart: index? carts
		pos: carts/1
		next-pos: switch dir/:cart [ 
			#"^^" [pos - 0x1]
			#"v" [pos + 0x1]
			#"<" [pos - 1x0]
			#">" [pos + 1x0]
		]
		row: next-pos/y col: next-pos/x
		either found: find head carts next-pos [
			coll: index? found
			tracks/:row/:col: #"X"
			tracks/(pos/y)/(pos/x): mark/:cart
			;if 3 = length? head carts [
			;	print ["Collision at:" next-pos] 
			;	tr: copy/deep tracks
			;	forall tr [print tr/1]
			;]
			tracks/:row/:col: mark/:coll
			_min: min cart coll
			_max: max cart coll
			foreach register reduce [carts dir turn mark][
				remove at head register _max 
				remove at head register _min
			]
			if 1 = length? head carts [break]
			cart: cart - 1
		][
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
			cart: cart + 1
		]
		carts: at head carts cart
		tail? carts
	]
	1 = length? head carts
]
res: (first head carts) - 1
print [tick rejoin [res/x comma res/y]]