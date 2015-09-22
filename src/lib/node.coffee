
SortedList = require './sorted-list'

###*
node of IntervalTree, containing intervalsj

@class Node
@module interval-tree2
###
class Node


    ###*
    @constructor
    @param {Number} center center of the node
    ###
    constructor: (@center) ->

        ###*
        another node whose center is less than this.center

        @property {Node} left
        ###
        @left = null


        ###*
        another node whose center is greater than this.center

        @property {Node} right
        ###
        @right = null


        ###*
        sorted list of Intervals, sorting them by their start property

        @property {SortedList(Interval)} starts
        ###
        @starts = new SortedList 'start'


        ###*
        sorted list of Intervals, sorting them by their end property

        @property {SortedList(Interval)} ends
        ###
        @ends = new SortedList 'end'


    ###*
    insert an interval

    @method insert
    @param {Interval} interval
    ###
    insert: (interval) ->

        @starts.insert interval
        @ends.insert interval


module.exports = Node
