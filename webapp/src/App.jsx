import React from 'react';
import './App.css';
import {
  AppBar, Toolbar,
} from '@material-ui/core';
import GameView from './components/GameView';

export default () => (
  <AppBar className="Navbar">
    <Toolbar className="NavbarText">
      Outbreak
    </Toolbar>
    <GameView />
  </AppBar>
);

