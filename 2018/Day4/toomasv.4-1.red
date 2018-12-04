Red []
input: load %day4.input
comment {
input: load {[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
}
}

guards: make map! 3000
data: parse input [
	collect some [
		ahead block! into [keep date! keep time!] 
	| 	keep [issue! | 'wakes | 'asleep] 
	| 	skip
	]
]

sort/skip/compare/all data 3 func [a b][any [a/1 < b/1 all [a/1 = b/1 a/2 < b/2]]]

parse data [some [
	date! time! set w issue! (
		w: to-integer to-string w 
		unless guards/:w [guards/:w: make map! 60]
	) 
 	any [date! set t1 time! 'asleep date! set t2 time! 'wakes (
		t1: t1/2 t2: t2/2
		while [t1 < t2][
			either guards/:w/:t1 [
				guards/:w/:t1: guards/:w/:t1 + 1
			][
				guards/:w/:t1: 1
			]
			t1: t1 + 1
		]
	)]
]] 

res: sort/skip/all/compare collect [foreach [id mins] body-of guards [
	keep id 
	m: body-of mins 
	keep sum extract/index m 2 2 
	sort/skip/all/compare m 2 func [a b][a/2 > b/2] 
	keep either m/1 [m/1][0] 
	keep either m/2 [m/2][0]
]] 4 func [a b][a/2 > b/2]

print [copy/part res 4 res/1 * res/3]
