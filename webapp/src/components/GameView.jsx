import React, { useState } from 'react';
import styles from './GameView.module.css';
import Menu from './Menu/Menu';
import WorldMap from './WorldMap/WorldMap';

export default () => {
  const [isInMenu, setMenuState] = useState(true);

  return (
    <div className={styles.gameContainer}>
      {isInMenu ? <Menu menuOptionHandler={setMenuState} /> : <WorldMap />}
    </div>
  );
}
