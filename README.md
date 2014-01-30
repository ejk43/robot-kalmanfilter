robot-kalmanfilter
==================

A repo for scratchpad work filtering a differential drive robot.

To run: 

1. Set EKF options in estimation/set_defaults

2. Set simulation options in estimation/set_trajectory 

3. Run estimation/process_robot_data.m for a "one time" run of data. Command is: '[hist, data, settings] = process_robot_data'

4. Run estimation/simulate_robot.m for a "one time" run of a simulated trajectory.

5. Run estimation/run_robot_tests.m for a "monte carlo" run. 
