
library(sf)
library(tidyverse) 




shape <- st_read("data/statsnzterritorial-authority-2018-generalised-SHP/territorial-authority-2018-generalised.shp")

shape_simple <- st_simplify(shape, dTolerance = 1000)

employed_2018 <- read_csv("data/stats_edited.csv")


# added test to last row to make character for example
Datatypelist <- shape_simple %>% 
  summarise_all(class)
Datatypelist


# Datatypelist2 <- employed_2018_2 %>% 
#   summarise_all(class)
# Datatypelist

summary(shape_simple)

shape_simple %>%
  st_geometry()%>%
  plot()


## Data manipulation




# join on the description 

shape2 <- shape_simple%>%
  merge(.,
        employed_2018,
        by.x="TA2018_V_1", 
        by.y="Area_Description")





shape3 <- shape_simple %>%
  mutate(TA2018_V1_=(as.numeric(TA2018_V1_)))%>%
  merge(.,
        employed_2018,
        by.x="TA2018_V1_", 
        by.y="Area_Code")

#or 

# shape3 <- shape %>%
#   transform(., TA2018_V1_ = as.numeric(TA2018_V1_))%>%
#   merge(.,
#         employed_2018,
#         by.x="TA2018_V1_", 
#         by.y="Area_Code")

# or also 
#shape$TA2018_V1_ = as.numeric(shape$TA2018_V1_)


## Data mapping


library(tmap)
tmap_mode("plot")
# change the fill to your column name if different
my_map<-shape2 %>%
  qtm(.,fill = "Paid employee")

my_map
