import React, { useState } from 'react';
import styles from './GameView.module.css';
import Menu from './Menu/Menu';
import GameContainer from './GameContainer/GameContainer';

export default () => {
  const [isInMenu, setMenuState] = useState(true);
  const [initGameData, setInitGameData] = useState({});

  const gameStartHandler = async (gameNotYetStarted) => {
    if (!gameNotYetStarted) {
      await fetch('/game')
        .then(res => res.json())
        .then(d => setInitGameData(d),
          (err) => console.log(err));
      setMenuState(false);
    }
  }

  return (
    <div className={styles.gameContainer}>
      {isInMenu
        ? <Menu menuOptionHandler={gameStartHandler} />
        : <GameContainer init={initGameData} />
      }
    </div>
  );
}
