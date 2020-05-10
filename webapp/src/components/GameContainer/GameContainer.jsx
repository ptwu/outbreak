import React, { useEffect, useState } from 'react';
import styles from './GameContainer.module.css';
import {
  Card, Container,
} from '@material-ui/core';
import WorldMap from './WorldMap';
import ReactTooltip from 'react-tooltip';
import InitGameDataJSON from './data/sample_game.json';

export default ({ virusName }) => {
  const [name, setName] = useState(virusName);
  const [startingCountry, setStartingCountry] = useState('');
  const [stats, setStats] = useState([]);
  const [upgrades, setUpgrades] = useState([]);
  const [score, setScore] = useState(0);
  const [points, setPoints] = useState(0);
  const [countryData, setCountryData] = useState([]);
  const [cureProgress, setCureProgress] = useState(0);
  // cure rate is not displayed
  const [healthy, setHealthy] = useState(0);
  const [infected, setInfected] = useState(0);
  const [deaths, setDeaths] = useState(0);
  const [shop, setShop] = useState([]);

  const pickStartingCountryHandler = async (countryName) => {
    setStartingCountry(countryName);
    console.log('sdfsdf');
    await fetch('/reset', {
      method: 'POST',
      headers: {
        'content-type': 'application/json'
      },
      body: JSON.stringify(InitGameDataJSON),
    })
      .then(() => { }, (err) => console.log(err));
    await fetch('/init', {
      method: 'POST',
      headers: {
        'content-type': 'application/json'
      },
      body: JSON.stringify({ name: virusName, starter: countryName }),
    })
      .then((data) => data.json(), (err) => console.log(err))
      .then(d => gameStateHandler(d));
  }

  const gameStateHandler = (data) => {
    console.log(data);
    const { virus, world, shop } = data;
    setScore(data.score);
    setName(virus.name);
    setStats(virus.stats);
    setUpgrades(virus.upgrades);
    setPoints(virus.points);
    setCountryData(world.countries);
    setCureProgress(world.cure_progress);
    setHealthy(world.population.healthy);
    setInfected(world.population.infected);
    setDeaths(world.population.dead);
    setShop(shop);
  }

  useEffect(() => {
    if (startingCountry !== '') {
      const interval = setInterval(async () => {
        await fetch('/step', { method: 'POST' })
          .then((data) => data.json(), (err) => console.log(err))
          .then(d => gameStateHandler(d));
      }, 1000);
      return () => clearInterval(interval);
    }
  }, [startingCountry]);

  const [tooltipContent, setTooltipContent] = useState('');

  if (score === 0) {
    return (
      <>
        <Container maxWidth="xl">
          <Card className={styles.GameplayCard} style={{ position: 'relative' }}>
            <div className={styles.WorldMapContainer}>
              <h1 className={styles.VirusNameText}>{name}</h1>
              {startingCountry === ''
                ? <h2>Choose a continent to start your outbreak!</h2>
                : <h2>Your Outbreak started in {startingCountry}</h2>}
              <WorldMap setContent={setTooltipContent} pickCountryHandler={pickStartingCountryHandler} data={countryData} />
              <ReactTooltip>{tooltipContent}</ReactTooltip>
            </div>

            {startingCountry !== ''
              ? <>
                <div className={styles.VirusStats}>
                  <p>💓 <b>Healthy</b>: {healthy}
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ☣️ <b>Infected</b>: {infected}
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                💀 <b>Dead</b>: {deaths}</p>
                </div>
                <div className={styles.CureProgress}>
                  <p>🧪 <b>Cure Progress</b>: {Math.round(cureProgress)}%</p>
                </div>
                <div className={styles.ShopLHS}>
                  <p>🧪 <b>Cure Progress</b>: {Math.round(cureProgress)}%</p>
                </div>
              </>
              : undefined}

          </Card>
        </Container>
      </>
    );
  } else {
    return (
      <Container maxWidth="lg">
        <Card className={styles.GameplayCard}>
          {cureProgress >= 100 ? <h1 style={{ color: '#A60000' }}>You Lose</h1> : <h1 style={{ color: '#008a25' }}>You Win</h1>}
          {cureProgress >= 100
            ? <h3>A vaccine has been discovered for {name}, and the world is back to <i>functional</i> order.</h3>
            : <h3>{name} has wrought havoc on the entire world!</h3>}
          <br />
          <h1>Final Score: {points}</h1>
        </Card>
      </Container>
    );
  }
}
