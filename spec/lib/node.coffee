
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


        it 'returns array of intervals when some interval starts are less than or equal to the given value', ->

            expect(@node.startPointSearch(300)).to.have.length 1
            expect(@node.startPointSearch(301)).to.have.length 3
            expect(@node.startPointSearch(302)).to.have.length 3
            expect(@node.startPointSearch(303)).to.have.length 4

            results = @node.startPointSearch(301)

            for result in results
                expect(result).to.be.instanceof Interval
                expect(result.start).not.to.be.above 301


    describe 'endPointSearch', ->

        beforeEach ->

            @node.insert new Interval(300, 600, 1)
            @node.insert new Interval(301, 597, 2)
            @node.insert new Interval(301, 599, 3)
            @node.insert new Interval(303, 599, 4)


        it 'returns empty array when all interval starts are less than the given value', ->

            val = 601

            expect(@node.endPointSearch(val)).to.eql []


        it 'returns array of intervals when some interval starts are less than or equal to the given value', ->

            expect(@node.endPointSearch(600)).to.have.length 1
            expect(@node.endPointSearch(599)).to.have.length 3
            expect(@node.endPointSearch(598)).to.have.length 3
            expect(@node.endPointSearch(597)).to.have.length 4

            results = @node.endPointSearch(599)

            for result in results
                expect(result).to.be.instanceof Interval
                expect(result.end).not.to.be.below 599




    describe 'getAllIntervals', ->
    describe 'remove', ->
    describe 'removeFromList', ->
