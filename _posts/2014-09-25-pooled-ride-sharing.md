---
layout: note
title: Quantitative Analysis of Pooled Ride Sharing
shortTitle: Ride Sharing
Description: Data 
label: ridesharing
category: Note
authors: ['philip', 'andrew']
---


In the past few months, pooled transportation options have emerged in the multi-billion dollar ride sharing industry. Pooled ride sharing fills a niche between taxis and buses where riders can get low-priced, door-to-door transportation by sharing a vehicle with strangers traveling along a similar route. 

Ride share company Sidecar [was the first to market with pooled ride sharing in May](http://techcrunch.com/2014/06/29/sidecar-shareable-rides/). The company that originally caught our attention in the area was [Hitch](http://www.takehitch.com/), a ride-sharing company focused solely on pooled rides. Since Hitch’s [launch in June](http://techcrunch.com/2014/06/11/hitch-ride-share/), both ride share giants Lyft and Uber have implemented test programs for pooled ride sharing using their existing driver bases in the San francisco Bay area. 

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

To understand how pooled ride sharing differs from dedicated ride sharing as a system, we built a simulation in Python to analyze travel metrics between the two methodologies. The code is available on Github: https://github.com/telegraphresearch/vehicle-sim

## Model
We based pooled ride sharing on the Hitch model where drivers continuously pick up and drop off passengers. 

 ## Groups

A group represents a set of people ranging from 1 to 3 passengers that are travelling together. The upper bound of 3 is defined by the maximum capacity allowed for Hitch. Each group has a unique travel time, in seconds, that is the exact time needed to travel from its current location to the destination. This value is normally distributed among groups to model the different types of routes that people are likely to request.

## Vehicles

To accurately test the differences between dedicated and pooled ride-sharing services, vehicles between each system are identical except for one experimental variable. This variable is whether a vehicle is able to pick up a group given its current state. Dedicated vehicles will be unavailable when containing one group, even if that group is just one passenger. Pooled vehicles determine availability by current passenger capacity. If a pooled vehicle has one group of size 1, it is still available to pick up one group of size 2, or two groups of size 1.


Between the two types of services, all other vehicle characteristics are the same. Each vehicle has a maximum capacity of 3 passengers, and the distributions for group pick up time and group loading time are the same. Group pick up time represents the amount of time that a group must wait for an assigned vehicle to travel to pick it up. Group loading time represents the amount of time that a vehicle is idle while it loads or unloads people. Both of these values are normally distributed. For group pick up time, this value varies based on the location of the vehicle when it is assigned to a group. It will always be nearby, never a constant distance, and more likely to fall within a range of values. The same assumption can be made for group loading time. The time for a vehicle to pick up passengers and get back underway can vary for many different reasons. It may take some time for the group to exit a building, or the vehicle might have to circle around the block and flag down its customers. Again, this value likely hovers between a certain range with higher and lower values occurring less often. The values for group pick up time and group loading time are also in seconds.

## Simulation

Using our definitions for group and vehicle, we created a simulation to effectively model both pooled and dedicated ride-sharing services in the steady-state. To create useful data, there must be a steady, constant supply of both customers and vehicles. Under these conditions, all groups would be assigned to a vehicle within an expected range of values; in other words, a vehicle will always be close enough to a group. Deliberately incorporating actual routes into each group’s trip was not necessary and instead, the group’s generated travel time was used instead.

Once a group is picked up, the group’s travel time is decremented for each second that the vehicle is underway. A dedicated ride-sharing vehicle will constantly decrement time until it reaches 0, at which point the group is at its destination. A pooled vehicle will also also dec time while it travels, but it is susceptible to time penalties by adding or removing other groups. These time penalties directly correspond to the loading times for adding and removing groups, because the vehicle is idle. Pooled ride-sharing groups are paired together if they have a similar route. Because of this, we did not add in any additional travel time to pick up another group. Although the existing implementations sometimes go out of their way to add groups, we felt that the steady-state model should not incur an extra time because an at-scale system should have enough granularity to pair near-perfect routes.

## A Long, Long Road

With the added simplifications, the model can be pictured as a straight, infinite, one-way road along which vehicles travel at a constant speed. Groups appear along the side of it and request to be carried down the road to a certain point. Given the strict speed limit, this distance easily translates into time. A group is assigned to the closest available vehicle; for dedicated ride-sharing this vehicle will be empty, but it may be partially occupied for pooled. Dedicated vehicles will then drive until the group has reached its destination, but pooled vehicles will occasionally stop to add or drop off other groups, which adds a time penalty from the additional loading time.

## Loading Time

Loading time represents all time spent by a vehicle to pick up or drop off a group and get back underway, and it is generated at each occurrence. A vehicle always receives the full penalty, but is applied differently to groups. A group incurs the full time penalty for any pickup or dropoff that is not its own as it is waiting for the vehicle to continue driving towards its destination. For pickups and dropoffs where the group is involved, we applied the time penalty to the pickup but not the dropoff in order to compensate for many different factors. This can be anything from the driver waiting for the group to exit a building or trying to find the group on a crowded curb.

## Limitations

This model can only simulate ride-sharing in the steady-state, meaning it should not be used to study underloaded or overloaded cases. An underloaded case can occur in the model because the number of vehicles is always constant. In a real scenario, a lower demand for rides would naturally cause fewer drivers to be willing to stay in service. However, neither the model or ride-sharing services have an infinite supply of vehicles, so each experiences an arrival rate too high to service. Ride-sharing services solved this problem with dynamic pricing. By raising prices at higher demand, fewer customers will be inclined to pay, thus bringing the arrival rate back to a sustainable level. The model does not implement pricing, and thus has no method to limit the arrival of customers with said method.

All simulations were run with a constant arrival rate and steady number of vehicles. A real scenario would have both a changing arrival rate and number of vehicles in service. It is likely that, except for times with high arrival rates and increased dynamic pricing, these two values are highly correlated in accordance with the concept of supply and demand.

Customers in the model have no personal value for their own time, yet alone patience. In a real scenario, if a customer is unable to summon a ride or sees a long wait time for their car to arrive, the probability of a cancellation rises considerably. In this model, all customers will be serviced, even if there is a long wait.


Additional limitations to add:
traffic and other delays - the travel time we generate is exact
people can choose between dedicated and pooled based on what is more practical


# Conclusions

## Hypothesis

### "Pooled ride sharing has significantly higher driver utilization"

### "Pooled ride sharing takes longer for riders to arrive at the destination"

### "Pooled ride sharing is only efficient for one rider"

### "Fewer drivers are able to service the same number of riders."

## Pooled Ride Sharing Viability


IT ROCKS YO
