library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)

# Load data
load("I:/.shortcut-targets-by-id/1ehWwunuAo7CE1Vk2JYkUnQMmxh5pph3C/DATA/house_prices.rda")

# (1a) Create line plots using facet_wrap
p1 <- ggplot(house_prices, aes(x = date, y = house_price_index)) +
  geom_line() +
  facet_wrap(~state) +
  scale_x_continuous(breaks = ymd(c("1980-01-01", "2000-01-01", "2020-01-01")), labels = c("80", "00", "20"))
  labs(title = "House Price Index Trend by State",
       x = "Year",
       y = "House Price Index")

print(p1)


# (1b) Use gather() to reshape data
house_prices%>%gather("measure", "value", -state, -house_price_perc, -date)->house_reshaped

head(house_reshaped)

p2 <- ggplot(house_reshaped, aes(x = date, y = value, color=measure)) +
  geom_line() +
  facet_wrap(~state) +
  scale_x_continuous(breaks = ymd(c("1980-01-01", "2000-01-01", "2020-01-01")), labels = c("80", "00", "20"))
  labs(title = "House Price Index Trend by State",
       x = "Year",
       y = "House Price Index")

print(p2)

# (2) Load house_prices.rda in R, perform the following operation, and 
#     explain how it changes the original data set. Then, create facet_wrap plot
#     which can visualize your values for each state and colorize the lines 
#     based on the measurement, i.e., unemploy_perc and house_perc. 

house_prices%>%gather(key=measure, value=value, -c(house_price_index, date, state))->house_reshaped

head(house_reshaped)

# This provides a very similar result as in question 1b above, replacing house_price_index with house_price_perc

p3 <- ggplot(house_reshaped, aes(x = date, y = value, color=measure)) +
  geom_line() +
  facet_wrap(~state) +
  scale_x_continuous(breaks = ymd(c("1980-01-01", "2000-01-01", "2020-01-01")), labels = c("80", "00", "20"))
labs(title = "House Price Percent Trend by State",
     x = "Year",
     y = "House Price Percent")

print(p3)