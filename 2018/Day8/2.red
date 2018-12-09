Red [Day: 8 Part: 2
	Task: {What is the value of the root node?
	If a node has no child nodes, its value is the sum of its metadata entries.
	If a node does have child nodes, the metadata entries become indexes which refer to those child nodes.
	The value of this node is the sum of the values of the child nodes referenced by the metadata entries. If a referenced child node does not exist, that reference is skipped. A child node can be referenced multiple time and counts each time it is referenced. A metadata entry of 0 does not refer to any child node.}
]
metas: copy []
get-data: [(set [child meta] take/part metas 2) copy m meta skip]
res: parse load %input elements: [
	set child skip set meta skip (insert metas reduce [child meta])
	collect [
		if (child > 0) child elements [get-data keep (m)]
	|   get-data keep (sum m)
	]
]
solve: func [el] bind [
	metas: last el
	foreach m metas [
		if m < length? el [
			all [
				el/:m
				any [
					all [1 = length? el/:m keep el/:m/1]
					solve el/:m
				]
			]
		]
	]
] :collect
sum collect [solve res]
; [2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2]
