
###*
extended array of objects, always sorted

@class SortedList
@extends Array
@module interval-tree2
###
class SortedList extends Array


    ###*
    @constructor
    @param {String} compareKey key name to compare objects. The value of the key must be a number.
    ###

    ###*
    key name to compare objects. The value of the key must be a number.
    @property {String} compareKey
    ###
    constructor: (@compareKey) ->



    ###*
    insert a value

    @method insert
    @param {any} val
    @return {Number} inserted position
    ###
    insert: (val) ->

        pos = @bsearch(val)

        @splice pos + 1, 0, val

        return pos + 1


    ###*
    remove the value in the given position

    @method remove
    @param {Number} pos position
    @return {SortedList} self
    ###
    remove: (pos) ->

        @splice pos, 1

        return @

    ###*
    binary search

    @method bsearch
    @param {any} val
    @return {Number} position of the value
    ###
    bsearch: (val) ->

        return -1 if not @length

        mpos = null
        mval = null
        spos = 0
        epos = @length

        while epos - spos > 1
            mpos = Math.floor((spos + epos) / 2)
            mval = @[mpos]
            comp = @compare(val, mval)

            return mpos if comp is 0

            if comp > 0
                spos = mpos
            else
                epos = mpos

        return if spos is 0 and @compare(@[0], val) > 0 then -1 else spos


    ###*
    leftmost position of the given val

    @method firstPositionOf
    @param {any} val
    @return {Number} leftmost position of the value
    ###
    firstPositionOf: (val) ->

        index = @bsearch val

        return -1 if index is -1

        num = val[@compareKey]

        while index >= 0 and num is @[index][@compareKey]
            index--

        return index



    ###*
    rightmost position of the given val

    @method lastPositionOf
    @param {any} val
    @return {Number} rightmost position of the value
    ###
    lastPositionOf: (val) ->

        index = @bsearch val

        return -1 if index is -1

        num = val[@compareKey]

        while index < @length and @[index][@compareKey] is num
            index++

        return index



    ###*
    # sorted.toArray()
    # get raw array
    #
    ###
    toArray: -> @slice()


    ###*
    comparison function. Compares two objects by this.compareKey

    @method compare
    @private
    @param {any} a
    @param {any} b
    ###
    compare: (a, b) ->

        return -1 if not a?
        return 1  if not b?

        c = a[@compareKey] - b[@compareKey]

        if c > 0 then 1 else if c is 0 then 0 else -1



module.exports = SortedList
