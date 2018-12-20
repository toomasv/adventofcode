    Red []
    pos: 0x0
    saved: copy []
    walls: copy []
    moves: copy []
    verts: copy []
    horis: copy []
    parse read %input [
        some [
            [#"^^" | #"$"]
        |   #"E" (append verts pos + 1x0 append moves pos: pos + 2x0 repend walls [pos + 1x-1 pos + 1x1])
        |   #"N" (append horis pos + 0x-1 append moves pos: pos - 0x2 repend walls [pos + -1x-1 pos + 1x-1])
        |   #"W" (append verts pos + -1x0 append moves pos: pos - 2x0 repend walls [pos + -1x-1 pos + -1x1])
        |   #"S" (append horis pos + 0x1 append moves pos: pos + 0x2 repend walls [pos + -1x1 pos + 1x1])
        |   #"(" (insert saved pos)
        |   #"|" (pos: first saved)
        |   #")" (pos: take saved)
        ]
    ]
    up-left: 0x0
    forall walls [up-left: min up-left walls/1]
    up-left: up-left - 1x1
    forall walls [walls/1: walls/1 - up-left]
    forall verts [verts/1: verts/1 - up-left]
    forall horis [horis/1: horis/1 - up-left]
    forall moves [moves/1: moves/1 - up-left]
    down-right: 0x0
    forall walls [down-right: max down-right walls/1]
    pos: start: 0x0 - up-left
    plan: draw down-right compose [fill-pen gray box 0x0 (down-right)]

    forall verts [poke plan verts/1 255.255.255.0]
    forall horis [poke plan horis/1 255.255.255.0]
    forall moves [poke plan moves/1 255.255.255.0]
    poke plan start 255.0.0.0

    get-steps: function [pos][collect [
        foreach dir [1x0 0x1 -1x0 0x-1][
            if 255.255.255.0 = pick plan pos + dir [keep pos keep dir]
        ]
    ]]
    step: func [p d][
        poke plan p blue 
        poke plan p + d blue 
        poke plan pos: 2 * d + p red 
        count: count + 1 
        if count >= 1000 [cnt-1000: cnt-1000 + 1]
    ]
    count: 0
    ends: copy []
    moves: copy []
    cnt-1000: 0
    view compose/deep [
        maze: box (2 * down-right) 
        draw [scale 2 2 [image (plan)]]
		rate 64
        on-time [
            steps: get-steps pos
            switch/default length? steps [ 
                0 [
                    repend ends [pos count] 
                    poke plan pos leaf 
                    either empty? moves [
                        face/rate: none
                        btn/text: "Finished"
                        sort/skip/compare ends 2 2
                        poke plan first skip tail ends -2 red
                        poke plan start red
                        view [
                            text 50 "Part 1:" field with [data: last ends] return 
                            text 50 "Part 2:" field with [data: cnt-1000]
                        ]
                    ][
                        set [p d] take/part first moves 2
                        count: last first moves
                        if 1 = length? first moves [remove moves]
                        step p d
                    ]
                ]
                2 [set [p d] steps step p d]
            ][
                set [p d] take/part steps 2
                insert/only moves append steps count
                step p d
            ]
        ]
    ]
