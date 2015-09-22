
SortedList = require './sorted-list'

class Node

    constructor: (@center) ->

        @left  = null
        @right = null

        @starts = new SortedList compare: (a, b) ->
            return -1 if not a?
            return  1 if not b?

            c = a.start - b.start

            if c > 0 then 1 else if c is 0 then 0 else -1

        @ends = new SortedList compare: (a, b) ->
            return -1 if not a?
            return  1 if not b?

            c = a.end - b.end

            if c > 0 then 1 else if c is 0 then 0 else -1


    insert: (interval) ->

        @starts.insert interval
        @ends.insert interval


module.exports = Node
