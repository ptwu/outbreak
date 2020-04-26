# `#outbreak;;` - A CS 3110 Final Project

## Created by Enoch Chen, Shefali Janorkar, and Peter Wu

### System Requirements

- OCaml 4.09.x
- Node.js 10.x.x
- npm 6.9.x (this is required to install the dependencies for the webapp; installed with Node.js)

You can install Node.js and npm by running `sudo apt update`, `sudo apt install nodejs`,  and `sudo apt install npm`. 

Use the commands `node -v` and `npm -v` to verify that your versions are up to date. 

(known bug for WSL on Windows: you may have to execute `sudonpm install -g npm` once or twice after installing it with `sudo apt install` if your version is way below 6.9.x.)

### Game Description

Inspired by the famed game Plague Inc., you start by choosing a disease to play and picking a country to start in. Depending on the attributes of your disease, it infects people in that country at a certain rate with certain symptoms. The simulation model will take into account the status of different countries (for example, the UK shutting down airports would make it less likely for your disease to enter) and determine how your disease spreads. Different “genes” which can improve infection rate, create fatal symptoms, or improve cure resistance can be bought as you infect people and earn “points”. As you progress and the disease and its symptoms become recognized across a sizable amount of people, borders shut down and the world starts to counter your disease with a cure. Your goal is to infect and kill the whole world before the cure is created and distributed.

### Commands

TODO