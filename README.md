# Bid-Fin

In this project we are going to use several API's to gather data on residential housing. Users can search for houses, review data, place bids, and see other bids. Active bids will show as pins on a map.

You will be using the following tools and API's
- [Google Map Javascript](https://developers.google.com/maps/documentation/javascript/) (or equivelent)
- [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/intro)
- [Zillow API](http://www.zillow.com/howto/api/APIOverview.htm)
- [WalkScore API](https://www.walkscore.com/professional/api.php)
- [ShutUpSeattle API](http://shutupseattle.com/#/api)

Requirements
---------

- As a guest I can sign up and sign in using:
  - Email
  - Password (not saved in the db)
  - Password Confirmation (sign up only)
- As a guest I can see a map of my current area
  - I can see a pin for a location which has had a bid in the past 30 days
- I can enter an address in a search bar to search for an address
- I can click on a pin on the map to find an address
- When an address is found a popup/sidebar/modal/info section displays information about the house including:
  - 10 highest bids (highlighted if current user placed them)
  - From [Zillow API](http://www.zillow.com/howto/api/APIOverview.htm):
    - Price of last sale
    - Zestimate
    - RentZestimate
    - Address
    - Size
    - Number of beds/bath
    - Lot size
    - Year built
    - [Photos](http://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm)
    - (be sure to adhere to the Zillow ToS and guidelines)
  - Walk score from [Walk Score](https://www.walkscore.com/professional/api.php)
  - Shut Up Seattle Score from [ShutUpSeattle](http://shutupseattle.com/#/api) (if the location is in Seattle, otherwise don't show it)
- As a signed in user:
  - When viewing a property, I can Place a new bid
  - I can view my account where I can:
    - View my account details
    - View bids I've placed (highlighed if I'm the highest bidder)
    - Delete any bid I've placed
- As a signed out user
  - I can reset my password:
    1. An email is sent with a special link to reset my email address
    2. I click on the link from my email and land on a page to add a new email address
    3. When submitted my email address is updated in the db
- Style
- Deploy
- Other
  - When a bid is placed, the old highest bidder (if one exists) should receive an email notifying them that they were outbid
  - List neighborhood data with a location from Zillow or Trulia.com
  - Add visual graph of bid history also showing Zestimate.

- bourbon documentation
  - [bourbon documentation](http://bourbon.io/docs/)
    - Bourbon gives you access to "default styles".  For example, it has some shortcuts key words for buttons, text decoration, animations, etc
  - [bourbon neat documentation](http://thoughtbot.github.io/neat-docs/latest/)
    - Control # of columns something should span (http://thoughtbot.github.io/neat-docs/latest/#span-columns).
      - Ex:  
      .element {
        @include span-columns(6);

     .nested-element {
       @include span-columns(2 of 6);
       }
     }
     - outer-container: similar to "container" in bootstrap:
      - Ex:
      .element {
        @include outer-container(960px);
        }

        ** this sets container width to 960px.
        *** .element is would be equal to the ID or class set for that html item (ie. <div class='element'></div>, etc)

    - shift: similar to "offset" in bootstrap. Shifts an element horizontally by the number of columns specified
      - Ex:
      .element {
        @include shift(3);
        }

    - Other resource links:
      - [Treehouse on Bourbon](http://blog.teamtreehouse.com/introduction-neat-semantic-sass-grid)
