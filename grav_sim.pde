/*
 * Copyright 2023 Noah Dominic Miranda Silvio
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the European Union Public License version 1.2,
 * as published by the European Commission.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * European Union Public Licence for more details.
 *
 * You should have received a copy of the European Union Public Licence
 * along with this program. If not, see <https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12>.
 */

float GRAV_CONST = 6e-11;
float FRAME_PERIOD = 10000;
float time = 0;

ArrayList<Planet> planets = new ArrayList<Planet>();

float[][] positions = {{450,360}, 
                       {760,360}, 
                       {790,360}};
float[][] velocities = {{0,-1e-6},
                        {0,4.5e-4}, 
                        {0,5.5e-4}};
float[] masses = {882900, 8100, 100};

int PLANET_COUNT = masses.length; 



public class Planet {
  private float mass;
  private float[] pos;
  private float[] vel;
  
  public Planet(float mass, float[] pos, float[] vel) {
    this.mass = mass;
    this.pos = pos;
    this.vel = vel;
  }
  
  public void receiveForce(float[] force) {
    this.updateVel(new float[]{force[0]/this.mass, force[1]/this.mass});
  }
  
  public void updateVel(float[] accel){
    this.vel[0] += accel[0] * FRAME_PERIOD;
    this.vel[1] += accel[1] * FRAME_PERIOD;
  }
  
  public void move() {
    updateVel(new float[]{0, 0});
    this.pos[0] += vel[0] * FRAME_PERIOD;
    this.pos[1] += vel[1] * FRAME_PERIOD;
  }
  
  public float getMass() { return mass; }
  public float[] getPosition() { return pos; }
}



public static class Physics {
  public static float calculateTheta(float[] point0, float[] point1) {
    return (float) Math.atan2(point1[1] - point0[1], point1[0] - point0[0]);
  }
  
  public static float calculateDistance(float[] point1, float[] point2) {
    if (point1.length != point2.length) {
      throw new IllegalArgumentException("Points must have the same dimension");
    }
    float squaredDistance = 0;
    for (int i = 0; i < point1.length; i++) {
      float delta = point2[i] - point1[i];
      squaredDistance += delta * delta;
    }
    return (float) Math.sqrt(squaredDistance);
  }
}


void render() {  
  for (int i = 0; i < PLANET_COUNT; i++){
    float mass = planets.get(i).getMass();
    float[] position = planets.get(i).getPosition();
    
    // Change the y-bias here to the screen height
    ellipse(position[0], 720-position[1], (float) Math.log(mass)+2, (float) Math.log(mass)+2 );
  }
}

void calculatePositions() {
  float[][] forces = new float[PLANET_COUNT][2];
  
  for (int i = 0; i < PLANET_COUNT - 1; i++) {
    for (int j = i+1; j < PLANET_COUNT; j++) {
      float theta = Physics.calculateTheta(planets.get(i).getPosition(), planets.get(j).getPosition());
       
      float distance = Physics.calculateDistance( planets.get(i).getPosition(), planets.get(j).getPosition() );
      float force = ( GRAV_CONST * planets.get(i).getMass() * planets.get(j).getMass() ) / (distance * distance + 1e-21);      
      float force_x = force * (float) Math.cos(theta);
      float force_y = force * (float) Math.sin(theta);
      
      forces[i][0] += force_x;
      forces[i][1] += force_y;
      forces[j][0] -= force_x;
      forces[j][1] -= force_y;
      
      System.out.println("forces[" + i + "][0] += " + force_x + ";");
      System.out.println("forces[" + i + "][1] += " + force_y + ";");
      System.out.println("forces[" + j + "][0] -= " + force_x + ";");
      System.out.println("forces[" + j + "][1] -= " + force_y + ";");
      System.out.println();
    }
  }
  
  for (int i = 0; i < PLANET_COUNT; i++){
    planets.get(i).receiveForce(forces[i]);
    planets.get(i).move();
  }
}

void setup() {
  size(800, 800);

  for (int i = 0; i < PLANET_COUNT; i++){
    planets.add( new Planet(masses[i], positions[i], velocities[i]) );
  }
}

void draw() {
  background(0);
  render();
  calculatePositions();
}
