import React, { useEffect, useState } from 'react';
import styles from './GameContainer.module.css';
import {
  Card,
  Container,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  CardContent,
  Typography
} from '@material-ui/core';
import WorldMap from './WorldMap';
import ReactTooltip from 'react-tooltip';
import InitGameDataJSON from './data/sample_game.json';

export default ({ virusName }) => {
  const [name, setName] = useState(virusName);
  const [startingCountry, setStartingCountry] = useState('');
  const [score, setScore] = useState(0);
  const [points, setPoints] = useState(0);
  const [countryData, setCountryData] = useState([]);
  const [cureProgress, setCureProgress] = useState(0);
  // cure rate is not displayed
  const [healthy, setHealthy] = useState(0);
  const [infected, setInfected] = useState(0);
  const [deaths, setDeaths] = useState(0);
  const [shop, setShop] = useState([]);
  const [startTime, setStartTime] = useState(0);
  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handlePurchase = async (itemId) => {
    await fetch(`/purchase/${itemId}`, {
      method: 'POST',
    });
  }

  const pickStartingCountryHandler = async (countryName) => {
    setStartingCountry(countryName);
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
    setStartTime(performance.now());
  }

  const gameStateHandler = (data) => {
    const { virus, world, shop } = data;
    setScore(data.score);
    setName(virus.name);
    setPoints(virus.points);
    setCountryData(world.countries);
    setCureProgress(world.cure_progress);
    setHealthy(world.population.healthy);
    setInfected(world.population.infected);
    setDeaths(world.population.dead);
    setShop(shop);
  }

  const getDate = () => {
    let date = new Date();
    const endTime = performance.now();
    date.setDate(date.getDate() + Math.floor((endTime - startTime) / 1000));
    return (
      (date.getMonth() > 8 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1)) +
      "/" +
      (date.getDate() > 9 ? date.getDate() : "0" + date.getDate()) +
      "/" +
      date.getFullYear()
    );
  }

  useEffect(() => {
    if (startingCountry !== '') {
      const interval = setInterval(async () => {
        await fetch('/step', { method: 'POST' })
          .then((data) => data.json(), (err) => console.log(err))
          .then(d => { gameStateHandler(d); });
      }, 1000);
      return () => clearInterval(interval);
    }
  }, [startingCountry]);

  const [tooltipContent, setTooltipContent] = useState('');

  if (score === 0) {
    return (
      <>
        <div>
          <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title" disableBackdropClick>
            <DialogTitle id="form-dialog-title">Shop</DialogTitle>
            <DialogContent>
              <Grid container>
                <Grid item xs={12}>
                  <Grid container justify="center" spacing={8}>
                    {
                      shop.map((item, i) => (
                        <Grid item xs key={i}>
                          <Card>
                            <CardContent>
                              <Typography gutterBottom variant="h5" component="h2">
                                {item.name}
                              </Typography>
                              <Typography variant="body2" color="textSecondary" component="p" align="left">
                                Cost: {item.cost}
                              </Typography>
                            </CardContent>
                            <Button size="large" onClick={() => handlePurchase(item.id)}>
                              Buy
                            </Button>
                          </Card>
                        </Grid>
                      ))
                    }
                  </Grid>
                </Grid>
              </Grid>
            </DialogContent>
            <DialogActions>
              <Button onClick={handleClose}>
                Exit
              </Button>
            </DialogActions>
          </Dialog>
        </div>
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
                <div className={styles.DateDisplay}>
                  <p>📅 <b>Date</b>: {getDate()} </p>
                </div>
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
                  <p>🧬 <b>DNA Points</b>: {points}</p>

                  <Button variant="contained" onClick={handleClickOpen} className={styles.ShopButton}>
                    Shop
                  </Button>
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
