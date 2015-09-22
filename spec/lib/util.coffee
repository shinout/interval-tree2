
Util = require '../../src/lib/util'

describe 'Util', ->

    describe '@assertNumber', ->

        it 'throws an Error when null is given to 1st argument', ->

            expect(-> Util.assertNumber(null, 'xx')).to.throw 'xx is required.'


        it 'throws an Error when string is given to 1st argument', ->

            expect(-> Util.assertNumber('123', 'xx')).to.throw 'xx must be a number.'


        it 'does nothing when number is given to 1st argument', ->

            expect(-> Util.assertNumber(123, 'xx')).to.not.throw Error
