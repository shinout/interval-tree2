
IntervalTree = require '../../src/lib/interval-tree'
Interval     = require '../../src/lib/interval'

createRandomInterval = (unit, id) ->

    p1 = Math.floor(Math.random() * unit)
    p2 = Math.floor(Math.random() * unit)

    if p1 is p2
        if p1 > 0
            p1--
        else
            p2++

    return new Interval(Math.min(p1, p2), Math.max(p1, p2), id)



describe 'IntervalTree', ->

    before ->

        @iTree = new IntervalTree(500)

        @intervals = (createRandomInterval(1000, i) for i in [0...100])

        for interval in @intervals

            @iTree.add interval.start, interval.end, interval.id


    describe 'search', ->

        it 'runs point search when one argument is given', ->


    describe 'pointSearch', ->

        it 'searchs intervals by point', ->

            results = @iTree.search(500)

            resultIds = (Number(result.id) for result in results)

            for interval, i in @intervals

                { start, end } = interval

                if i in resultIds

                    expect(start).to.be.below 501
                    expect(end).to.be.above 499

                else if start < 500
                    expect(end).to.be.below 500

                else
                    expect(start).to.be.above 500


    describe 'rangeSearch', ->

        it 'searchs intervals by range', ->

            results = @iTree.search(500, 700)

            for result in results

                expect(result.rate1).to.be.above 0
                expect(result.rate2).to.be.above 0

