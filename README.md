# WatchStocks
A simple Apple Watch OS 2 application that keeps track of your stocks portfolio &amp; displays amounts gained or lost in a day. The app also includes a complication that shows this data right on the watch face. 
All HTTP requests are handled by the open source API at (https://github.com/willedflipper66/StocksAPI) 

##What works

- View a summary of your portfolio including: day's gain, total gain (%), total gain ($)
- View gains for individual stocks and their current market prices
- All monetary amounts shown are in Canadian Dollars (CAD)

##To Do

- Add functionality to add transaction details through iPhone. Currently this needs to be done manually in the Parameters.swift file.
- Add detailed views
- Add charts
- Add support for more complication layouts
- Implement automatic complication update. Currently the complication is only updated if the user opens the app
- Add support for dividends
- Add functionality to select currency. All values shown currently are in CAD
- Add functionality on the back end to determine currency of a stock. In its current implementation, the server simply looks for the string "NASDAQ" or "NYSE" in the query term, and if found converts it from USD to CAD based on the API provided by http://fixer.io

##Screenshots

![App view](https://raw.githubusercontent.com/willedflipper66/WatchStocks/master/Screenshots/IMG_0746.PNG "App view")
![Complication view](https://raw.githubusercontent.com/willedflipper66/WatchStocks/master/Screenshots/IMG_0747.PNG "Complication view")
