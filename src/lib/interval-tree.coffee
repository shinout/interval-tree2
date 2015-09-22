
SortedList = require './sorted-list'
Node       = require './node'
Interval   = require './interval'
Util       = require './util'


class IntervalTree

    constructor: (center, options = {}) ->

        { @startKey, @endKey } = options

        @startKey ?= 0
        @endKey   ?= 1

        @intervalHash = {}

        @pointTree = new SortedList compare: (a, b) ->

            return -1 if not a?
            return 1  if not b?

            c = a[0] - b[0]

            if c > 0 then 1 else if c is 0 then 0 else -1

        @_autoIncrement = 0

        Util.assertNumber center, 'IntervalTree: center'

        @root = new Node(center)


    insert: (node, itvl) ->

        if itvl.end < node.idx

            newCenter = itvl.end

            node.left ?= new Node(newCenter)

            return @insert(node.left, itvl)

        if node.idx < itvl.start

            middle = (itvl.start + itvl.end) / 2

            node.right ?= new Node(middle)

            return @insert(node.right, itvl)

        node.insert itvl

        return


    pointSearch: (node, idx, arr) ->

        return if not node?

        if idx < node.idx

            node.starts.every (itvl) ->

                bool = itvl.start <= idx

                if bool
                    arr.push itvl.result()

                return bool

            return @pointSearch(node.left, idx, arr)


        else if idx > node.idx

            node.ends.every (itvl) ->
                bool = itvl.end >= idx
                if bool
                  arr.push itvl.result()
                return bool

            return @pointSearch(node.right, idx, arr)

        else
            for itvl in node.starts
                arr.push itvl.result()



    rangeSearch: (start, end, arr) ->
        if end - start <= 0
            throw new Error('end must be greater than start. start: ' + start + ', end: ' + end)

        resultHash = {}
        wholeWraps = []

        @pointSearch @root, start + end >> 1, wholeWraps, true

        for result in wholeWraps
            resultHash[result.id] = true

        idx1 = @pointTree.bsearch([start, null ])

        pointTreeArray = @pointTree

        while idx1 >= 0 and pointTreeArray[idx1][0] is start
            idx1--

        idx2 = @pointTree.bsearch([end, null])

        if idx2 >= 0
            len = pointTreeArray.length - 1

            while idx2 <= len and pointTreeArray[idx2][0] <= end
                idx2++

            pointTreeArray.slice(idx1 + 1, idx2).forEach (point) ->
                id = point[1]
                resultHash[id] = true
                return

            Object.keys(resultHash).forEach (id) =>
                itvl = @intervalHash[id]
                arr.push itvl.result(start, end)
                return


    add: (data, id) ->

        if @intervalHash[id]?
            throw new Error('id ' + id + ' is already registered.')

        if not id?
            while @intervalHash[@_autoIncrement]?
                @_autoIncrement++
            id = @_autoIncrement

        itvl = new Interval(data, id, @startKey, @endKey)

        @pointTree.insert [ itvl.start, id ]
        @pointTree.insert [ itvl.end,   id ]

        @intervalHash[id] = itvl

        @insert @root, itvl



    search: (val1, val2) ->

        ret = []

        Util.assertNumber val1, '1st argument at IntervalTree#search()'

        if not val2?

            @pointSearch @root, val1, ret

        else

            Util.assertNumber val2, '2nd argument at IntervalTree#search()'

            @rangeSearch val1, val2, ret

        return ret


    remove: (id) ->


module.exports = IntervalTree
