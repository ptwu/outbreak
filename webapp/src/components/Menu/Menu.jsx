import React from 'react';
import styles from './Menu.module.css';
import {
  Card, Container, Grid, Button
} from '@material-ui/core';

export default () => (
  <Container maxWidth="md">
    <Card className={styles.MainMenuCard}>
      <Container maxWidth="sm">
        <h1>Outbreak</h1>
        <p>
          A CS 3110 Final Project by Enoch Chen, Peter Wu, and Shefali Janorkar.
        </p>
        <Grid container spacing={2}>
          <Grid item xs={12}>
            <Grid container justify="center" spacing="8">
              <Grid item>
                <Button variant="contained" className={styles.MainMenuButton}>
                  Play
                </Button>
              </Grid>
              <Grid item>
                <Button variant="contained" className={styles.MainMenuButton}>
                  Instructions
                </Button>
              </Grid>
            </Grid>
          </Grid>
        </Grid>
      </Container>
    </Card>
  </Container>
);
