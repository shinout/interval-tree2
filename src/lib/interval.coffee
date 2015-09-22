
Util = require './util'

class Interval


    constructor: (@data, @id, startKey, endKey) ->

        @start = @data[startKey]
        @end   = @data[endKey]

        Util.assertNumber(@start, 'Interval#start')
        Util.assertNumber(@end, 'Interval#end')

        if @start >= @end
            throw new Error('start must be smaller than end. start: ' + @start + ', end: ' + @end)


    result: (start, end) ->

        ret = 
            id   : @id
            data : @data

        if typeof start is 'number' and typeof end is 'number'

            # calc overlapping rate

            left  = Math.max(@start, start)
            right = Math.min(@end, end)
            lapLn = right - left
            ret.rate1 = lapLn / (end - start)
            ret.rate2 = lapLn / (@end - @start)

        return ret


module.exports = Interval
