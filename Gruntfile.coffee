currentVersion = 'v0.0.0'
module.exports = (grunt) ->

    grunt.config.init

        'mocha-chai-sinon':
            spec:
                src: [
                    'spec/lib/*.coffee'
                ]
                options:
                    ui: 'bdd'
                    reporter: 'spec'
                    require: 'coffee-script/register'

            single:
                src: [
                    grunt.option('file') ? 'spec/lib/interval-tree.coffee'
                ]
                options:
                    ui: 'bdd'
                    reporter: 'spec'
                    require: 'coffee-script/register'


        yuidoc:
            options:
                paths: ['src']
                syntaxtype: 'coffee'
                extension: '.coffee'
            master:
                options:
                    outdir: 'doc'


        coffee:
            dist:
                expand: true
                cwd: 'src/lib'
                src: ['**/*.coffee']
                dest: 'dist/lib/'
                ext: '.js'
                extDot: 'first'
                options:
                    bare: true



    grunt.registerTask 'web',  ->
        done = @async()
        browserify = require('browserify')

        b = browserify './src/web-entry.coffee',
            extensions: '.coffee'

        b.transform('coffeeify')

        b.bundle (err, buf) ->
            require('fs').writeFileSync 'dist/interval-tree.js', buf.toString()
            done()


    grunt.loadNpmTasks 'grunt-mocha-chai-sinon'
    grunt.loadNpmTasks 'grunt-contrib-yuidoc'
    grunt.loadNpmTasks 'grunt-contrib-coffee'

    grunt.registerTask 'default', 'mocha-chai-sinon:spec'
    grunt.registerTask 'single', 'mocha-chai-sinon:single'
    grunt.registerTask 'build', ['coffee:dist']
