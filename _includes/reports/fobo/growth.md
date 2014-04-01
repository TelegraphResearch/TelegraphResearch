## Financial Model 
Using information about the launch date of FOBO, the week-on-week growth posted in a job listing, and the announcement that a “million dollar run rate” had been achieved in mid-March, we created a financial model for the revenue and expenses of FOBO. 

FOBO [launched on January 10, 2014](http://techcrunch.com/2014/01/10/FOBO/). According to a [Techcrunch article](http://techcrunch.com/2014/03/16/FOBO-video/), the annual run rate for 
FOBO had reached $1 million in mid-March. In a [recent job posting for a “Growth Engineer”](https://news.ycombinator.com/item?id=7478842), it was specified that week-on-week growth was 10%. 

Using this information about sales, we modeled revenue until the end of the year. FOBO charges a 15% fee for sales. However, included in this 15% fee is processing fees. Specifically, their credit card provider Stripe [charges approximately 3%](https://stripe.com/us/pricing) of transactions plus an [additional $0.25 per payout](https://stripe.com/blog/send-payouts-with-stripe) to seller bank accounts. Thus, FOBO’s net profit per sale is about 12%. 

We modeled employee growth by looking at historical information about the number of employees, then we looked at open job requisitions that imply one hire in the next month. Using that information, we applied an exponential growth estimate to the future number of employees.

One of the things the model highlighted was that FOBO’s strategy of not transferring money to buyer bank accounts until they request a payout has the potential to save significant money. By keeping an “account credit” that can be used for future payments, FOBO gets to keep the 3% fee that would normally go toward credit card processing. 



###Estimated EBITDA
<table>
    <tr>
        <th>2014 Q1</th>
        <th>2014 Q2</th>
        <th>2014 Q3</th>
        <th>2014 Q4</th>
    </tr>
    <tr>
        <td class="danger">-$160,196</td>
        <td class="danger">-$140,020</td>
        <td class="danger">-$165,662</td>
        <td class="success">$555,100</td>
    </tr>
</table>

<a href="https://docs.google.com/spreadsheets/d/1dySWBkfc3GJRBh3fKHy2iyf1VTZhLWkiF9rYW_cDbMo/edit?usp=sharing" class="btn btn-block btn-info">View the model in Google Drive</a>

To experiment with the values, add it to your own Google Drive:

```
View file in Google Drive -> File -> Make a copy... 
```

## Future Funding 

We did not account for the jump in revenue that would occur when FOBO enters a new market. Instead, we chose to quantify how long it would take to enter the San Franciso Bay market. Based on our model, it will cost FOBO approximately $500,000 to enter the San Francisco Bay market before reaching profitability in September. Thus, the most important conclusion from our model was the cost to enter a new market. 

We assumed that this cost after launch to enter the San Francisco Bay market would be approximately equal for future markets. Thus, we predict that FOBO will raise an approximately $2 million Series A funding round before July at an $8 Million valuation. This money will fuel the expansion to four additional markets, which we predict are Austin, Los Angeles, Chicago, Seattle. 

