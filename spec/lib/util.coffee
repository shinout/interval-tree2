
Util = require '../../src/lib/util'

describe 'Util', ->

    describe '@assertNumber', ->

        it 'throws an Error when null is given to 1st argument', ->

            expect(-> Util.assertNumber(null, 'xx')).to.throw 'xx is required.'


        it 'throws an Error when string is given to 1st argument', ->

            expect(-> Util.assertNumber('123', 'xx')).to.throw 'xx must be a number.'


        it 'does nothing when number is given to 1st argument', ->

            expect(-> Util.assertNumber(123, 'xx')).to.not.throw Error


    describe '@assertOrder', ->


        it 'throws an Error when start is equal to end', ->

            expect(-> Util.assertOrder(123, 123, 'start', 'end', 'xx')).to.throw 'xx: start(123) must be smaller than end(123).'

        it 'throws an Error when start is greater than end', ->

            expect(-> Util.assertOrder(234, 123, 'start', 'end', 'xx')).to.throw 'xx: start(234) must be smaller than end(123).'


        it 'does nothing when number is given to 1st argument', ->

            expect(-> Util.assertOrder(122, 123, 'start', 'end', 'xx')).to.not.throw Error
