import React, { useState } from 'react';
import styles from './GameView.module.css';
import Menu from './Menu/Menu';
import GameContainer from './GameContainer/GameContainer';

export default () => {
  const [isInMenu, setMenuState] = useState(true);
  const [virusName, setVirusName] = useState('');

  const gameStartHandler = async (gameNotYetStarted, name, startingCountry) => {
    if (!gameNotYetStarted) {
      setVirusName(name);
      setMenuState(false);
    }
  }

  return (
    <div className={styles.gameContainer}>
      {isInMenu
        ? <Menu menuOptionHandler={gameStartHandler} />
        : <GameContainer init={virusName} />
      }
    </div>
  );
}
