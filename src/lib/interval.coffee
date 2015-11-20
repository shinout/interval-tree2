
###*
interval, containing start and and

@class Interval
@module interval-tree2
###
class Interval


    ###*
    @constructor
    @param {Number} start start of the interval
    @param {Number} end end of the interval
    @param {Number|String} id id of the interval
    @param {Object|String|Number|Null|Undefined} optional object to attach to the interval
    ###
    constructor: (@start, @end, @id, @object) ->


    ###*
    get center of the interval

    @method center
    @return {Number} center
    ###
    center: -> ( @start + @end ) / 2

module.exports = Interval
