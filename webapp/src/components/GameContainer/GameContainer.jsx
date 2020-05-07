import React, { useEffect, useState } from 'react';
import styles from './GameContainer.module.css';
import {
  Card, Container,
} from '@material-ui/core';
import WorldMap from './WorldMap';
import ReactTooltip from "react-tooltip";

export default ({ virusName }) => {
  const [name, setName] = useState(virusName);
  const [startingCountry, setStartingCountry] = useState('');
  const [stats, setStats] = useState([]);
  const [upgrades, setUpgrades] = useState([]);
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
    await fetch('/init', {
      method: 'POST',
      headers: {
        'content-type': 'application/json'
      },
      body: JSON.stringify({ name: virusName, starter: countryName })
    })
      .then(() => { }, (err) => console.log(err));
  }

  const gameStateHandler = (data) => {
    console.log(data);
    const { virus, world, shop } = data;
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
        await fetch('/step/10', { method: 'POST' })
          .then((data) => data.json(), (err) => console.log(err))
          .then(d => gameStateHandler(d));
      }, 1000);
      return () => clearInterval(interval);
    }
  }, [startingCountry]);

  const [tooltipContent, setTooltipContent] = useState('');

  return (
    <>
      <Container maxWidth="xl">
        <Card className={styles.GameplayCard}>
          <div className={styles.WorldMapContainer}>
            <h1>{name}</h1>
            {startingCountry === ''
              ? <h2>Choose a continent to start your outbreak!</h2>
              : <h2>Your Outbreak started in {startingCountry}</h2>}
            <WorldMap setContent={setTooltipContent} pickCountryHandler={pickStartingCountryHandler} data={countryData} />
            <ReactTooltip>{tooltipContent}</ReactTooltip>
          </div>
          {/* <div className={styles.Points}>
            <p>Stats: {JSON.stringify(stats)}</p>
            <p>Upgrades: {JSON.stringify(upgrades)}</p>
            <p>Points: {points}</p>
            <p>Country Data: {JSON.stringify(countryData)}</p>
            <p>Cure Progress: {cureProgress}</p>
            <p># Healthy: {healthy}</p>
            <p># Infected: {infected}</p>
            <p># Dead: {deaths}</p>
            <p>Shop: {JSON.stringify(shop)}</p>
          </div> */}
        </Card>
      </Container>
    </>
  )
}
