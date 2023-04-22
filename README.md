# N-body gravity simulation

This project simulates the motion of multiple planets in space under Newtonian gravitational interaction.  Each planet is represented by a circle on the screen, and the user can observe how the planets interact with each other over time.

## Getting started

To run this program, you will need to have [Processing](https://processing.org/download/) installed on your machine.  Once Processing is installed, simply open the `grav_sim.pde` file in the Processing IDE and click the "play" button to run the simulation.

## How to use

Once the simulation is running, you can observe the motion of the planets on the screen.  The planets will move according to the gravitational forces exerted on them by the other planets in the system.  The larger the mass of a planet, the larger its circle on the screen will be.

## Customising the simulation

If you would like to modify the simulation, there are several variables you can adjust in the code:

- `GRAV_CONST`: This variable determines the strength of the gravitational forces between the planets.
- `FRAME_PERIOD`: This variable determines the time interval used for updating the positions of the planets.
- `positions`: This array contains the initial positions of the planets on the screen.  You can adjust the x and y coordinates of each planet to change their starting positions.
- `velocities`: This array contains the initial velocities of the planets.  You can adjust the x and y components of each velocity vector to change the initial direction and speed of each planet.
- `masses`: This array contains the masses of each planet.  You can adjust the mass of each planet to change its gravitational influence on the other planets in the system.

Note: Make sure that `masses`, `velocities`, and `positions` arrays have identical lengths.

## Samples
The samples below use `GRAV_CONST = 6e-11`.
### Compact binary system
```
float FRAME_PERIOD = 5000;

float[][] positions = {{270,360}, 
                       {570,360}};
float[][] velocities = {{0,-3e-3},
                        {0,3e-3}};
float[] masses = {88290000, 88100000};
```

### A sun-planet-moon system in a stable orbit
```
float FRAME_PERIOD = 10000;
float[][] positions = {{400,400}, 
                       {680,400}, 
                       {700,400}};
float[][] velocities = {{0,-1e-6},
                        {0,4.5e-4}, 
                        {0,6e-4}};
float[] masses = {882900, 8100, 100};
```

### A planet losing its moon
```
float FRAME_PERIOD = 10000;
float[][] positions = {{400,400}, 
                       {670,400}, 
                       {700,400}};
float[][] velocities = {{0,-1e-6},
                        {0,4.5e-4}, 
                        {0,5.5e-4}};
float[] masses = {882900, 8100, 100};
```

## Acknowledgements

This project was created using the Processing project, and was inspired by [Daniel Shiffman's tutorials on the Coding Train YouTube channel](https://www.youtube.com/user/shiffman/videos).
## Licence

This project is licenced under the EUPL v1.2.  See the LICENCE file for more information.
