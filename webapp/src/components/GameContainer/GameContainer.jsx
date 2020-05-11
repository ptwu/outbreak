import React, { useEffect, useState } from "react";
import styles from "./GameContainer.module.css";
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
  Typography,
  Snackbar,
} from "@material-ui/core";
import MuiAlert from "@material-ui/lab/Alert";
import WorldMap from "./WorldMap";
import ReactTooltip from "react-tooltip";
import InitGameDataJSON from "./data/sample_game.json";

function Alert(props) {
  return <MuiAlert elevation={6} variant="filled" {...props} />;
}

export default ({ virusName }) => {
  const [name, setName] = useState(virusName);
  const [startingCountry, setStartingCountry] = useState("");
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
  const [open, setOpen] = useState(false);
  const [toastOpen, setToastOpen] = useState(false);
  const [errorToastOpen, setErrorToastOpen] = useState(false);
  const [isErrorPresent, setError] = useState(false);
  const [HeaderText, setHeaderText] = useState('');
  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handlePurchase = async (itemId, itemCost) => {
    if (itemCost > points) {
      setErrorToastOpen(true);
    } else {
      setToastOpen(true);
      fetch(`/purchase/${itemId}`, {
        method: "POST",
      }).catch((err) => console.log(err));
      setShop(shop => shop.filter(u => u.id !== itemId))
      console.log(itemId + " " + itemCost);
    }
  };

  const pickStartingCountryHandler = async (id, name) => {
    setStartingCountry(name);
    try {
      await fetch("/reset", {
        method: "POST",
        headers: {
          "content-type": "application/json",
        },
        body: JSON.stringify(InitGameDataJSON),
      });
      const data = await fetch("/init", {
        method: "POST",
        headers: {
          "content-type": "application/json",
        },
        body: JSON.stringify({ name: virusName, starter: id }),
      });
      gameStateHandler(await data.json());
    } catch (error) {
      console.log(error);
      setError(true);
    }
    setHeaderText(`Your Outbreak started in ${name}.`);
    setStartTime(performance.now());
  };

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
    setShop(shop.filter((x) => !virus.upgrades.includes(x.id)));
    if (world.population.infected > 4101482) {
      setHeaderText(`${name} has infected more people than the Novel Coronavirus (COVID-19)`);
    }
    if (world.population.dead > 0) {
      setHeaderText(`${name} is now deadly.`);
    }
    if (world.population.dead > world.population.healthy) {
      setHeaderText(`There are now fewer healthy people than dead in the world.`);
    }
    if (world.population.dead > 7000000000) {
      setHeaderText(`${name} is coming close to eradicating human civilization.`);
    }
  };

  const getDate = () => {
    let date = new Date();
    const endTime = performance.now();
    date.setDate(date.getDate() + Math.floor((endTime - startTime) / 1000));
    return (
      (date.getMonth() > 8
        ? date.getMonth() + 1
        : "0" + (date.getMonth() + 1)) +
      "/" +
      (date.getDate() > 9 ? date.getDate() : "0" + date.getDate()) +
      "/" +
      date.getFullYear()
    );
  };

  useEffect(() => {
    if (startingCountry !== "") {
      const interval = setInterval(async () => {
        await fetch("/step", { method: "POST" })
          .then(
            (data) => data.json(),
            (err) => setError(true)
          )
          .then((d) => gameStateHandler(d));
      }, 500);
      return () => clearInterval(interval);
    }
  }, [startingCountry]);

  const [tooltipContent, setTooltipContent] = useState("");

  if (!isErrorPresent) {
    if (score === 0) {
      return (
        <>
          <Snackbar
            open={toastOpen}
            autoHideDuration={6000}
            onClose={() => setToastOpen(false)}
          >
            <Alert onClose={() => setToastOpen(false)} severity="success">
              Upgrade purchased!
            </Alert>
          </Snackbar>
          <Snackbar
            open={errorToastOpen}
            autoHideDuration={6000}
            onClose={() => setErrorToastOpen(false)}
          >
            <Alert onClose={() => setErrorToastOpen(false)} severity="error">
              You don't have enough DNA points to buy that upgrade!
            </Alert>
          </Snackbar>
          <div>
            <Dialog
              open={open}
              onClose={handleClose}
              aria-labelledby="form-dialog-title"
              disableBackdropClick
            >
              <DialogTitle id="form-dialog-title" className={styles.ShopText}>
                Shop
              </DialogTitle>
              <DialogContent>
                <Grid container>
                  <Grid item xs={12}>
                    <Grid container justify="center" spacing={3}>
                      {shop.map((item, i) => (
                        <Grid item xs key={i}>
                          <Card>
                            <CardContent>
                              <Typography
                                gutterBottom
                                variant="h5"
                                component="h2"
                                className={styles.ShopText}
                              >
                                {item.name}
                              </Typography>
                              <Typography
                                variant="body2"
                                color="textSecondary"
                                component="p"
                                align="left"
                                className={styles.ShopText}
                              >
                                Cost: 🧬{item.cost}
                              </Typography>
                            </CardContent>
                            <Button
                              size="large"
                              className={styles.ShopText}
                              onClick={() => handlePurchase(item.id, item.cost)}
                            >
                              Buy
                            </Button>
                          </Card>
                        </Grid>
                      ))}
                    </Grid>
                  </Grid>
                </Grid>
              </DialogContent>
              <DialogActions>
                <Button onClick={handleClose} className={styles.ShopText}>Exit</Button>
              </DialogActions>
            </Dialog>
          </div>

          {/* Display card */}
          <Container maxWidth="xl">
            <Card
              className={styles.GameplayCard}
              style={{ position: "relative" }}
            >
              <div className={styles.WorldMapContainer}>
                <div className={styles.HeaderSection}>
                  <h1 className={styles.VirusNameText}>{name}</h1>
                  {startingCountry === "" ? (
                    <h2>Choose a continent to start your outbreak!</h2>
                  ) : (
                      <h2>{HeaderText}</h2>
                    )}
                </div>
                <div className={styles.WorldMapWrap}>
                  <WorldMap
                    setContent={setTooltipContent}
                    pickCountryHandler={pickStartingCountryHandler}
                    data={countryData}
                  />
                  <ReactTooltip>{tooltipContent}</ReactTooltip>
                </div>
              </div>

              {startingCountry !== '' ? (
                <>
                  <div className={styles.DateDisplay}>
                    <p>
                      📅 <b>Date</b>: {getDate()}{' '}
                    </p>
                  </div>
                  <div className={styles.VirusStats}>
                    <p>
                      💓 <b>Healthy</b>: {healthy.toLocaleString()}
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ☣️ <b>
                        Infected
                      </b>: {infected.toLocaleString()}
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 💀 <b>Dead</b>:{' '}
                      {deaths.toLocaleString()}
                    </p>
                  </div>
                  <div className={styles.CureProgress}>
                    <p>
                      🧪 <b>Cure Progress</b>: {Math.round(cureProgress)}%
                    </p>
                  </div>
                  <div className={styles.ShopLHS}>
                    <p>
                      🧬 <b>DNA Points</b>: {points}
                    </p>

                    <Button
                      variant="contained"
                      onClick={handleClickOpen}
                      className={styles.ShopButton}
                    >
                      Shop
                    </Button>
                  </div>
                </>
              ) : undefined}
            </Card>
          </Container>
        </>
      );
    } else {
      return (
        <Container maxWidth="lg">
          <Card className={styles.InfoCard}>
            {(cureProgress >= 100 || healthy > 0) ? (
              <h1 style={{ color: '#A60000' }}>You Lose</h1>
            ) : (
                <h1 style={{ color: '#008a25' }}>You Win</h1>
              )}

            {cureProgress >= 100 ? (
              <h3>
                A vaccine has been discovered for {name}, and the world is back
                to <i>functional</i> order.
              </h3>
            ) : (healthy > 0) ? (
              <h3>
                {name} has eradicated all of its patients, but it was too deadly
                for its own good. All of those infected with the outbreak have
                since passed away, and the remaining healthy people live on to
                tell the tale.
              </h3>
            ) : (
                  <h3>{name} has wrought havoc on the entire world!</h3>
                )}
            <br />


            <h1>Final Score: {points}</h1>
          </Card>
        </Container>
      );
    }
  } else {
    return (
      <Container maxWidth="lg">
        <Card className={styles.InfoCard}>
          <h1>Error: Server is likely not running.</h1>
          <h3>Have you run `make server` in the root folder?</h3>
        </Card>
      </Container>
    );
  }
};
