The FOBO iPhone app is written in Objective-C. It uses the phone’s built-in GPS to determine the local marketplace in which the user may participate. The system uses the Facebook API for authentication. The domain is hosted on Rackspace, but the marketing site is hosted on Amazon Web Services. The prior GetYardsale.com website remains online, where it is hosted on a Rackspace virtual private server.

Packet analysis of the FOBO API shows that it relies on both PubNub and Parse, which each provide application interfaces as a service. Some of the API calls to getyardsale.pubnub.com appear unauthenticated even though a valid SSL certificate is present, which may present a security vulnerability. Packet analysis shows that Stripe is used for collecting credit card information, and this likely means that Stripe is used for dispersing payments to sellers. 

No Android app is currently available. 
