# `#outbreak;;` Installation Instructions

### System Requirements

- OCaml 4.09.x
- Node.js 10.x.x
- npm 6.9.x
- opium 0.18.0

### Installation Instructions

(these instructions assume you have OCaml and opam installed to the directions 
in the CS 3110 course page)

1. You can install Node.js and npm by running `sudo apt update`, 
`sudo apt install nodejs`,  and `sudo apt install npm`. 
    - IMPORTANT: Use the commands `node -v` and `npm -v` to verify that your 
    versions are up to date. (known bug for WSL: you may have to 
    execute `sudo npm install -g npm` once or twice (possibly restarting VSCode) 
    even after installing it with `sudo apt install npm` if your version is way 
    below 6.9.x.)

2. Assuming you have the default CS 3110 OCaml `opam` installations, you still 
have to install the opium package. Use the command `opam install opium` to 
install this dependency for the backend.

3. Run `make buildall` in the root directory (the folder this file is in). This
will build all the necessary source code in the project.

### Commands For Building the System and Running It

The following commands are for use in the root directory (the folder this
file is in)

- `make buildall` builds everything in the app (compiles OCaml code + webapp 
dependencies)

- `make run` runs the app and OCaml backend. You must have run `make buildall` 
prior to this for it to work
    - Alternatively, if you are having issues with this command, you might
    want to try `make server` in one terminal window and `make web` in another.
    If this doesn't work, your Node.js/npm version are probably out of date,
    or some weird OS bug is happening. (We hope this doesn't happen!)

- `make docs` generates documentation folders for the OCaml code: a doc.public
for the exposed functions and a doc.private for helpers/unexposed functions.

- `make test` evaluates the test cases in src/test.ml.

- `make clean` cleans the OCaml temp files out of the project.