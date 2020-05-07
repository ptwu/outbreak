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

  const pickStartingCountryHandler = (countryName) => {
    setStartingCountry(countryName);
  }

  const gameStateHandler = (data) => {
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
        await fetch('/step', { method: 'POST' }).then(() => { }, (err) => console.log(err));
        await fetch('/game', { method: 'GET' })
          .then((data) => data.json())
          .then(d => gameStateHandler(d));
      }, 2000);
      return () => clearInterval(interval);
    }
  }, []);

  const [tooltipContent, setTooltipContent] = useState('');

  return (
    <>
      <Container maxWidth="xl">
        <Card className={styles.GameplayCard}>
          <div className={styles.WorldMapContainer}>
            <h1>{name}</h1>
            <WorldMap setContent={setTooltipContent} pickCountryHandler={pickStartingCountryHandler} />
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
