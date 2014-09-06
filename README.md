# Curses

library: [fresc81/node-curses  GitHub](https://github.com/fresc81/node-curses)

 - doesn't build:

        > curses@0.0.10 install /Users/mikerobe/Documents/Local/Dropbox/Documents/all/_+Documents/_Projects/_javascript/news/node_modules/curses
        > node ./pre-build.js


        url.js:107
            throw new TypeError("Parameter 'url' must be a string, not " + typeof url)
                  ^
        TypeError: Parameter 'url' must be a string, not undefined
            at Url.parse (url.js:107:11)
            at Object.urlParse [as parse] (url.js:101:5)
            at Object.<anonymous> (/Users/mikerobe/Documents/Local/Dropbox/Documents/all/_+Documents/_Projects/_javascript/news/node_modules/curses/pre-build.js:19:34)
            at Module._compile (module.js:456:26)
            at Object.Module._extensions..js (module.js:474:10)
            at Module.load (module.js:356:32)
            at Function.Module._load (module.js:312:12)
            at Function.Module.runMain (module.js:497:10)
            at startup (node.js:119:16)
            at node.js:901:3
        npm ERR! weird error 8
        npm ERR! not ok code 0


