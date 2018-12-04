Red []
; continue from Day4-1

sort/skip/all/compare res 4 func [a b][a/4 > b/4]
print [copy/part res 4 res/1 * res/3]
