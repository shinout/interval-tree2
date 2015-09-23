
Node = require '../../src/lib/node'
Interval = require '../../src/lib/interval'


describe 'Node', ->

    beforeEach ->

        @node = new Node(500)

    describe 'insert', ->

        it 'adds an interval to starts and ends', ->

            @node.insert new Interval(300, 600, 1)
            expect(@node.starts).to.have.length 1
            expect(@node.ends).to.have.length 1

            @node.insert new Interval(301, 598, 2)
            expect(@node.starts).to.have.length 2
            expect(@node.ends).to.have.length 2


    describe 'count', ->

        it 'adds an interval to starts and ends', ->

            @node.insert new Interval(300, 600, 1)
            @node.insert new Interval(301, 598, 2)

            expect(@node.count()).to.equal 2


    describe 'startPointSearch', ->

        beforeEach ->

            @node.insert new Interval(300, 600, 1)
            @node.insert new Interval(301, 598, 2)
            @node.insert new Interval(301, 599, 3)
            @node.insert new Interval(303, 599, 4)


        it 'returns empty array when all interval starts are greater than the given value', ->

            val = 299

            expect(@node.startPointSearch(val)).to.eql []


        it 'returns empty array when all interval starts are greater than the given value', ->

            # [WIP] fix SortedList#lastPositionOf()
            #expect(@node.startPointSearch(301)).to.have.length 3
            #expect(@node.startPointSearch(302)).to.have.length 4


    describe 'endPointSearch', ->
    describe 'getAllIntervals', ->
    describe 'remove', ->
    describe 'removeFromList', ->
