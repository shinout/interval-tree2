
class Util

    @assertNumber: (val, description) ->

        if not val?
            throw new Error(description + ' is required.')

        if typeof val isnt 'number'
            throw new Error(description + ' must be a number.')



module.exports = Util
