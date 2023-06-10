::  water-towers.hoon
|=  towers=(list @ud)
=<
(roll (turn (list-max-heights towers) fill-tower) add)
|%
::
::  Calculates how much water to fill a tower with by looking at the heights to its left and right
++  fill-tower
|=  input=[[maxleft=@ud maxright=@ud] base=@ud]
^-  @ud
    =/  lowheight  -:(sort `(list @ud)`[maxleft:input maxright:input ~] lth)
    ?.  (lte base:input lowheight)
        0
    (sub lowheight base:input)
::
::  Produces a list of the tallest heights on each tower's left and right
++  list-max-heights
|=  towers=(list @ud)
^-  (list [[maxleft=@ud maxright=@ud] base=@ud])
    =/  i  0
    =|  heights=(list [[maxleft=@ud maxright=@ud] base=@ud])
    |-
    ?:  =((lent heights) (lent towers))
        heights
    $(i +(i), heights (snoc heights [(max-heights i) (snag i towers)]))
::      
::  Produces a cell of the tallest heights on tower i's left and right
++  max-heights
|=  i=@ud
^-  [maxleft=@ud maxright=@ud]
    ?:  =(i 0)
        [0 (findmaxright i)]
    ?:  =(i (dec (lent towers)))
        [(findmaxleft i) 0]
    [(findmaxleft i) (findmaxright i)]
++  findmaxleft     |=(i=@ud -:(scag 1 (sort (oust [i (sub (lent towers) i)] towers) gth)))
++  findmaxright    |=(i=@ud -:(scag 1 (sort (oust [0 +(i)] towers) gth)))
--
