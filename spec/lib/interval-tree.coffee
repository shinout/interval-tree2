
IntervalTree = require '../../src/lib/interval-tree'
Interval     = require '../../src/lib/interval'
Node         = require '../../src/lib/node'


describe 'IntervalTree', ->

    beforeEach ->

        @iTree = new IntervalTree(500)


    it 'throws an error when null is passed to constructor', ->

        expect(-> new IntervalTree(null)).to.throw 'IntervalTree: center is required.'



    describe 'add', ->

        it 'throws an error when non-number value is given to "start"', ->
            expect(-> @iTree.add('123', 39)).to.throw Error


        it 'throws an error when non-number value is given to "end"', ->
            expect(-> @iTree.add(123, '39')).to.throw Error


        it 'throws an error when duplicated id is given', ->
            @iTree.add(123, 345, 'foo')
            expect(-> @iTree.add(1234, 3457, 'foo')).to.throw Error


        it 'adds data with automatically-inserted id', ->

            interval = @iTree.add(12, 39)

            expect(interval).to.be.instanceof Interval
            expect(interval).to.have.property('id')

            id = interval.id

            expect(@iTree.intervalsById[id]).to.equal interval
            expect(@iTree.nodesById[id]).to.be.instanceof Node


        it 'adds data with custom id', ->

            interval = @iTree.add(-100, 10000, 'foo')

            expect(interval).to.be.instanceof Interval
            expect(interval).to.have.property('id', 'foo')

            expect(@iTree.intervalsById.foo).to.equal interval
            expect(@iTree.nodesById.foo).to.be.instanceof Node



    describe 'search', ->

        it 'throws an error when 1st argument is not a number', ->

            expect(-> @iTree.search('123')).to.throw Error


        it 'runs point search when one argument is given', (done) ->

            @iTree.pointSearch = (val) ->
                expect(val).to.equal 100
                done()

            @iTree.search(100)

        it 'throws an error when 2nd argument is given and not a number', ->

            expect(-> @iTree.search(70, '123')).to.throw Error


        it 'runs range search when two arguments are given', (done) ->

            @iTree.rangeSearch = (val1, val2) ->
                expect(val1).to.equal 100
                expect(val2).to.equal 200
                done()

            @iTree.search(100, 200)



    describe 'pointSearch', ->

        it 'returns overlapping intervals ', ->

            @iTree.add 499, 500, '499-500'
            @iTree.add 499, 501, '499-501'
            @iTree.add 500, 501, '500-501'
            @iTree.add 501, 502, '501-502'
            @iTree.add -31, 502, '-31-502'

            results = @iTree.pointSearch(500)

            expect(results).to.be.instanceof Array
            expect(results[0]).to.be.instanceof Interval
            expect(results).to.have.length 4

            for interval in results
                expect(interval.start).to.be.below 501
                expect(interval.end).to.be.above 499


        it 'returns overlapping intervals ', ->

            @iTree.add 599, 600, '599-600'
            @iTree.add 599, 601, '599-601'
            @iTree.add 600, 601, '600-601'
            @iTree.add 601, 602, '601-602'
            @iTree.add -31, 602, '-31-602'

            results = @iTree.pointSearch(600)

            expect(results).to.be.instanceof Array
            expect(results[0]).to.be.instanceof Interval
            expect(results).to.have.length 4


            for interval in results
                expect(interval.start).to.be.below 601
                expect(interval.end).to.be.above 599





    describe 'rangeSearch', ->

        it 'searches intervals by range', ->

            @iTree.add 498, 499, '498-499' # x
            @iTree.add 499, 500, '499-500' # o
            @iTree.add 499, 501, '499-501' # o
            @iTree.add 500, 501, '500-501' # o
            @iTree.add 501, 502, '500-502' # o
            @iTree.add 509, 510, '509-510' # o
            @iTree.add 509, 511, '509-511' # o
            @iTree.add 510, 511, '510-511' # o
            @iTree.add 511, 512, '511-512' # x
            @iTree.add -31, 999, '-31-999' # o

            results = @iTree.rangeSearch(500, 510)

            resultIds = (result.id for result in results)

            expect(results).to.be.instanceof Array
            expect(results[0]).to.be.instanceof Interval
            expect(results).to.have.length 8


            for id, interval of @iTree.intervalsById

                { start, end, id } = interval

                if id in resultIds

                    if start < 500
                        expect(end).to.be.above 499

                    else if end > 510
                        expect(start).to.be.below 511

                    else
                        expect(start).within 500, 510
                        expect(end).within 500, 510

                else
                    expect(start > 510 or end < 500).to.be.true



    describe 'remove', ->

        it 'removes an interval by id', ->

            @iTree.add 498, 499, 'foo'
            @iTree.add 498, 499, 'bar'

            id = 'foo'

            interval = @iTree.intervalsById[id]
            node = @iTree.nodesById[id]
            count = node.count()

            @iTree.remove id

            expect(@iTree.intervalsById[id]).to.not.exist
            expect(@iTree.nodesById[id]).to.not.exist

            expect(node.count()).to.equal count - 1
            expect(node.ends.length).to.equal count - 1

            results = @iTree.search(interval.start)
            resultIds = (result.id for result in results)
            expect(resultIds).to.not.contain id


