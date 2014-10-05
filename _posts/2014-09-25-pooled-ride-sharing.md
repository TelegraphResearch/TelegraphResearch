---
layout: note
title: Quantitative Analysis of Pooled ridesharing
shortTitle: Ridesharing
Description: Data
label: ridesharing
category: Analysis
authors: ['philip', 'andrew']
latex: true
---


In the past few months, pooled transportation options have emerged in the multi-billion dollar ridesharing industry. Pooled ridesharing fills a niche between taxis and buses where riders can get low-priced, door-to-door transportation by sharing a vehicle with strangers traveling along a similar route. 

Rideshare company Sidecar [was the first to market with pooled ridesharing in May](http://techcrunch.com/2014/06/29/sidecar-shareable-rides/). The company that originally caught our attention in the area was [Hitch](http://www.takehitch.com/), a ridesharing company focused solely on pooled rides. Since Hitch’s [launch in June](http://techcrunch.com/2014/06/11/hitch-ride-share/), both rideshare giants Lyft and Uber have implemented test programs for pooled ridesharing using their existing driver bases in the San Francisco Bay area. 

Compared to traditional “dedicated” ridesharing where a customer commissions a full vehicle, Telegraph Research sought to quantify four hypotheses about pooled ridesharing.

### Hypotheses 

1. Pooled ridesharing has significantly higher driver utilization.
2. Pooled ridesharing takes longer for riders to arrive at the destination.
3. Pooled ridesharing is only efficient for one rider.
4. Fewer drivers are able to service the same number of riders.

In order to validate these hypotheses and to evaluate the feasibility of pooled rides in the rideshare industry, Telegraph Research developed a simulation of pooled ridesharing. 

<div class="alert alert-warning">
    During publication, it was announced that <a href="http://blog.lyft.com/posts/2014/9/22/lyft-acquires-hitch-to-accelerate-lyft-line-expansion">Lyft had acquired Hitch.</a>.
</div>


# Pooled Ridesharing Basics

## Implementations
The companies Hitch, Lyft, and Uber take slightly different approaches to a similar concept. 

### Hitch
Hitch was available in San Francisco through an iPhone app. Drivers are currently paid a flat hourly rate. Groups size, which must be specified before pickup, may range from one to three passengers.

Cars are treated like buses that continually pick up and drop off users between dynamically-routed locations. After picking up a rider, other passengers may be picked up or dropped off on the way to a destination. In this sense, a busy driver may never have an empty car. 

### Lyft Line
Lyft Line is available in San Francisco. All standard Lyft drivers (excluding Lyft Premium) are eligible to be assigned pooled rides. Riders are given a strict 60 second window after the driver arrives to enter the car, and cars only pick up two groups of people. Riders are given guaranteed prices, and drivers are paid the combined fares of the parties. 

Groups are paired based on similarities between their pickup location, destination, and travel route. In this sense, drivers are not dynamically routed, but are assigned a full route consisting of no more than two pickups and two dropoffs. 

### Uber Pool
Uber Pool is available in limited beta in the San Francisco Bay. All UberX drivers are eligible to be tasked Uber Pool fares. Uber Pool strictly allows only parties of one person, and a maximum of two passengers are in an Uber Pool during the course of the ride. 

Riders are paired based on their pickup location and destination with another rider traveling a similar route. Again, drivers are not dynamically routed, but are assigned a full route consisting of no more than two pickups and two dropoffs. 

## Advantages of Pooled Rides
Traditional ridesharing apps do not charge based on the number of passengers. Instead, they charge based on capacity, which generally is 3 riders for a standard car and 5 for a standard SUV. 

For single riders, such as commuters, purchasing three seats of capacity for a trip is not financially efficient. For this reason, [Uber introduced fare splitting to allow riders to split charges](http://blog.uber.com/2013/07/15/faresplit/). 

By optimizing for single riders, costs decrease. However, ride time increases. 

## Niche
It is not uncommon to see pooled rides cost between $3 and $5 for door-to-door service in an urban environment, compared to comparable $6 to $8 for a dedicated car. One-way transit on public transit costs about $2 (SF Muni). 

Compared to public transportation, pooled rideshares are typically faster due to fewer stops and more comfortable due to fewer passengers. However, arrival time is less predictable - buses run on precise time schedules; rideshares make no estimates about arrival time. 

## Opportunity
Due to the low price, pooled ridesharing becomes more feasible for commuters and thus more directly competes with public transportation. Attracting commuters brings recurring revenue, and hence will likely drive the growth of pooled ridesharing.

Pooled ridesharing primarily works in urban environments where fewer customers own cars or where parking is a significant expense. 

Business riders, for example those traveling to airports, are less likely to be cost-sensitive if they plan to expense the ride. Hence, they are unlikely to use pooled ridesharing. 

## Brand and Culture

Lyft has always promoted social rides by encouraging riders to sit in the front seat, fist bump drivers, and have a friendly conversation during the ride. 

The Uber brand does not promote a social aspect, but they treat Uber Pool as a [“Social experiment.”](http://blog.uber.com/uberpool) The brand originated as a premium service, and even in their cheaper UberX line drivers often act as chauffeurs. 

This dichotomy in brands will become apparent in pooled ridesharing. If riders engage socially, it seems that the Lyft brand would encourage drivers to participate and hence make the ride more comfortable. It is unclear whether Uber encourages Pool drivers to engage with customers.

# Simulation

To understand how pooled ridesharing differs from dedicated ridesharing as a system, we built a simulation in Python to analyze travel metrics between the two methodologies. The code is [available on Github](https://github.com/telegraphresearch/vehicle-sim).

## Model

The simulation has 2 different models that represent the two methods being compared: pooled and dedicated ridesharing. We based our pooled ridesharing simulation on the Hitch model where drivers continuously pick up and drop off passengers. The dedicated ridesharing model is based off of the existing standard, where drivers service one group at a time.

### System Variables

* **Arrival Rate**: The rate at which a new group enters the simulation. This is modeled as a binomial poisson distribution and determined by a variable lamda. At every second, a group has a given probability of being randomly generated.
* **Vehicle Quantity**: The number of vehicles that are allocated to a given model.

## Groups

A group represents a set of people that are travelling together. In simulations, the same groups of the same size spawned in both models at the same time. The variables for a group are defined below:

### Variables
* Size: 1 to 3 passengers. Upper bound of 3 is defined by the maximum capacity allowed for Hitch.
* Travel Time (seconds): The exact time needed to travel from current location to the destination; randomly generated and normally distributed.

## Vehicles

A vehicle is the entity that services a group. The fundamental difference between a pooled and dedicated ridesharing vehicle is what determines how many passengers it may pick up. It will serve as the sole experimental variable for the simulation, while all others will remain constant. The variables for a vehicle are defined below:

<div class="alert alert-info">
	<h3>Fundamental Model Difference</h3>
	<ul>
	<li>For <strong>dedicated ridesharing</strong>, a vehicle reports that it may pick up its full capacity if the car is empty, and it reports zero if it is non-empty.</li>
	<li>For <strong>pooled ridesharing</strong>, a vehicle always reports that it is available to pick up its capacity minus the current number of passengers.
	</li>
	</ul>
</div>


### Variables
* [Experimental] - Available for Pickup (boolean): Dedicated vheicles will be unavailable when containing one group. Pooled vehicles determine availability by the number of available seats compared to the size of a requesting group.
* Capacity: The number of seats; set at 3.
* Group Loading Time (seconds): The amount of time that a vehicle is idle while it loads or unloads people; values are randomly generated on a normal distribution.
* Group Pickup Time (seconds): The amount of time that a group must wait for an assigned vehicle to arrive; values are randomly generated on a normal distribution.

If a pooled vehicle has one group of size 1, it is still available to pick up one group of size 2, or two groups of size 1.

Values for Group Pickup Time vary based on the location of the vehicle when it is assigned to a group. It will always be nearby, never a constant distance, and more likely to fall within a range of values. The same assumption can be made for Group Loading Time. The time for a vehicle to pick up passengers and get back underway can vary for many different reasons. It may take some time for the group to exit a building, or the vehicle might have to circle around the block and flag down its customers.

## Steady-State Modeling

Using the defined group and vehicle, the simulation can be used to effectively model pooled and dedicated ridesharing services in the steady-state. Under these conditions, there must be a steady, constant supply of both groups and vehicles, with assignments occuring within an expected range of values. Deliberately incorporating actual routes into each group’s trip was not necessary and instead, the group’s Travel Time can be used to represent distance travelled.

TODO: "warming up" of data. 6 hours plus 1 hour of warm-up

## Modeling Distance as Time

Once a group is picked up, its Travel Time is decremented for each second that the vehicle is underway. A dedicated ridesharing vehicle will constantly decrement time until it reaches 0, at which point it is at the destination. A pooled vehicle will also also decrement time while it travels, but it is susceptible to time penalties from other groups. These time penalties correspond to the loading times for adding and removing groups because the vehicle is idle during that time.

## A Infinite, Straight Road

With the added simplifications, the simulation can be pictured as a straight, infinite, one-way road along which vehicles travel at a constant speed. Groups appear along the side of it and request to be carried down the road to a certain point. 

TODO - this is wrong:

 A group is assigned to the closest available vehicle; for dedicated ridesharing this vehicle will be empty, but it may be partially occupied for pooled. Dedicated vehicles will then drive until the group has reached its destination, but pooled vehicles will occasionally stop to add or drop off other groups, which adds a time penalty from the additional loading time.

## Loading Time

Loading time represents all time spent by a vehicle while it idles for passengers to load or unload. A vehicle always receives the full penalty, but it is applied differently to groups. A group incurs the full time penalty for any pickup or dropoff that is not its own. This is like waiting while a bus drops passengers off at another stop. A slow passenger will make your trip longer. For pickups and dropoffs where the group is involved, we only applied the penalty to the pickup. This is to help account for some of the factors that affect the vehicle but not the group. 


## Limitations

### Only in Steady-State

This model can only simulate ridesharing in the steady-state, meaning it should not be used to study underloaded or overloaded cases.

#### Underloaded Case
An underloaded case can occur in the simulation because the number of vehicles is always constant. In a real scenario, a low demand for rides would naturally cause fewer drivers to be willing to stay in service.

#### Overloaded Case
Neither the simulation or real services have an infinite supply of vehicles, so each can experience an arrival rate too high to service. Ridesharing services solved this problem with dynamic pricing. By raising prices at higher demand, fewer customers will be inclined to pay, thus bringing the arrival rate back to a sustainable level. The simulation does not implement pricing, and thus has no way to limit the arrival of customers.

### Constant Variables

All simulations were run with a constant arrival rate and steady number of vehicles. A real scenario would likely have a changing arrival rate and some correlation between the number of vehicles in service.

### Value of Time

Customers in the simulation have no personal value for their own time, yet alone patience. In a real scenario, if a customer is unable to summon a ride or sees a long wait time for their car to arrive, the probability of a cancellation rises considerably. In the simulation, all customers will be serviced, even if there is a long wait.

### Other Limitations
* All travel times are exact and do not account for traffic or unexpected delays.
* Groups do not have the ability to choose between a given service.
* Pooled routes are perfectly efficient. In reality, some additional time is added from slight differences between routes.

# Experiment

The hypotheses were tested by collecting two sets of data. First, the group arrival rate was varied with all other variables held constant. Second, the number of vehicles servicing the riders was varied with all other factors held constant. 

## Phase A: Equal Vehicles, Increasing Arrival Rate

Phase A will study how each model performs under various loads and find an appropriate range of arrival rates for the steady-state.

### Fixed Parameters
* Simulation Time: 6 hours
* Travel Time Average: 15 minutes
* Travel Time Standard Deviation: 3 minutes
* Vehicle Loading Time Average: 3 minutes
* Vehicle Loading Time Standard Deviation: 30 seconds
* Number of Pooled Vehicles: 100
* Number of Dedicatd Vehicles: 100

### Variable Parameters
* Arrival Rate: Increasing from 0.01 to 0.19 by 0.01 increments

## Phase B: Steady Arrival Rate, Decreasing Vehicles

From Phase A, we can find the highest arrival rate that is suitable for steady-state analysis. With that arrival rate, we can study how the pooled system performs with fewer vehicles.

### Fixed Parameters
* Simulation Time: 6 hours
* Travel Time Avgerage: 15 minutes
* Travel Time Standard Deviation: 3 minutes
* Vehicle Loading Time Average: 3 minutes
* Vehicle Loading Time Standard Deviation: 30 seconds
* Number of Dedicatd Vehicles: 100
* Arrival Rate: 0.06

### Variable Parameters
* Number of Pooled Vehicles: Decreasing from 100 to 49 by increments of 3


# Analysis

## Hypotheses

### "Fewer drivers are able to service the same number of riders."

We hypothesized that fewer vehicles are able to service the same number of riders. The main cost to ridesharing companies is driver time, so being able to transport more passengers with the same number of drivers means that cost per passenger decreases.

To prove this hypothesis, we held the number of vehicles in the simulation constant at 100. The arrival rate was then varied in order to determine the point at which the system became overloaded.

To determine the point at which the system becomes overloaded, we looked for the point where passengers had to wait at least 5 minutes for a vehicle to be assigned to them - thus indicating that new passengers were arriving more quickly than they were being dropped off. In a real-world scenario, this is the point when dynamic pricing models ("surge" or "primetime") would increase cost in order to decrease the number of passengers calling a ride.

<a href="/images/ridesharing/assignment-full.png"><img src="/images/ridesharing/assignment.png" alt="Average Time from Group Spawn to Driver Assignment as a Function of Group Arrival Rate"/></a>

The arrival rate was measured as *lambda*, which represented the probability in a given second that a new group of passengers would spawn. Thus, the average hourly arrival rate is lambda times the seconds in an hour. 

This model showed that dedicated ridesharing became overloaded between a lambda .06 and .07. Pooled ridesharing became overloaded between .11 and .12. Thus, the same number of drivers was able to service between 216 and 252 groups of passengers in a dedicated environment, and between 396 and 432 groups of passengers in a pooled environment. Because distribution of group sizes was the same between environments, we conclude that a pooled environment may service the same number of riders with fewer drivers. Furthermore, we conclude that, within our simulation parameters, about half as many drivers may service the same arrival rate of passenger groups in a pooled environment versus a dedicated environment.

If drivers' pay is considered constant per hour, independent of distance driven, then being able to service the same number of customers with half as many drivers cuts costs by about half. Thus Uber's assertion that their [pooled rides cost 40% less than dedicated rides](http://blog.uber.com/uberpool) substantiates our conclusion.


TODO - explain this 

<a href="/images/ridesharing/assignment2-full.png"><img src="/images/ridesharing/assignment2.png" alt="Average Time from Group Spawn to Driver Assignment in Pooled Vehicle Enviroment as a Function of Vehicle Quantity"/></a>




### "Pooled ridesharing has significantly higher driver utilization"

We hypothesized that, relative to dedicated drivers, pooled drivers would not have to wait between calls to pick somebody up. Instead, by constantly picking up and dropping off groups of passengers, they would rarely have zero passengers. 

To calculate the average driver utilization in a system, calculated the percentage of time that vehicles had one or more passengers assigned to that vehicle. Thus, an empty vehicle en route to pick up a passenger was considered utilized.

<a href="/images/ridesharing/util-full.png"><img src="/images/ridesharing/util.png" alt="Average Vehicle Utilization as a Function of Group Arrival Rate"/></a>

<a href="/images/ridesharing/util2-full.png"><img src="/images/ridesharing/util2.png" alt="Average Pooled Vehicle Utilization as a Function of Vehicle Quantity"/></a>

### "Pooled ridesharing takes longer for riders to arrive at the destination"

<a href="/images/ridesharing/travel-full.png"><img src="/images/ridesharing/travel.png" alt="Average Time from Group Spawn to Destination as a Function of Group Arrival Rate"/></a>
<a href="/images/ridesharing/travel2-full.png"><img src="/images/ridesharing/travel2.png" alt="Average Group Time from Pickup to Destination as a Function of Group Arrival Rate"/></a>
<a href="/images/ridesharing/travel5-full.png"><img src="/images/ridesharing/travel5.png" alt="Average Time from Group Spawn to Destination in Pooled Vehicles as a Function of Vehicle Quantity"/></a>
<a href="/images/ridesharing/travel6-full.png"><img src="/images/ridesharing/travel6.png" alt="Average Group Time from Pickup to Destination in Pooled Vehicles as a Function of Vehicle Quantity"/></a>
### "Pooled ridesharing is only efficient for one rider"

<a href="/images/ridesharing/travel3-full.png"><img src="/images/ridesharing/travel3.png" alt="Average Group Time from Pickup to Destination in Dedicated Vehicles as a Function of Group Arrival Rate"/></a>
<a href="/images/ridesharing/travel4-full.png"><img src="/images/ridesharing/travel4.png" alt="Average Group Time from Pickup to Destination as a Function of Group Arrival Rate"/></a>


## Pooled ridesharing Viability




