
SortedList = require './sorted-list'
Node       = require './node'
Point      = require './point'
Interval   = require './interval'
Util       = require './util'


###*
interval tree

@class IntervalTree
@module interval-tree2
###
class IntervalTree


    ###*
    @constructor
    @param {Number} center center of the root node
    ###
    constructor: (center) ->

        Util.assertNumber center, 'IntervalTree: center'

        ###*
        root node

        @property {Node} root
        ###
        @root = new Node(center)


        ###*
        id => interval

        @property {Object(Interval)} intervalsById
        ###
        @intervalsById = {}


        ###*
        sorted list of whole point

        @property {SortedList(Point)} pointTree
        ###
        @pointTree = new SortedList('val')


        ###*
        unique id candidate of interval without id to be added next time

        @property {Number} idCandidate
        ###
        @idCandidate = 0



    ###*
    add one interval
    @param {Number} start start of the interval to create
    @param {Number} end   end of the interval to create
    @param {String|Number} [id] identifier to distinguish intervals. Automatically defiend when not set.
    @return {Interval}
    ###
    add: (start, end, id) ->

        if @intervalsById[id]?
            throw new Error('id ' + id + ' is already registered.')

        if not id?
            while @intervalsById[@idCandidate]?
                @idCandidate++
            id = @idCandidate

        interval = new Interval(start, end, id)

        @pointTree.insert new Point(interval.start, id)
        @pointTree.insert new Point(interval.end,   id)

        @intervalsById[id] = interval

        return @insert interval, @root


    ###*
    search intervals
    when only one argument is given, return intervals which contains the value
    when two arguments are given, ...

    @param {Number} val1
    @param {Number} val2
    @return {Array(Interval)} intervals
    ###
    search: (val1, val2) ->

        Util.assertNumber val1, '1st argument at IntervalTree#search()'

        if not val2?

            return @pointSearch val1, @root

        else

            Util.assertNumber val2, '2nd argument at IntervalTree#search()'

            ret = []

            @rangeSearch val1, val2, ret

            return ret



    ###*
    insert interval to the given node

    @method insert
    @private
    @param {Interval} interval
    @param {Node} node node to insert the interval
    @return {Interval} inserted interval
    ###
    insert: (interval, node) ->

        if interval.end < node.center

            newCenter = interval.end

            node.left ?= new Node(newCenter)

            return @insert(interval, node.left)

        if node.center < interval.start

            middle = (interval.start + interval.end) / 2

            node.right ?= new Node(middle)

            return @insert(interval, node.right)

        node.insert interval

        return interval


    ###*
    search intervals at the given node

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
                interval = @intervalsById[id]
                arr.push interval.result(start, end)
                return


    remove: (id) ->


module.exports = IntervalTree
