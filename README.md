# Running App

This app collects GPS data in order to present the following information:

- Speed
- Average Speed
- Duration
- Distance
- Calories

Watch the demo

[![Watch the video](https://img.youtube.com/vi/wkVlQ6AhL3Y/0.jpg)](https://youtu.be/wkVlQ6AhL3Y)

## Views

The app has 4 views

### Status view

The status view presents the current workout status and it is updated based on GPS data.

![Status view](./imgs/status.png)

### Map view

The map view shows the map and has the controller to start/stop the workout.

![Map view](./imgs/map.png)

### Profile view

The profile view has some configurations that are used in the app to calculate or present data,
such as the weight of the person and the speed unit respectively.

![Profile view](./imgs/profile.png)

### Runs view

The last view presents the previous exercises, it consists of a list and a detail page.

![History view](./imgs/runshistory.png)
![Destail view](./imgs/runmetrics.png)

## Data storage

Two storages are being used.

The UserDefaults are used to store the profile data and the run's history that uses Core Data.

## How to run

Import the project on XCode and run the app. Give the app GPS permission when required. 
In order to simulate the data you can go to Simulator Screen > Features > Location > City run.
Click on the map icon, hit play, and go back to the Stats screen to see the data changing.
