robot-kalmanfilter
==================

A repo for scratchpad work filtering a differential drive robot.


To run: 

1. Set EKF options in estimation/set_defaults

2. Set simulation options in estimation/set_trajectory 

3. Here are the options for running the simulation and data analysis:

* Run estimation/process_robot_data.m for a "one time" run of data. Command is: '[hist, data, settings] = process_robot_data'
* Run estimation/simulate_robot.m for a "one time" run of a simulated trajectory
* Run estimation/run_robot_tests.m for a "monte carlo" run

--

To Download Log Data:

1. Download the zip files from my Google Drive: https://drive.google.com/folderview?id=0B4jB60EiIiLPdDZlcUVyLW9pVjg&usp=sharing

2. Extract the zip files into a directory

3. For example, the directory `robot-kalmanfilter/logs` would contain the directories `Competition_Saturday` and `LaserTest_Drive`. Each of these directories contain text files of raw robot data.

4. Extract data using the readLogs command: `data = readLogs('robot-kalmanfilter/logs', 'Competition_Saturday');`
