Red [Day: 8 Part: 1
	Task: {
		What is the sum of all metadata entries?
		Node consists of:
		*	A header, which is always exactly two numbers:
		*	The quantity of child nodes.
		*	The quantity of metadata entries.
		Zero or more child nodes (as specified in the header).
		One or more metadata entries (as specified in the header).
	}
]
elements: bind [
	set child skip set meta skip (insert metas: [] meta) 
	child elements (meta: take metas) meta [keep skip]
] :collect 
sum res: parse load %input [collect elements]