import React, { useEffect, useState } from 'react';
import styles from './WorldMap.module.css';
import {
  Card, Container,
} from '@material-ui/core';

export default ({ initHealthy }) => {
  const [healthy, setHealthy] = useState(initHealthy);
  const [infected, setInfected] = useState(0);
  const [deaths, setDeaths] = useState(0);
  const [cureProgress, setCureProgress] = useState(0);

  useEffect(() => {
    const interval = setInterval(async () => {
      await fetch('/step')
        .then(res => res.json())
        .then
    }, 1000);
    return () => clearInterval(interval);
  }, []);

  return (
    <>
      <Container maxWidth="md">
        <Card className={styles.MainMenuCard}>
          
        </Card>
      </Container>
    </>
  )
}
