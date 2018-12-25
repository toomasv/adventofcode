Red []
depth: 5355
target: 14x796 + 1
data: copy []
risk: 0
repeat y target/y [
	repeat x target/x [
		append data as-pair x y
		append data gi: case [
			any [all [x = 1 y = 1] all [x = target/x y = target/y]][0]
			y = 1 [x - 1 * 16807 * 1.0]
			x = 1 [y - 1 * 48271 * 1.0]
			'else [(first skip tail data -2) * (first skip tail data negate 3 * target/x - 1) * 1.0]
		]
		append data el: gi + depth % 20183
		type: to-integer el % 3
		risk: risk + pick [0 1 2] type + 1
	]
]
print risk


