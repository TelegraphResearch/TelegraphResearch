###Financial Model

To determine the financial status of Hired.com, we built a financial model to estimate the number of job placements made. We based this model on a funnel analysis of candidates every month from their first auction to present and extended our model outlook to the fourth quarter of 2014. 

Several important metrics from news articles were used to build the model. First, we found that Hired.com averages between 40 and 50 candidates per auction, and this number has appeared to be constant since the first auction, which completed in September 2012. In the model, we assume a constant 45 candidates per auction. According to the Hired.com homepage, 85% of candidates receive an offer. This means that about 38 candidates receive an offer per auction. The most important metric, which Matt declined to share during our interview, is how many of these 38 offers are accepted every auction. We found that the entire model was dependent on this vital statistic, so we attempted to make it the only independent variable. 

For candidates who accept an offer, Hired earns 1% of their salary per month for the first 24 months of employment. According to the [Forbes in October of last year](http://www.forbes.com/sites/jjcolao/2013/10/30/hired-com-has-built-what-every-tech-company-wants-a-pipeline-of-top-technical-talent/), the average salary offer is $128,000. CEO Matt Mickiewicz stated in our interview that this offer number is reflective of the final salary 90% of the time, so we assumed that the average salary for every placement was $128,000. 

Hired is paid for the first 24 months of a job placement, but our model covers only 27 months. Based on our research, most technology companies such as [Google and Amazon](http://www.slate.com/blogs/business_insider/2013/07/28/turnover_rates_by_company_how_amazon_google_and_others_stack_up.html) have a median employee retention of twelve months. Thus, we modeled the number of candidates that continue to earn Hired a placement payout based on a monthly attrition. We chose 5% monthly attrition because it puts the average employee retention at about twelve months, which we believe closely reflects the technology industry. For simplicity in the 27-month model, we did not cut off referral payouts after 24 months and instead solely relied on attrition. 

Currently, Hired completes one auction every week, but when they launched it was one auction every two weeks. We modeled this using exponential growth from 2 auctions per month (about biweekly) at launch to 4.3 auctions per month (weekly) at present, then left the auctions per week constant in the future. 

We assumed that operating expenses for Hired.com were directly proportional to the number of employees. With an average employee salary at Hired of an estimated $100,000 per year, we then calculated that the full cost to the company per employee is approximately $160,000 per year, per employee. This figure includes salary, benefits, equipment, and office space per employee. Expenses such as web hosting were assumed to be negligible. With a known number of 29 employees at present, we assumed that the company had about 15 employees at launch in 2012, then used an exponential growth curve to model the number of employees from launch until the end of 2014. 

We found two other sources of monthly expenses for Hired. The first is the $2000 signing bonus that Hired directly awards candidates that accept offers through their marketplace. The second was added to the model after what seemed to be extraordinary profit margins.

Based on our research, Hired appears to use advertising to secure job candidates for auctions. Known numbers of [3000 applicants per month in September 2013](http://techcrunch.com/2013/09/17/developer-auction-is-hired-com/) and approximately 4000 candidates per month in February 2014 (calculated from Hired marketing material) were used as data points to build an exponential growth model of the number of applicants that Hired received to fill their 50 candidate slots per auction. 

Assuming that these applicants were acquired exclusively using advertisements, we reviewed cost per click metrics in Google Adwords and LinkedIn Ads to determine an approximate cost of applicant acquisition of about $3. Thus, we assumed that in February 2014, Hired spent about $12,000 on advertising to acquire 4000 applicants. 

During our conversation with Matt, he stated that the New York office was already profitable. We were unsure of whether this meant that the whole company was profitable. The most vital metric in our research came from a blog post by one of Hired’s investors. [Semil Shaw stated in an October 2013 blog post that Hired was doubling revenue on a quarterly basis, and in October 2013 was already profitable](http://blog.semilshah.com/2013/10/24/the-story-behind-my-first-investment-hired-com/). Thus, we used these metrics plus a starting revenue of zero to calibrate the number of candidates that accepted offers - the secret metric that CEO Matt declined to mention.

Based on our discussion with Matt, he stated that the number of job applicants and the number of open positions through clients grew inline, so we assumed that the percentage of candidates that accepted an offer would remain fairly constant. However, we decided to have a slight increase in this metric over time to reflect increased efficiency and name recognition. 

Based on our model, we estimate that, at present, about 40% of candidates that receive an offer accept a job through Hired. Our model shows that the company became profitable between September and October of 2013. In January 2013, Hired raised a $2.7 million venture round. Based on our model, between raising that round in January and reaching breakeven, about $700,000 was lost, thus leaving a considerable cash position for the business. This appears inline with the statement in investor Semil Shaw’s same blog post about their January 2013 funding round: “They didn’t need to raise money.”

####February 2014 Auction Estimates

| Applicants Per Week | Candidates per Weekly Auction | Candidate who Receive Offers | Candidates who Accept Offer |
| :----: | :--: | :--: | :--: |
| 1000 | 45 | 38 | 15 |


####Estimated EBITDA

| 2013 Q3 | 2013 Q4 | 2014 Q1 | 2014 Q2 | 2014 Q3 | 2014 Q4 |
| :---- | :---- | :----- | :----- |
| -$125,183 | $78,222 | $322,865 | $622,131 | $845,451 | $992,130 |

[Click here to view the model in Google Drive.](https://docs.google.com/spreadsheet/ccc?key=0AvQtqc6_wGbXdFBYWDFpTjkyejctdHVGaG44SmFyN0E&usp=sharing)

To experiment with the values, add it to your own Google Drive:

```
View file in Google Drive -> File -> Make a copy... 
```

###Future Funding

Based on our model, Hired will net nearly a quarter million dollars in profit per month by the end of 2014. Do they need to raise additional funding?

To continue with their current business, it is clear that city-by-city expansion may be self-funded. In our interview, Matt stated that they would be expanding to more cities this year. Seattle, Chicago, and Austin seem to be the obvious choices. 

However, Matt also stated in the interview that Hired would become a “career marketplace for workers in the world.” Thus, we predict that by the end of 2014 Hired will become sufficiently successful in technical recruiting to begin expanding to additional industries, such as science, design, and manufacturing. To accomplish this, we expect Hired to raise a Series A near the end of 2014 to fund a horizontal expansion into new industries at a pre-money valuation of approximately $70 million. 