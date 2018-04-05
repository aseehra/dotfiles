Arun Seehra's dotfiles

Uses git submodules for some functionality

### How to fix pulse headphone audio going to speakers as well
In `/usr/share/pulseaudio/alsa-mixer/paths`, ensure that the *Front* channel is
*Off*:

    [Element Front]
    switch = off
    volume = off
