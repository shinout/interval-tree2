
Util = require './util'

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
    ###
    constructor: (@start, @end, @id) ->

        Util.assertNumber(@start, 'Interval#start')
        Util.assertNumber(@end, 'Interval#end')

        if @start >= @end
            throw new Error('start must be smaller than end. start: ' + @start + ', end: ' + @end)


    result: (start, end) ->

        ret = id: @id

        if typeof start is 'number' and typeof end is 'number'

            # calc overlapping rate

            left  = Math.max(@start, start)
            right = Math.min(@end, end)
            lapLn = right - left
            ret.rate1 = lapLn / (end - start)
            ret.rate2 = lapLn / (@end - @start)

        return ret


module.exports = Interval
