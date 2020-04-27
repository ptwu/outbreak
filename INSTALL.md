# `#outbreak;;` Installation Instructions

### System Requirements

- OCaml 4.09.x
- Node.js 10.x.x
- npm 6.9.x

### Installation Instructions

(these instructions assume you have OCaml and opam installed to the directions in the CS 3110 course page)

1. You can install Node.js and npm by running `sudo apt update`, `sudo apt install nodejs`,  and `sudo apt install npm`. 
    - Use the commands `node -v` and `npm -v` to verify that your versions are up to date. (known bug for WSL on Windows: you may have to execute `sudonpm install -g npm` once or twice after installing it with `sudo apt install` if your version is way below 6.9.x.)

All the OCaml packages should be included from the CS 3110 default installation environment. You should be good to go.

### Building the System

- `make build` builds the OCaml code

- `make buildall` builds everything in the app for production, including the webapp

- `make play` starts the game from terminal mode.