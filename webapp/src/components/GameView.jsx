import React, { useState } from "react";
import styles from "./GameView.module.css";
import Menu from "./Menu/Menu";
import GameContainer from "./GameContainer/GameContainer";
import InitGameDataJSON from "../data/sample_game.json";

export default () => {
  const [isInMenu, setMenuState] = useState(true);
  const [virusName, setVirusName] = useState("");
  const [gameData, setGameData] = useState(InitGameDataJSON);

  const gameStartHandler = async (gameNotYetStarted, name) => {
    if (!gameNotYetStarted) {
      setVirusName(name);
      setMenuState(false);
    }
  };

  const customGameHandler = (data) => {
    console.log(data);
    setGameData(data);
  };

  return (
    <div className={styles.gameContainer}>
      {isInMenu ? (
        <Menu
          menuOptionHandler={gameStartHandler}
          customGameHandler={customGameHandler}
        />
      ) : (
        <GameContainer virusName={virusName} gameData={gameData} />
      )}
    </div>
  );
};
