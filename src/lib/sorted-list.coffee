

class SortedList extends Array

    ###*
    # comparison functions 
    #
    ###
    @compares =

        'number': (a, b) ->
            c = a - b
            if c > 0 then 1 else if c == 0 then 0 else -1


        'string': (a, b) ->
            if a > b then 1 else if a == b then 0 else -1



    constructor: (args...) ->
        arr = null
        options = {}
        [
            '0'
            '1'
        ].forEach (n) ->
            val = args[n]
            if Array.isArray(val)
                arr = val
            else if val and typeof val == 'object'
                options = val
            return
        if typeof options.filter == 'function'
            @_filter = options.filter
        if typeof options.compare == 'function'
            @_compare = options.compare
        else if typeof options.compare == 'string' and SortedList.compares[options.compare]
            @_compare = SortedList.compares[options.compare]
        @_unique = ! !options.unique
        if options.resume and arr
            arr.forEach ((v, i) ->
                @push v
                return
            ), this
        else if arr
            @insert.apply this, arr
        return


    @create: (val1, val2) ->

        new SortedList(val1, val2)


    ###*
    # sorted.insertOne(val)
    # insert one value
    # returns false if failed, inserted position if succeed
    #
    ###
    insertOne: (val) ->
        pos = @bsearch(val)

        if @_unique and @key(val, pos) != null
            return false

        if !@_filter(val, pos)
            return false

        @splice pos + 1, 0, val

        return pos + 1


    ###*
    # sorted.insert(val1, val2, ...)
    # insert multi values
    # returns the list of the results of insertOne()
    #
    ###

    insert: (vals...) ->

        @insertOne(val) for val in vals

        return @

    ###*
    # sorted.remove(pos)
    # remove the value in the given position
    #
    ###
    remove: (pos) ->

        @splice pos, 1

        return @

    ###*
    # sorted.bsearch(val)
    # @returns position of the value
    #
    ###

    bsearch: (val) ->

        return -1 if not @length

        mpos = undefined
        mval = undefined
        spos = 0
        epos = @length

        while epos - spos > 1
            mpos = Math.floor((spos + epos) / 2)
            mval = @[mpos]
            comp = @_compare(val, mval)
            if comp is 0
                return mpos
            if comp > 0
                spos = mpos
            else
                epos = mpos

        if spos is 0 and @_compare(@[0], val) > 0 then -1 else spos


    ###*
    # sorted.key(val)
    # @returns first index if exists, null if not
    #
    ###
    key: (val, bsResult) ->
        bsResult ?= @bsearch val

        pos = bsResult

        if pos == -1 or @_compare(@[pos], val) < 0
            return if pos + 1 < @length and @_compare(@[pos + 1], val) == 0 then pos + 1 else null

        while pos >= 1 and @_compare(@[pos - 1], val) == 0
            pos--

        return pos

    ###*
    # sorted.key(val)
    # @returns indexes if exists, null if not
    #
    ###
    keys: (val, bsResult) ->
        ret = []
        bsResult ?= @bsearch val

        pos = bsResult

        while pos >= 0 and @_compare(@[pos], val) == 0
            ret.push pos
            pos--

        len = @length
        pos = bsResult + 1

        while pos < len and @_compare(@[pos], val) == 0
            ret.push pos
            pos++

        if ret.length then ret else null


    ###*
    # sorted.unique()
    # @param createNew : create new instance
    # @returns first index if exists, null if not
    #
    ###
    unique: (createNew) ->

        if createNew
            return @filter (v, k) =>
                k is 0 or @_compare(@[k - 1], v) isnt 0

        total = 0

        @map(((v, k) ->
            if k == 0 or @_compare(@[k - 1], v) != 0
                return null
            k - total++
        ), this).forEach ((k) ->
            if k != null
                @remove k
            return
        ), this
        this


    ###*
    # sorted.toArray()
    # get raw array
    #
    ###
    toArray: -> @slice()

    ###*
    # default filtration function
    #
    ###

    _filter: (val, pos) -> true


    ###*
    # sorted.compare(a, b)
    # default comparison function
    #
    ###
    _compare: @compares['string']


module.exports = SortedList
