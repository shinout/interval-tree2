
class Util

    @assertNumber: (val, desc) ->

        if not val?
            throw new Error(desc + ' is required.')

        if typeof val isnt 'number'
            throw new Error(desc + ' must be a number.')


    @assertOrder: (start, end, startName, endName, desc) ->

        if start > end
            throw new Error("#{desc}: #{startName}(#{start}) must be less than or equal to #{endName}(#{end}).")

module.exports = Util
