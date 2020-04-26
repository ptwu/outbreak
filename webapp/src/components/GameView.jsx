import React, { useState } from 'react';
import styles from './GameView.module.css';
import Menu from './Menu/Menu';

export default () => {
  const [isInMenu, setMenuState] = useState(true);

  return (
    <div className={styles.gameContainer}>
      <Menu />
    </div>
  );
}
