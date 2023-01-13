#import packages
library(tidyverse)
library(haven)

#get data
nfhs <- read_dta('IAHR52FL.dta')
#subset data to focus on less variables
hh_subset <- select(nfhs, hhid:shstruc)
#plot of household members
ggplot(data = nfhs) + 
  geom_histogram(mapping = aes(x = hv009), binwidth = 1) +
  xlab("Number of household members")

urb_subset <- filter(nfhs, hv025 == 1)

#plot of hh members by urban type
plot1 <- ggplot(data = urb_subset) +
  geom_bar(data = urb_subset, mapping = aes(x = hv009, col = factor(hv026))) +
  xlab("Number of household members") +
  scale_color_manual(labels = c("Large City", "Small City", "Town"),
                     values = c("red", "blue", "green"))
plot1

#means by place of residence
urb_type_means <- urb_subset %>% group_by(hv026)  %>%
  summarise(med_hhm = median(hv009),
            mean_hhm = mean(hv009))
view(urb_type_means)

