#!/usr/bin/env python3
from time import sleep

from gpiozero import TonalBuzzer


BUZZER_PIN = 17
TUNE = [
    ("C#4", 0.2),
    ("D4", 0.2),
    (None, 0.2),
    ("Eb4", 0.2),
    ("E4", 0.2),
    (None, 0.6),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.6),
    ("Eb4", 0.2),
    ("E4", 0.2),
    (None, 0.2),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.2),
    ("C4", 0.2),
    ("B4", 0.2),
    (None, 0.2),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.2),
    ("B4", 0.2),
    ("Bb4", 0.5),
    (None, 0.6),
    ("A4", 0.2),
    ("G4", 0.2),
    ("E4", 0.2),
    ("D4", 0.2),
    ("E4", 0.2),
]


def play(tune):
    buzzer = TonalBuzzer(BUZZER_PIN)
    try:
        for note, duration in tune:
            print(note)
            buzzer.play(note)
            sleep(float(duration))
    finally:
        buzzer.stop()
        buzzer.close()


if __name__ == "__main__":
    try:
        play(TUNE)
    except KeyboardInterrupt:
        pass
