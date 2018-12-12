Red []
grid: 2694;42;18;
res: 0
repeat ser 298 * 298 [
	x0: ser - 1 % 298 + 1
	y0: ser / 298 + 1
	res0: 0
	repeat y1 3 [
		repeat x1 3 [
			x: x0 + x1 - 1
			y: y0 + y1 - 1
			id: x + 10
			pwr: form id * y + grid * id
			either 2 < length? pwr [n: to-integer take skip tail pwr -3][n: 0]
			n: n - 5
			res0: res0 + n
		]
	]
	if res0 > res [res: res0 coord: as-pair x0 y0]
]
rejoin [coord/x comma coord/y]