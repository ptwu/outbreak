import React, { useEffect, useState } from 'react';
import styles from './WorldMap.module.css';
import {
  Card, Container,
} from '@material-ui/core';

export default ({ init }) => {
  const [name, setName] = useState(init.virus.name);
  const [stats, setStats] = useState(init.virus.stats);
  const [upgrades, setUpgrades] = useState([]);
  const [points, setPoints] = useState(0);
  const [countryData, setCountryData] = useState(init.countries);
  const [cureProgress, setCureProgress] = useState(0);
  // cure rate is not displayed
  const [healthy, setHealthy] = useState(0);
  const [infected, setInfected] = useState();
  const [deaths, setDeaths] = useState(0);
  const [shop, setShop] = useState(init.shop);

  const gameStateHandler = (data) => {
    const { virus, world, shop } = data;
    setName(virus.name);
    setStats(virus.stats);
    setUpgrades(virus.upgrades);
    setPoints(virus.points);
    setCountryData(world.countries);
    setCureProgress(world.cure_progress);
    setShop(shop);
  }

  useEffect(() => {
    const interval = setInterval(async () => {
      await fetch('/step', { method: 'POST' }).then(() => { }, (err) => console.log(err));
      await fetch('/game', { method: 'GET' })
        .then((data) => data.json())
        .then(d => gameStateHandler(d));
    }, 2000);
    return () => clearInterval(interval);
  }, []);

  return (
    <>
      <Container maxWidth="xl">
        <Card className={styles.GameplayCard}>
          <h1>{name}</h1>
          <h4>Stats: {JSON.stringify(stats)}</h4>
          <h4>Upgrades: {JSON.stringify(upgrades)}</h4>
          <h4>Points: {points}</h4>
          <h4>Country Data: {JSON.stringify(countryData)}</h4>
          <h4>Cure Progress: {cureProgress}</h4>
          <h4># Healthy: not yet implemented</h4>
          <h4># Infected: not yet implemented</h4>
          <h4># Dead: not yet implemented</h4>
          <h4>Shop: {JSON.stringify(shop)}</h4>
        </Card>
      </Container>
    </>
  )
}
