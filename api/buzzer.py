#!/usr/bin/env python3
from time import sleep

from gpiozero import TonalBuzzer


BUZZER_PIN = 17
TUNE = [
    ("C#5", 0.14),
    ("F#4", 0.14),
    (None, 0.08),
    ("C#5", 0.14),
    ("F#4", 0.14),
    (None, 0.28),
    ("C#5", 0.14),
    ("F#4", 0.14),
    (None, 0.08),
    ("C#5", 0.14),
    ("F#4", 0.14),
    (None, 0.45),
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
