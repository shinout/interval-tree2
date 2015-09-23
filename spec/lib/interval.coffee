
Interval = require '../../src/lib/interval'


describe 'Interval', ->

    describe 'center', ->

        it 'returns center of the interval', ->

            expect(new Interval(-193.3, 223.3).center()).to.equal 15
