import React, { useState, useRef } from "react";
import styles from "./Menu.module.css";
import { Card, Container, Grid, Button } from "@material-ui/core";
import TextField from "@material-ui/core/TextField";
import Dialog from "@material-ui/core/Dialog";
import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogTitle from "@material-ui/core/DialogTitle";
import { FilePicker } from "react-file-picker";

export default ({ menuOptionHandler, customGameHandler }) => {
  const [isInInstructions, setInstructionsState] = useState(false);
  const [open, setOpen] = React.useState(false);
  const nameTextRef = useRef("");

  const handleClose = () => {
    if (nameTextRef.current.value !== "") {
      setOpen(false);
      menuOptionHandler(false, nameTextRef.current.value);
    }
  };

  return (
    <>
      <div>
        <Dialog
          open={open}
          onClose={handleClose}
          aria-labelledby="form-dialog-title"
          className={styles.DialogWrap}
          disableBackdropClick
        >
          <DialogTitle id="form-dialog-title">Name Your Outbreak</DialogTitle>
          <DialogContent>
            <TextField
              inputRef={nameTextRef}
              autoFocus
              InputProps={{
                className: styles.VirusInputField,
              }}
              margin="dense"
              id="virus_name"
              label="Virus Name"
              fullWidth
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setOpen(false)}>Cancel</Button>
            <Button onClick={handleClose}>Start Game</Button>
          </DialogActions>
        </Dialog>
      </div>
      <Container maxWidth="md">
        <Card className={styles.MainMenuCard}>
          <Container maxWidth="sm">
            <h1>Outbreak</h1>
            <p>
              A CS 3110 Final Project by Enoch Chen, Peter Wu, and Shefali
              Janorkar.
            </p>
            {isInInstructions ? (
              <div className={styles.InstructionsSection}>
                <h1>Instructions</h1>
                <p>
                  You start by choosing a disease to play and picking a region
                  to start in. Depending on the attributes of your disease, it
                  infects (and kills) people in that region at a certain rate
                  with certain symptoms. Earn 🧬 DNA points over time and use
                  them to purchase gene upgrades. Different genes can improve
                  infection rate and/or create fatal symptoms. As you progress
                  and the disease and its symptoms become recognized across a
                  sizable amount of people, the world starts to counter your
                  disease with a cure. Your goal is to infect and kill the whole
                  world before the cure is created and distributed.
                </p>
                <Button
                  variant="contained"
                  className={styles.MainMenuButton}
                  onClick={() => setInstructionsState(false)}
                >
                  Back
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
                        onClick={() => setOpen(true)}
                      >
                        Play Campaign
                      </Button>
                    </Grid>
                    <Grid item>
                      <FilePicker
                        extensions={["json"]}
                        onChange={async (blob) => {
                          const text = await blob.text();
                          customGameHandler(JSON.parse(text));
                          setOpen(true);
                        }}
                        onError={(errMsg) => {
                          console.log(errMsg);
                        }}
                      >
                        <Button
                          variant="contained"
                          className={styles.MainMenuButton}
                        >
                          Play Custom
                        </Button>
                      </FilePicker>
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
            )}
          </Container>
        </Card>
      </Container>
    </>
  );
};
