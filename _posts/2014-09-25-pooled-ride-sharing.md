---
layout: note
title: Quantitative Analysis of Pooled Ride Sharing
shortTitle: Ride Sharing
Description: Data
label: ridesharing
category: Analysis
authors: ['philip', 'andrew']
---


In the past few months, pooled transportation options have emerged in the multi-billion dollar ride sharing industry. Pooled ride sharing fills a niche between taxis and buses where riders can get low-priced, door-to-door transportation by sharing a vehicle with strangers traveling along a similar route. 

Ride share company Sidecar [was the first to market with pooled ride sharing in May](http://techcrunch.com/2014/06/29/sidecar-shareable-rides/). The company that originally caught our attention in the area was [Hitch](http://www.takehitch.com/), a ride sharing company focused solely on pooled rides. Since Hitch’s [launch in June](http://techcrunch.com/2014/06/11/hitch-ride-share/), both ride share giants Lyft and Uber have implemented test programs for pooled ride sharing using their existing driver bases in the San francisco Bay area. 

Compared to traditional “dedicated” ride sharing where a customer commissions a full vehicle, Telegraph Research sought to quantify four hypotheses about pooled ride sharing.

1. **Hypothesis** - Pooled ride sharing has significantly higher driver utilization
2. **Hypothesis** - Pooled ride sharing takes longer for riders to arrive at the destination
3. **Hypothesis** - Pooled ride sharing is only efficient for one rider
4. **Hypothesis** - Fewer drivers are able to service the same number of riders.

In order to validate these hypotheses and to evaluate the feasibility of pooled rides in the ride share industry, Telegraph Research developed a simulation of pooled ride sharing. 

<div class="alert alert-warning">
    During publication, it was announced that <a href="http://blog.lyft.com/posts/2014/9/22/lyft-acquires-hitch-to-accelerate-lyft-line-expansion">Lyft had acquired Hitch.</a>.
</div>


# Pooled Ride Sharing Basics

## Implementations
The companies Hitch, Lyft, and Uber take slightly different approaches to a similar concept. 

### Hitch
Hitch was available in San Francisco through an iPhone app. Drivers are currently paid a flat hourly rate. Groups size, which must be specified before pickup, may range from one to three passengers.

Cars are treated like buses that continually pick up and drop off users between dynamically-routed locations. After picking up a rider, other passengers may be picked up or dropped off on the way to a destination. In this sense, a busy driver may never have an empty car. 

### Lyft Line
Lyft Line is available in San Francisco. All standard Lyft drivers (excluding Lyft Premium) are eligible to be assigned pooled rides. Riders are given a strict 60 second window after the driver arrives to enter the car, and cars only pick up two parties of people. Riders are given guaranteed prices, and drivers are paid the combined fares of the parties. 

Parties are paired based on similarities between their pickup location, destination, and travel route. In this sense, drivers are not dynamically routed, but are assigned a full route consisting of no more than two pickups and two dropoffs. 

### Uber Pool
Uber Pool is available in limited beta in the San Francisco Bay. All UberX drivers are eligible to be tasked Uber Pool fares. Uber pool strictly allows only parties of one person, and a maximum of two passengers are in an Uber Pool during the course of the ride. 

Riders are paired based on their pickup location and destination with another rider traveling a similar route. In this sense, drivers are not dynamically routed, but are assigned a full route consisting of no more than two pickups and two dropoffs. 
## Advantages of Pooled Rides
Traditional ride sharing apps do not charge based on the number of passengers. Instead they charge based on capacity, which generally is 3 riders for a standard car and 5 for a standard SUV. 

For single riders, such as commuters, purchasing three seats of capacity for a trip is not financially efficient. For this reason, Uber introduced fare splitting to allow riders to split charges. 

By optimizing for single riders, costs decrease. However, ride time increases. 

## Niche
It is not uncommon to see pooled rides cost between $3 and $5 for door-to-door service in an urban environment, compared to comparable $6 to $8 for a dedicated car. One-way transit on public transit costs about $2 (SF Muni). 

Compared to public transportation, pooled ride shares are typically faster due to fewer stops and more comfortable due to fewer passengers. However, arrival time is less predictable - buses run on precise time schedules; ride shares make no estimates about arrival time. 

## Opportunity
Due to the low price, pooled ride sharing becomes more feasible for commuters and thus more directly competes with public transportation. Attracting commuters brings recurring revenue, and hence will likely drive the growth of pooled ride sharing.

Pooled ride sharing primarily works in urban environments where fewer customers own cars or where parking is a significant expense. 

Business riders, for example those traveling to airports, are less likely to be cost-sensitive if they plan to expense the ride. Hence, they are unlikely to use pooled ride sharing. 

## Brand and Culture

Lyft has always promoted social rides by encouraging riders to sit in the front seat, fist bump drivers, and have a friendly conversation during the ride. 

The Uber brand does not promote a social aspect, but they treat Uber Pool as a “Social experiment.” The brand originated as a premium service, and even in their cheaper UberX line drivers often act as chauffeurs. 

This dichotomy in brands will become apparent in pooled ride sharing. If riders engage socially, it seems that the Lyft brand would encourage drivers to participate and hence make the ride more comfortable. It is unclear whether Uber encourages pool drivers to engage with customers.

# Simulation

To understand how pooled ride sharing differs from dedicated ride sharing as a system, we built a simulation in Python to analyze travel metrics between the two methodologies. The code is [available on Github](https://github.com/telegraphresearch/vehicle-sim).

## Model

The simulation has 2 different models that represent the two methods being compared: pooled and dedicated ride sharing. We based our pooled ride sharing simulation on the Hitch model where drivers continuously pick up and drop off passengers. The dedicated ride sharing model is based off the existing standard, where drivers service one group at a time.

### System Variables
Arrival Rate: The rate at which a new group enters the simulation. This is modeled as a binomial poisson distribution and determined by a variable lamda. At every second, a group has a given probability of being randomly generated.
Vehicle Quantity: The number of vehicles that are allocated to a given model.

## Groups

A group represents a set of people that are travelling together. For consistency in testing, every group is tested in both models to study how each model reacts to the same exact routes. The variables for a group are defined below:

### Variables
* Size: 1 to 3 passengers. Upper bound of 3 is defined by the maximum capacity allowed for Hitch.
* Travel Time (seconds): The exact time needed to travel from current location to the destination; randomly generated and normally distributed.

## Vehicles

A vehicle is the entity that services a group. The fundamental difference between a pooled and dedicated ride sharing vehicle is what determines whether it is able to pick up a passenger. It will serve as the sole experimental variable for the simulation, while all others will remain constant. The variables for a vehicle are defined below:

### Variables
* [Experimental] - Available for Pickup (boolean): Dedicated vheicles will be unavailable when containing one group. Pooled vehicles determine availability by the number of available seats compared to the size of a requesting group.
* Capacity: The number of seats; set at 3.
* Group Loading Time (seconds): The amount of time that a vehicle is idle while it loads or unloads people; values are randomly generated on a normal distribution.
* Group Pickup Time (seconds): The amount of time that a group must wait for an assigned vehicle to arrive; values are randomly generated on a normal distribution.

If a pooled vehicle has one group of size 1, it is still available to pick up one group of size 2, or two groups of size 1.

Values for Group Pickup Time vary based on the location of the vehicle when it is assigned to a group. It will always be nearby, never a constant distance, and more likely to fall within a range of values. The same assumption can be made for Group Loading Time. The time for a vehicle to pick up passengers and get back underway can vary for many different reasons. It may take some time for the group to exit a building, or the vehicle might have to circle around the block and flag down its customers.

## Steady-State Modeling

Using the defined group and vehicle, the simulation can be used to effectively model pooled and dedicated ride sharing services in the steady-state. Under these conditions, there must be a steady, constant supply of both groups and vehicles, with assignments occuring within an expected range of values. Deliberately incorporating actual routes into each group’s trip was not necessary and instead, the group’s Travel Time can be used to represent distance travelled.

## Modeling Distance as Time

Once a group is picked up, the its Travel Time is decremented for each second that the vehicle is underway. A dedicated ride sharing vehicle will constantly decrement time until it reaches 0, at which point it is at the destination. A pooled vehicle will also also decrement time while it travels, but it is susceptible to time penalties from other groups. These time penalties correspond to the loading times for adding and removing groups because the vehicle is idle during that time.

## A Long, Long Road

With the added simplifications, the simulation can be pictured as a straight, infinite, one-way road along which vehicles travel at a constant speed. Groups appear along the side of it and request to be carried down the road to a certain point. A group is assigned to the closest available vehicle; for dedicated ride sharing this vehicle will be empty, but it may be partially occupied for pooled. Dedicated vehicles will then drive until the group has reached its destination, but pooled vehicles will occasionally stop to add or drop off other groups, which adds a time penalty from the additional loading time.

## Loading Time

Loading time represents all time spent by a vehicle while it idles for passengers to load or unload. A vehicle always receives the full penalty, but it is applied differently to groups. A group incurs the full time penalty for any pickup or dropoff that is not its own. This is like waiting while a bus drops passengers off at another stop. A slow passenger will make your trip longer. For pickups and dropoffs where the group is involved, we only applied the penalty to the pickup. This is to help account for some of the factors that affect the vehicle but not the group. It is not a perfect abstraction, but is good enough.

## Limitations

### Only in Steady-State

This model can only simulate ride sharing in the steady-state, meaning it should not be used to study underloaded or overloaded cases.

#### Underlaoded Case
An underloaded case can occur in the simulation because the number of vehicles is always constant. In a real scenario, a low demand for rides would naturally cause fewer drivers to be willing to stay in service.

#### Overloaded Case
Neither the simulation or real services have an infinite supply of vehicles, so each can experience an arrival rate too high to service. Ride sharing services solved this problem with dynamic pricing. By raising prices at higher demand, fewer customers will be inclined to pay, thus bringing the arrival rate back to a sustainable level. The simulation does not implement pricing, and thus has no way to limit the arrival of customers.

### Constant Variables

All simulations were run with a constant arrival rate and steady number of vehicles. A real scenario would likely have a changing arrival rate and some correlation between the number of vehicles in service.

### Value of Time

Customers in the simulation have no personal value for their own time, yet alone patience. In a real scenario, if a customer is unable to summon a ride or sees a long wait time for their car to arrive, the probability of a cancellation rises considerably. In the simulation, all customers will be serviced, even if there is a long wait.

### Other Limitations
* All travel times are exact and do not account for traffic or unexpected delays.
* Groups do not have the ability to choose between a given service.
* Pooled routes are perfectly efficient. In reality, some additional time is added from slight differences between routes.

# Experiment

The simulation can test all 4 hypotheses in just two phases.

## Phase A: Equal Vehicles, Increasing Arrival Rate

Phase A will study how each model performs under various loads and find an appropriate range of arrival rates for the steady-state.

### Fixed Parameters
* Simulation Time: 6 hours
* Travel Time Avgerage: 15 minutes
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


# Conclusions

## Hypothesis

### "Pooled ride sharing has significantly higher driver utilization"

### "Pooled ride sharing takes longer for riders to arrive at the destination"

### "Pooled ride sharing is only efficient for one rider"

### "Fewer drivers are able to service the same number of riders."

## Pooled Ride Sharing Viability


IT ROCKS YO
