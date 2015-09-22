
SortedList = require './sorted-list'
Node       = require './node'
Point      = require './point'
Interval   = require './interval'
Util       = require './util'


class IntervalTree


    constructor: (center) ->

        @intervalsById = {}

        ###*
        sorted list of whole point

        @property {SortedList(Point)} pointTree
        ###
        @pointTree = new SortedList('val')

        @_autoIncrement = 0

        Util.assertNumber center, 'IntervalTree: center'

        @root = new Node(center)


    insert: (node, itvl) ->

        if itvl.end < node.center

            newCenter = itvl.end

            node.left ?= new Node(newCenter)

            return @insert(node.left, itvl)

        if node.center < itvl.start

            middle = (itvl.start + itvl.end) / 2

            node.right ?= new Node(middle)

            return @insert(node.right, itvl)

        node.insert itvl

        return


    ###*
    search intervals

    @method pointSearch
    @private
    @param val {Number}
    @param node {Node} current node to search
    @return {Array(Interval)}
    ###
    pointSearch: (val, node) ->

        results = []

        return results if not node?

        if val < node.center

            for interval in node.starts

                break if interval.start > val

                results.push interval

            return results.concat @pointSearch(val, node.left)


        if val > node.center

            for interval in node.ends

                break if interval.end < val

                results.push interval

            return results.concat @pointSearch(val, node.right)

        # if val is node.center
        return results.concat node.starts.toArray()


    rangeSearch: (start, end, arr) ->
        if end - start <= 0
            throw new Error('end must be greater than start. start: ' + start + ', end: ' + end)

        resultHash = {}
        wholeWraps = @pointSearch(start + end >> 1, @root)

        for result in wholeWraps
            resultHash[result.id] = true

        idx1 = @pointTree.bsearch new Point(start, null)

        while idx1 >= 0 and @pointTree[idx1].val is start
            idx1--

        idx2 = @pointTree.bsearch new Point(end, null)

        if idx2 >= 0
            len = @pointTree.length - 1

            while idx2 <= len and @pointTree[idx2].val <= end
                idx2++

            @pointTree.slice(idx1 + 1, idx2).forEach (point) ->
                resultHash[point.id] = true
                return

            Object.keys(resultHash).forEach (id) =>
                itvl = @intervalsById[id]
                arr.push itvl.result(start, end)
                return


    add: (start, end, id) ->

        if @intervalsById[id]?
            throw new Error('id ' + id + ' is already registered.')

        if not id?
            while @intervalsById[@_autoIncrement]?
                @_autoIncrement++
            id = @_autoIncrement

        itvl = new Interval(start, end, id)

        @pointTree.insert new Point(itvl.start, id)
        @pointTree.insert new Point(itvl.end,   id)

        @intervalsById[id] = itvl

        @insert @root, itvl



    search: (val1, val2) ->

        ret = []

        Util.assertNumber val1, '1st argument at IntervalTree#search()'

        if not val2?

            return @pointSearch val1, @root

        else

            Util.assertNumber val2, '2nd argument at IntervalTree#search()'

            @rangeSearch val1, val2, ret

            return ret


    remove: (id) ->


module.exports = IntervalTree
