# `#outbreak;;` - A CS 3110 Final Project

## Created by Enoch Chen, Shefali Janorkar, and Peter Wu

This README.md is intended for the GitHub monorepo. If you're a TA, please refer
to the INSTALL.md for more direct instructions on how to get the app running.
Thanks!

### System Requirements

- OCaml 4.09.x
- Node.js 10.x.x
- npm 6.9.x
- opium 0.18.0

You can install Node.js and npm by running `sudo apt update`, `sudo apt install nodejs`,  and `sudo apt install npm`. 

Use the commands `node -v` and `npm -v` to verify that your versions are up to date. 

(known bug for WSL on Windows: you may have to execute `sudonpm install -g npm` once or twice after installing it with `sudo apt install` if your version is way below 6.9.x.)

### Game Description

Inspired by the famed game Plague Inc., you start by choosing a disease to play and picking a country to start in. Depending on the attributes of your disease, it infects people in that country at a certain rate with certain symptoms. The simulation model will take into account the status of different countries (for example, the UK shutting down airports would make it less likely for your disease to enter) and determine how your disease spreads. Different “genes” which can improve infection rate, create fatal symptoms, or improve cure resistance can be bought as you infect people and earn “points”. As you progress and the disease and its symptoms become recognized across a sizable amount of people, borders shut down and the world starts to counter your disease with a cure. Your goal is to infect and kill the whole world before the cure is created and distributed.

### Commands

For use in the root directory.

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