import React, { useState } from 'react';
import styles from './Menu.module.css';
import {
  Card, Container, Grid, Button
} from '@material-ui/core';

export default ({ menuOptionHandler }) => {
  const [isInInstructions, setInstructionsState] = useState(false);

  return (
    <Container maxWidth="md">
      <Card className={styles.MainMenuCard}>
        <Container maxWidth="sm">
          <h1>Outbreak</h1>
          <p>
            A CS 3110 Final Project by Enoch Chen, Peter Wu, and Shefali Janorkar.
          </p>
          {isInInstructions
            ? (<div className={styles.InstructionsSection}>
              <h1>Instructions</h1>
              <p>You start by choosing a disease to play and picking a country
              to start in. Depending on the attributes of your disease, it
              infects people in that country at a certain rate with certain
              symptoms. The simulation model will take into account the status
              of different countries (for example, the UK shutting down airports
              would make it less likely for your disease to enter) and determine
              how your disease spreads. Different “genes” which can improve
              infection rate, create fatal symptoms, or improve cure resistance
              can be bought as you infect people and earn “points”. As you
              progress and the disease and its symptoms become recognized
              across a sizable amount of people, borders shut down and the
              world starts to counter your disease with a cure. Your goal is
              to infect and kill the whole world before the cure is created and
              distributed.
            </p>
              <Button
                variant="contained"
                className={styles.MainMenuButton}
                onClick={() => menuOptionHandler(false)}
              >
                Start
              </Button>
            </div>
            ) : (
              <Grid container spacing={2}>
                <Grid item xs={12}>
                  <Grid container justify="center" spacing={8}>
                    <Grid item>
                      <Button
                        variant="contained"
                        className={styles.MainMenuButton}
                        onClick={() => menuOptionHandler(false)}
                      >
                        Play
                    </Button>
                    </Grid>
                    <Grid item>
                      <Button
                        variant="contained"
                        className={styles.MainMenuButton}
                        onClick={() => setInstructionsState(true)}
                      >
                        Instructions
                    </Button>
                    </Grid>
                  </Grid>
                </Grid>
              </Grid>
            )
          }
        </Container>
      </Card>
    </Container>
  );
}
