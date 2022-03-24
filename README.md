[folding at home](https://foldingathome.org/) is a great project,
where you can contribute your idle computing power to medical research 
and help fight against disease like Covid and cancer.

It has a "Folding only when idle" option,
which ideally should only start to use your computer when your computer is "idle".

However, it simply doesn't work for me (on GNOME).
The client simply never detects the computer as idle.

So I have made this service that allows for a more granular control.

The service listen to screen locking and unlocking signals using `dbus-monitor` 
and will pause the folding via `FAHClient` when the screen is unlocked, and will resume the folding when the 
screen is locked.

This is very convenient for those who have a habit of manually locking the screen when they are away (by hitting <kbd>super</kbd> + <kbd>l</kbd> for example).

Also, by default GNOME should lock the screen after some time of inactivity, which makes `gnome-folding-at-screenlock` 
a good idle detector too.

# Steps

1. `sudo systemctl enable foldingathome && sudo systemctl start foldingathome` If you haven't already done so.
Note our script won't start or stop the `foldingathome` service. 
It assumes the service is started and pauses/unpauses folding via `FAHClient`. 
The setting will be persisted in the configuration file located at `/etc/foldingathome/config.xml`.

2. Go to the dashboard in your browser at `http://localhost:7396/` and change some options. You should tick the
"While I'm working" option because we are not relying on FAH's idle detection anymore.
Also, you can set up your ideal power level too. Stop the folding at last by hitting the "Stop Folding" button, 
which actually adds a `<paused v='true'>` tag to your config file (It does exactly the same thing our script does when you wake up your monitor).

3. copy the [gnome-folding-at-screenlock.sh](gnome-folding-at-screenlock.sh) file to `/usr/bin/` and give it
the executable permission with `chmod +x /usr/bin/gnome-folding-at-screenlock.sh`.
4. copy the [gnome-folding-at-screenlock.service](gnome-folding-at-screenlock.service) file to `~/.config/systemd/user/`.
You might need to `mkdir -p ~/.config/systemd/user/` first.
Note, you shouldn't do this as root. The locking and unlocking of the screen is tied to the user using the desktop.
5. `systemctl --user enable gnome-folding-at-screenlock.service`. Do not run as root or with sudo.
6. `systemctl --user start gnone-folding-at-screenlock.service`. Do not run as root or with sudo.
7. Done! Now you can just hit <kbd>super</kbd> + <kbd>l</kbd> and lock the screen whenever you will be away from the computer.
Proteins will start folding right away! When you are back, move the mouse or press the keyboard to awake your computer, 
and the folding will stop!
8. For bonus points, go to GNOME's `Settings > Power` and turn off automatic suspension, otherwise no extended folding 
will be possible.
