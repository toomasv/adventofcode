Red [
	Author: "Toomas Vooglaid"
	Date: 2017-12-12
]
set 'ring function [ser [series!]][
	context [
		series: ser
		circle: function [/at aval /skip sval /next /back /part pval][
			case/all [
				at [
					case [
						aval > 0 [
							val: (aval - 1) % (length? series) + 1 
							move/part series tail series val - 1
						]
						aval < 0 [
							val: aval % (length? series) 
							move/part system/words/skip tail series val head series absolute val
						]
					]
				]
				skip [circle/at either sval > 0 [sval + 1][sval]]
				next [circle/at 2]
				back [circle/at -1]
				part [
					either pval >= 0 [
						either pval > len: length? series [
							out: make (type? series) copy []
							append/dup out series pval / len
							append out copy/part series pval % len
							return out
						][
							return copy/part series pval
						]
					][
						either (pv: absolute pval) > len: length? series [
							out: make (type? series) copy []
							append/dup out series pv / len
							insert out copy/part system/words/skip tail series l: pval % len absolute l
							return out
						][
							return copy/part system/words/skip tail series pval absolute pval
						]
					]
				]
			]
			series
		]
		return :circle
	]
]
