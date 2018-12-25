Red []
comp-table: func [list fn /local acc rest group i][
	i: 0
	acc: make block! append/dup [] 0 length? list
	forall list [
		if 0 = group: acc/(index? list) [acc/(index? list): group: i: i + 1]
		rest: next list
		;print [index? list group mold rest mold acc]
		if 0 < l: length? rest [
			forall rest [
				if fn list/1 rest/1 [
					ilist: index? list irest: index? rest
					either (grest: acc/:irest) > 0 [
						unless grest = group [
							either grest < group [
								replace/all acc group grest
								group: grest
							][
								replace/all acc grest group
							]
						]
					][
						acc/:irest: group
					]
				]
			]
		]
	]
	acc
]
system/lexer/pre-load: func [src part][replace/all src comma space]
data: collect [foreach line read/lines %input [keep/only load line]]
if empty? last data [remove back tail data]
comp: func [a b /local s][
	s: 0
	forall a [s: s + absolute a/1 - b/(index? a)] 
	s <= 3
]
length? unique comp-table data :comp