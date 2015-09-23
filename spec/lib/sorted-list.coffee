
SortedList = require '../../src/lib/sorted-list'

describe 'SortedList', ->

    beforeEach ->

        @list = new SortedList('val')

        @list.insert(val: 300) # 0
        @list.insert(val: 301) # 1
        @list.insert(val: 301) # 2
        @list.insert(val: 303) # 3
        @list.insert(val: 304) # 4
        @list.insert(val: 304) # 5


    describe 'bsearch', ->

        it 'returns -1 when the given value is less than the least value in the list', ->

            expect(@list.bsearch(val: 0)).to.equal -1
            expect(@list.bsearch(val: 299)).to.equal -1


        it 'returns 0 when the given value is the same as the only least value in the list', ->
            expect(@list.bsearch(val: 300)).to.equal 0

        it 'returns position (multiple value)', ->
            expect(@list.bsearch(val: 301)).to.be.within 1, 2

        it 'returns position (no matching)', ->
            expect(@list.bsearch(val: 302)).to.equal 2

        it 'returns position', ->
            expect(@list.bsearch(val: 303)).to.equal 3

        it 'returns position (max)', ->
            expect(@list.bsearch(val: 304)).to.be.within 4, 5

        it 'returns position (more than max)', ->
            expect(@list.bsearch(val: 305)).to.equal 5



    describe 'firstPositionOf', ->

        it 'returns -1 when the given value is less than the least value in the list', ->

            expect(@list.firstPositionOf(val: 0)).to.equal -1
            expect(@list.firstPositionOf(val: 299)).to.equal -1


        it 'returns 0 when the given value is the same as the only least value in the list', ->
            expect(@list.firstPositionOf(val: 300)).to.equal 0

        it 'returns first position (multiple value)', ->
            expect(@list.firstPositionOf(val: 301)).to.equal 1

        it 'returns first position (no matching)', ->
            expect(@list.firstPositionOf(val: 302)).to.equal 3

        it 'returns first position', ->
            expect(@list.firstPositionOf(val: 303)).to.equal 3

        it 'returns first position (max)', ->
            expect(@list.firstPositionOf(val: 304)).to.equal 4

        it 'returns first position (more than max)', ->
            expect(@list.firstPositionOf(val: 305)).to.equal 6


    describe 'lastPositionOf', ->

        it 'returns -1 when the given value is less than the least value in the list', ->

            expect(@list.lastPositionOf(val: 0)).to.equal -1
            expect(@list.lastPositionOf(val: 299)).to.equal -1


        it 'returns 0 when the given value is the same as the only least value in the list', ->
            expect(@list.lastPositionOf(val: 300)).to.equal 0

        it 'returns last position (multiple value)', ->
            expect(@list.lastPositionOf(val: 301)).to.equal 2

        it 'returns last position (no matching)', ->
            expect(@list.lastPositionOf(val: 302)).to.equal 2

        it 'returns last position', ->
            expect(@list.lastPositionOf(val: 303)).to.equal 3

        it 'returns last position (max)', ->
            expect(@list.lastPositionOf(val: 304)).to.equal 5

        it 'returns first position (more than max)', ->
            expect(@list.lastPositionOf(val: 305)).to.equal 6
