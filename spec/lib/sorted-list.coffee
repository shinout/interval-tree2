
SortedList = require '../../src/lib/sorted-list'

describe 'SortedList', ->

    before ->

        @list = new SortedList('val')

        for i in [0...10] # inserts 10 times
            @list.insert(val: 10) 
            @list.insert(val: 12)
            @list.insert(val: 14)
            @list.insert(val: 16)

        expect(@list).to.have.length 40


    describe 'firstPositionOf', ->

        it 'returns the first position of the given value when the exact value exists', ->

            expect(@list.firstPositionOf(val: 10)).to.equal 0
            expect(@list.firstPositionOf(val: 12)).to.equal 10
            expect(@list.firstPositionOf(val: 14)).to.equal 20
            expect(@list.firstPositionOf(val: 16)).to.equal 30


        it 'returns the first position of the given value when the exact value does not exist', ->

            expect(@list.firstPositionOf(val: 9)).to.equal -1
            expect(@list.firstPositionOf(val: 11)).to.equal 10
            expect(@list.firstPositionOf(val: 13)).to.equal 20
            expect(@list.firstPositionOf(val: 15)).to.equal 30
            expect(@list.firstPositionOf(val: 17)).to.equal 40
            expect(@list.firstPositionOf(val: 18)).to.equal 40


    describe 'lastPositionOf', ->

        it 'returns the last position of the given value when the exact value exists', ->

            expect(@list.lastPositionOf(val: 10)).to.equal 10
            expect(@list.lastPositionOf(val: 12)).to.equal 20
            expect(@list.lastPositionOf(val: 14)).to.equal 30
            expect(@list.lastPositionOf(val: 16)).to.equal 40


        it 'returns the first position of the given value when the exact value does not exist', ->

            expect(@list.lastPositionOf(val: 9)).to.equal -1
            expect(@list.lastPositionOf(val: 11)).to.equal 10
            expect(@list.lastPositionOf(val: 13)).to.equal 20
            expect(@list.lastPositionOf(val: 15)).to.equal 30
            expect(@list.lastPositionOf(val: 17)).to.equal 40
            expect(@list.lastPositionOf(val: 18)).to.equal 40

