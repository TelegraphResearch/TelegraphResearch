The Hired website is available at [hired.com](https://hired.com/). The website is hosted on Amazon Web Services, and the architecture lies behind elastic load balancers. The back-end is a Ruby on Rails API, and the front-end uses the Angular javascript framework. In addition, the site uses Optimizely for conversion optimization, Marketo for lead capture, New Relic for response time tracking, Mixpanel for funnel analytics, and AddThis for social integration. 

Recruiters we spoke with who use the Hired platform had concerns about the security of the system. Specifically, companies on the Hired system were victims of a phishing attack sent by a Hired email address. The malicious email reportedly appeared to be an invoice from Hired.com hosted on Google Drive. However, the link led to a phishing page that stole the recruiters’ Google Account login information.

During our [interview](http://stage.telegraphresearch.com/mickiewicz-interview/) with Co-Founder Matt Mickiewicz, he had the following to say about the incident:

> So one of our employees had their GMail account hacked. So, some phishing emails were sent from her personal email address to our employers. But it wasn’t a data breach. No one gained database access to the application or the marketplace itself. 

Based on this information, we conclude that there is not an obvious security vulnerability in the Hired system. Enforcing a security policy with two-step verification on Google accounts would prevent similar attacks in the future. 
