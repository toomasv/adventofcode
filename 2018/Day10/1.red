Red [Day: 10 Part: "1 and 2 Visual detection" Comment: {Slow down around 10700. Stop and move manually after 10900}]
data: parse read %input [collect some [
	["position=<" | " velocity=<"] opt space 
	copy x to "," skip some space copy y to #">" 
	keep (as-pair load x load y) skip 
| 	newline
]]

positions: extract data 2
movements: extract/index data 2 2
circles: make block! length? positions
start: positions/1
end: 0x0
forall positions [
	start: min start positions/1
	end: max end positions/1
	append/only circles reduce ['circle positions/1 .9]
]
size: end - start / 100
tick: 0
system/view/auto-sync?: off
circs: none
add-move: func [dir][
	repeat i length? movements [
		circs/:i/2: movements/:i * dir + circs/:i/2
	]
]
view lay: layout compose/deep/only [
	title "AoC Day 10"
	at 5x5 t: text "" at 50x5 ctr: button "Stop" [lights/rate: none]
	at 130x5 button "<" 20 [lights/rate: none add-move -1 t/text: to-string tick: tick - 1 show [lights t]]
	at 160x5 button ">" 20 [lights/rate: none add-move 1 t/text: to-string tick: tick + 1 show [lights t]]
	at 190x5 slider 80 data 100% [lights/rate: 1 + to-integer face/data * 60]
	lights: box (size) draw [fill-pen red pen off [translate 0x0 (circles)]]
	rate 60 extra 20
	on-time [
		t/text: to-string tick: tick + 20
		add-move face/extra
		show face show t
	]
	do [circs: lights/draw/5/3]
]

