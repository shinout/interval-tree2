
SortedList = require './sorted-list'

class Node

    constructor: (@center) ->

        @left  = null
        @right = null

        @starts = new SortedList 'start'
        @ends   = new SortedList 'end'


    insert: (interval) ->

        @starts.insert interval
        @ends.insert interval


module.exports = Node
