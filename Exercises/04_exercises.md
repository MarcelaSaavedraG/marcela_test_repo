---
title: 'Weekly Exercises #4'
author: "Marcela Saavedra González"
output: 
  html_document:
    keep_md: TRUE
    toc: TRUE
    toc_float: TRUE
    df_print: paged
    code_download: true
---





```r
library(tidyverse)     # for data cleaning and plotting
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
## ✓ readr   2.1.1     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(lubridate)     # for date manipulation
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

```r
library(openintro)     # for the abbr2state() function
```

```
## Loading required package: airports
```

```
## Loading required package: cherryblossom
```

```
## Loading required package: usdata
```

```r
library(palmerpenguins)# for Palmer penguin data
library(maps)          # for map data
```

```
## 
## Attaching package: 'maps'
```

```
## The following object is masked from 'package:purrr':
## 
##     map
```

```r
library(ggmap)         # for mapping points on maps
```

```
## Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
```

```
## Please cite ggmap if you use it! See citation("ggmap") for details.
```

```r
library(gplots)        # for col2hex() function
```

```
## 
## Attaching package: 'gplots'
```

```
## The following object is masked from 'package:stats':
## 
##     lowess
```

```r
library(RColorBrewer)  # for color palettes
library(sf)            # for working with spatial data
```

```
## Linking to GEOS 3.9.1, GDAL 3.2.3, PROJ 7.2.1; sf_use_s2() is TRUE
```

```r
library(leaflet)       # for highly customizable mapping
library(carData)       # for Minneapolis police stops data
library(ggthemes)      # for more themes (including theme_map())
theme_set(theme_minimal())
```


```r
# Starbucks locations
Starbucks <- read_csv("https://www.macalester.edu/~ajohns24/Data/Starbucks.csv")
```

```
## Rows: 25600 Columns: 13
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (11): Brand, Store Number, Store Name, Ownership Type, Street Address, C...
## dbl  (2): Longitude, Latitude
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
starbucks_us_by_state <- Starbucks %>% 
  filter(Country == "US") %>% 
  count(`State/Province`) %>% 
  mutate(state_name = str_to_lower(abbr2state(`State/Province`))) 

# Lisa's favorite St. Paul places - example for you to create your own data
favorite_stp_by_lisa <- tibble(
  place = c("Home", "Macalester College", "Adams Spanish Immersion", 
            "Spirit Gymnastics", "Bama & Bapa", "Now Bikes",
            "Dance Spectrum", "Pizza Luce", "Brunson's"),
  long = c(-93.1405743, -93.1712321, -93.1451796, 
           -93.1650563, -93.1542883, -93.1696608, 
           -93.1393172, -93.1524256, -93.0753863),
  lat = c(44.950576, 44.9378965, 44.9237914,
          44.9654609, 44.9295072, 44.9436813, 
          44.9399922, 44.9468848, 44.9700727)
  )

#COVID-19 data from the New York Times
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
```

```
## Rows: 40718 Columns: 5
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): state, fips
## dbl  (2): cases, deaths
## date (1): date
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Put your homework on GitHub!

If you were not able to get set up on GitHub last week, go [here](https://github.com/llendway/github_for_collaboration/blob/master/github_for_collaboration.md) and get set up first. Then, do the following (if you get stuck on a step, don't worry, I will help! You can always get started on the homework and we can figure out the GitHub piece later):

* Create a repository on GitHub, giving it a nice name so you know it is for the 4th weekly exercise assignment (follow the instructions in the document/video).  
* Copy the repo name so you can clone it to your computer. In R Studio, go to file --> New project --> Version control --> Git and follow the instructions from the document/video.  
* Download the code from this document and save it in the repository folder/project on your computer.  
* In R Studio, you should then see the .Rmd file in the upper right corner in the Git tab (along with the .Rproj file and probably .gitignore).  
* Check all the boxes of the files in the Git tab under Stage and choose commit.  
* In the commit window, write a commit message, something like "Initial upload" would be appropriate, and commit the files.  
* Either click the green up arrow in the commit window or close the commit window and click the green up arrow in the Git tab to push your changes to GitHub.  
* Refresh your GitHub page (online) and make sure the new documents have been pushed out.  
* Back in R Studio, knit the .Rmd file. When you do that, you should have two (as long as you didn't make any changes to the .Rmd file, in which case you might have three) files show up in the Git tab - an .html file and an .md file. The .md file is something we haven't seen before and is here because I included `keep_md: TRUE` in the YAML heading. The .md file is a markdown (NOT R Markdown) file that is an interim step to creating the html file. They are displayed fairly nicely in GitHub, so we want to keep it and look at it there. Click the boxes next to these two files, commit changes (remember to include a commit message), and push them (green up arrow).  
* As you work through your homework, save and commit often, push changes occasionally (maybe after you feel finished with an exercise?), and go check to see what the .md file looks like on GitHub.  
* If you have issues, let me know! This is new to many of you and may not be intuitive at first. But, I promise, you'll get the hang of it! 


## Instructions

* Put your name at the top of the document. 

* **For ALL graphs, you should include appropriate labels.** 

* Feel free to change the default theme, which I currently have set to `theme_minimal()`. 

* Use good coding practice. Read the short sections on good code with [pipes](https://style.tidyverse.org/pipes.html) and [ggplot2](https://style.tidyverse.org/ggplot2.html). **This is part of your grade!**

* When you are finished with ALL the exercises, uncomment the options at the top so your document looks nicer. Don't do it before then, or else you might miss some important warnings and messages.


## Warm-up exercises from tutorial

These exercises will reiterate what you learned in the "Mapping data with R" tutorial. If you haven't gone through the tutorial yet, you should do that first.

### Starbucks locations (`ggmap`)

  1. Add the `Starbucks` locations to a world map. Add an aesthetic to the world map that sets the color of the points according to the ownership type. What, if anything, can you deduce from this visualization?  
  

```r
world <- get_stamenmap(
    bbox = c(left = -180, bottom = -57, right = 179, top = 82.1), 
    maptype = "terrain",
    zoom = 2)
```

```
## Source : http://tile.stamen.com/terrain/2/0/0.png
```

```
## Source : http://tile.stamen.com/terrain/2/1/0.png
```

```
## Source : http://tile.stamen.com/terrain/2/2/0.png
```

```
## Source : http://tile.stamen.com/terrain/2/3/0.png
```

```
## Source : http://tile.stamen.com/terrain/2/0/1.png
```

```
## Source : http://tile.stamen.com/terrain/2/1/1.png
```

```
## Source : http://tile.stamen.com/terrain/2/2/1.png
```

```
## Source : http://tile.stamen.com/terrain/2/3/1.png
```

```
## Source : http://tile.stamen.com/terrain/2/0/2.png
```

```
## Source : http://tile.stamen.com/terrain/2/1/2.png
```

```
## Source : http://tile.stamen.com/terrain/2/2/2.png
```

```
## Source : http://tile.stamen.com/terrain/2/3/2.png
```
  

```r
ggmap(world) + 
  geom_point(data = Starbucks, 
             aes(x = Longitude, y = Latitude, color= `Ownership Type`), 
             alpha = 0.3, 
             size = 0.1) +
  scale_fill_viridis_c(option = "inferno") +
  theme_map() +
  labs(title="World map locations of Starbucks by ownership type")+
  theme(legend.background = element_blank())
```

```
## Warning: Removed 1 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-2-1.png)<!-- -->
I can deduce that in the American continent most Starbucks are licensed or company owned.Such is the case for almost every other region except for East Asia, where most businesses are joint ventures. Also, Most of the Starbucks seems to concentrate in North America and East Asia. 

  2. Construct a new map of Starbucks locations in the Twin Cities metro area (approximately the 5 county metro area).  
  

```r
saint_paul <- get_stamenmap(
    bbox = c(left = -93.4775, bottom = 44.8240, right = -92.7992, top = 45.1615), 
    maptype = "terrain",
    zoom = 11)
```

```
## Source : http://tile.stamen.com/terrain/11/492/735.png
```

```
## Source : http://tile.stamen.com/terrain/11/493/735.png
```

```
## Source : http://tile.stamen.com/terrain/11/494/735.png
```

```
## Source : http://tile.stamen.com/terrain/11/495/735.png
```

```
## Source : http://tile.stamen.com/terrain/11/496/735.png
```

```
## Source : http://tile.stamen.com/terrain/11/492/736.png
```

```
## Source : http://tile.stamen.com/terrain/11/493/736.png
```

```
## Source : http://tile.stamen.com/terrain/11/494/736.png
```

```
## Source : http://tile.stamen.com/terrain/11/495/736.png
```

```
## Source : http://tile.stamen.com/terrain/11/496/736.png
```

```
## Source : http://tile.stamen.com/terrain/11/492/737.png
```

```
## Source : http://tile.stamen.com/terrain/11/493/737.png
```

```
## Source : http://tile.stamen.com/terrain/11/494/737.png
```

```
## Source : http://tile.stamen.com/terrain/11/495/737.png
```

```
## Source : http://tile.stamen.com/terrain/11/496/737.png
```

```
## Source : http://tile.stamen.com/terrain/11/492/738.png
```

```
## Source : http://tile.stamen.com/terrain/11/493/738.png
```

```
## Source : http://tile.stamen.com/terrain/11/494/738.png
```

```
## Source : http://tile.stamen.com/terrain/11/495/738.png
```

```
## Source : http://tile.stamen.com/terrain/11/496/738.png
```


```r
ggmap(saint_paul) + 
  geom_point(data = Starbucks, 
             aes(x = Longitude, y = Latitude), 
             alpha = 0.3, 
             size = 1) +
  scale_fill_viridis_c(option = "inferno") +
  theme_map() +
  labs(title="Saint Paul locations of Starbucks")+
  theme(legend.background = element_blank())
```

```
## Warning: Removed 25493 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
  

  3. In the Twin Cities plot, play with the zoom number. What does it do?  (just describe what it does - don't actually include more than one map).
  
  It changes the details in the graphs such as clear terrain delimitation and clear region labels.

  4. Try a couple different map types (see `get_stamenmap()` in help and look at `maptype`). Include a map with one of the other map types.  
  

```r
saint_paul2 <- get_stamenmap(
    bbox = c(left = -93.4775, bottom = 44.8240, right = -92.7992, top = 45.1615), 
    maptype = "toner-background",
    zoom = 11)
```

```
## Source : http://tile.stamen.com/toner-background/11/492/735.png
```

```
## Source : http://tile.stamen.com/toner-background/11/493/735.png
```

```
## Source : http://tile.stamen.com/toner-background/11/494/735.png
```

```
## Source : http://tile.stamen.com/toner-background/11/495/735.png
```

```
## Source : http://tile.stamen.com/toner-background/11/496/735.png
```

```
## Source : http://tile.stamen.com/toner-background/11/492/736.png
```

```
## Source : http://tile.stamen.com/toner-background/11/493/736.png
```

```
## Source : http://tile.stamen.com/toner-background/11/494/736.png
```

```
## Source : http://tile.stamen.com/toner-background/11/495/736.png
```

```
## Source : http://tile.stamen.com/toner-background/11/496/736.png
```

```
## Source : http://tile.stamen.com/toner-background/11/492/737.png
```

```
## Source : http://tile.stamen.com/toner-background/11/493/737.png
```

```
## Source : http://tile.stamen.com/toner-background/11/494/737.png
```

```
## Source : http://tile.stamen.com/toner-background/11/495/737.png
```

```
## Source : http://tile.stamen.com/toner-background/11/496/737.png
```

```
## Source : http://tile.stamen.com/toner-background/11/492/738.png
```

```
## Source : http://tile.stamen.com/toner-background/11/493/738.png
```

```
## Source : http://tile.stamen.com/toner-background/11/494/738.png
```

```
## Source : http://tile.stamen.com/toner-background/11/495/738.png
```

```
## Source : http://tile.stamen.com/toner-background/11/496/738.png
```
  

```r
ggmap(saint_paul2) + 
  geom_point(data = Starbucks, 
             aes(x = Longitude, y = Latitude), 
             alpha = 0.3, 
             size = 1) +
  scale_fill_viridis_c(option = "inferno") +
  theme_map() +
  labs(title="Saint Paul locations of Starbucks")+
  theme(legend.background = element_blank())
```

```
## Warning: Removed 25493 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

  5. Add a point to the map that indicates Macalester College and label it appropriately. There are many ways you can do think, but I think it's easiest with the `annotate()` function (see `ggplot2` cheatsheet).
  


```r
ggmap(saint_paul) + 
  geom_point(data = Starbucks, 
             aes(x = Longitude, y = Latitude), 
             alpha = 0.3, 
             size = 1) +
  annotate('rect',xmin= -93.1766, ymin= 44.9402, xmax= -93.1620, ymax= 44.9354, col="red", fill="red")+
   annotate('text', x=-93.1766, y=45.0, label = 'Macalester College', colour = I('red'), size = 5)+
 annotate('segment', x=-93.1766, xend= -93.175, y=44.990, yend=44.950,
 colour=I('red'), arrow = arrow(length=unit(0.3,"cm")), size = 1.5) +
  scale_fill_viridis_c(option = "inferno") +
  theme_map() +
  labs(title="Saint Paul locations of Starbucks")+
  theme(legend.background = element_blank())
```

```
## Warning: Removed 25493 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


### Choropleth maps with Starbucks data (`geom_map()`)

The example I showed in the tutorial did not account for population of each state in the map. In the code below, a new variable is created, `starbucks_per_10000`, that gives the number of Starbucks per 10,000 people. It is in the `starbucks_with_2018_pop_est` dataset.


```r
census_pop_est_2018 <- read_csv("https://www.dropbox.com/s/6txwv3b4ng7pepe/us_census_2018_state_pop_est.csv?dl=1") %>% 
  separate(state, into = c("dot","state"), extra = "merge") %>% 
  select(-dot) %>% 
  mutate(state = str_to_lower(state))
```

```
## Rows: 51 Columns: 2
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): state
## dbl (1): est_pop_2018
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
starbucks_with_2018_pop_est <-
  starbucks_us_by_state %>% 
  left_join(census_pop_est_2018,
            by = c("state_name" = "state")) %>% 
  mutate(starbucks_per_10000 = (n/est_pop_2018)*10000)
```

  6. **`dplyr` review**: Look through the code above and describe what each line of code does.
  
  First line reads in the data set saved in dropbox. 
  Second line separates a variable that initially included valued of the name state with a dot into two where the dot is apart from the name
  Third line omits the column that only includes the dot
  Fourth line modifies the column state for the values to be all lower case.
  
  First and second line of second part creates a new data set using the starbucks_us_by_state data set
  Third and fourth Line joins the starbucks_us_by_state to the census_pop_est_2018 by the name of the state to get a data set that not only has the starbucks per state but also the population per state.
  Fifth line creates a variable starbucks_per_10000 by dividing the number of starbucks per state by their population and multiplying by 10000

  7. Create a choropleth map that shows the number of Starbucks per 10,000 people on a map of the US. Use a new fill color, add points for all Starbucks in the US (except Hawaii and Alaska), add an informative title for the plot, and include a caption that says who created the plot (you!). Make a conclusion about what you observe.
  

```r
states_map <- map_data("state")


starbucks_with_2018_pop_est %>% 
  ggplot() +
  geom_map(map = states_map,
           aes(map_id = state_name,
               fill = starbucks_per_10000)) +
  geom_point(data= Starbucks %>% 
    filter("state_name"!="hawaii|alaska",
           Country == "US"),
    aes(x=Longitude,y=Latitude),
    size = 0.05,
    alpha= 0.02,
    color= "goldenrod")+
  expand_limits(x = states_map$long, y = states_map$lat) + 
  theme_map()+
  theme(legend.background = element_blank())
```

![](04_exercises_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
  

### A few of your favorite things (`leaflet`)

  8. In this exercise, you are going to create a single map of some of your favorite places! The end result will be one map that satisfies the criteria below. 

  * Create a data set using the `tibble()` function that has 10-15 rows of your favorite places. The columns will be the name of the location, the latitude, the longitude, and a column that indicates if it is in your top 3 favorite locations or not. For an example of how to use `tibble()`, look at the `favorite_stp_by_lisa` I created in the data R code chunk at the beginning.  
  

```r
favorite_stp_by_Marcela <- tibble(
  place = c("Buffalo Wild Wings", "Macalester College", "Master Noodle", 
            "Stadium", "Whole Foods", "Wet Paint",
            "Pad Thai", "GrandView Theater", "CVS", "Spanish House"),
  long = c(-93.165937, -93.1712321, -93.156745, 
           -93.1650563, -93.166927, -93.172050, 
           -93.171422, -93.177650, -93.177076, -93.170317),
  lat = c(44.943604, 44.9378965, 44.955839,
          44.952555, 44.946689, 44.940048, 
          44.940158, 44.940055, 44.940446, 44.935609)
  )
```


  * Create a `leaflet` map that uses circles to indicate your favorite places. Label them with the name of the place. Choose the base map you like best. Color your 3 favorite places differently than the ones that are not in your top 3 (HINT: `colorFactor()`). Add a legend that explains what the colors mean.  
  

```r
leaflet(favorite_stp_by_Marcela) %>% 
  addTiles() %>% 
  addCircles()
```

```
## Assuming "long" and "lat" are longitude and latitude, respectively
```

```{=html}
<div id="htmlwidget-cced5fd12ff71142f869" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-cced5fd12ff71142f869">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircles","args":[[44.943604,44.9378965,44.955839,44.952555,44.946689,44.940048,44.940158,44.940055,44.940446,44.935609],[-93.165937,-93.1712321,-93.156745,-93.1650563,-93.166927,-93.17205,-93.171422,-93.17765,-93.177076,-93.170317],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null,null]}],"limits":{"lat":[44.935609,44.955839],"lng":[-93.17765,-93.156745]}},"evals":[],"jsHooks":[]}</script>
```

  
  * Connect all your locations together with a line in a meaningful way (you may need to order them differently in the original data). 
  

```r
leaflet(favorite_stp_by_Marcela) %>% 
  addTiles() %>% 
  addCircles() %>% 
  addPolylines(lng= ~long,
               lat= ~lat,
               color=col2hex("goldenrod"))
```

```
## Assuming "long" and "lat" are longitude and latitude, respectively
```

```{=html}
<div id="htmlwidget-66dacca7a696f9f65652" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-66dacca7a696f9f65652">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircles","args":[[44.943604,44.9378965,44.955839,44.952555,44.946689,44.940048,44.940158,44.940055,44.940446,44.935609],[-93.165937,-93.1712321,-93.156745,-93.1650563,-93.166927,-93.17205,-93.171422,-93.17765,-93.177076,-93.170317],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null,null]},{"method":"addPolylines","args":[[[[{"lng":[-93.165937,-93.1712321,-93.156745,-93.1650563,-93.166927,-93.17205,-93.171422,-93.17765,-93.177076,-93.170317],"lat":[44.943604,44.9378965,44.955839,44.952555,44.946689,44.940048,44.940158,44.940055,44.940446,44.935609]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"#DAA520","weight":5,"opacity":0.5,"fill":false,"fillColor":"#DAA520","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[44.935609,44.955839],"lng":[-93.17765,-93.156745]}},"evals":[],"jsHooks":[]}</script>
```

  
  * If there are other variables you want to add that could enhance your plot, do that now.
  
Wanted to add the labels :) 


```r
leaflet(favorite_stp_by_Marcela) %>% 
  addTiles() %>% 
  addCircles(label= ~place) %>% 
  addPolylines(lng= ~long,
               lat= ~lat,
               color=col2hex("goldenrod"))
```

```
## Assuming "long" and "lat" are longitude and latitude, respectively
```

```{=html}
<div id="htmlwidget-f919d2a120061d4ec278" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-f919d2a120061d4ec278">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircles","args":[[44.943604,44.9378965,44.955839,44.952555,44.946689,44.940048,44.940158,44.940055,44.940446,44.935609],[-93.165937,-93.1712321,-93.156745,-93.1650563,-93.166927,-93.17205,-93.171422,-93.17765,-93.177076,-93.170317],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["Buffalo Wild Wings","Macalester College","Master Noodle","Stadium","Whole Foods","Wet Paint","Pad Thai","GrandView Theater","CVS","Spanish House"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null,null]},{"method":"addPolylines","args":[[[[{"lng":[-93.165937,-93.1712321,-93.156745,-93.1650563,-93.166927,-93.17205,-93.171422,-93.17765,-93.177076,-93.170317],"lat":[44.943604,44.9378965,44.955839,44.952555,44.946689,44.940048,44.940158,44.940055,44.940446,44.935609]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"#DAA520","weight":5,"opacity":0.5,"fill":false,"fillColor":"#DAA520","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[44.935609,44.955839],"lng":[-93.17765,-93.156745]}},"evals":[],"jsHooks":[]}</script>
```
  
## Revisiting old datasets

This section will revisit some datasets we have used previously and bring in a mapping component. 

### Bicycle-Use Patterns

The data come from Washington, DC and cover the last quarter of 2014.

Two data tables are available:

- `Trips` contains records of individual rentals
- `Stations` gives the locations of the bike rental stations

Here is the code to read in the data. We do this a little differently than usualy, which is why it is included here rather than at the top of this file. To avoid repeatedly re-reading the files, start the data import chunk with `{r cache = TRUE}` rather than the usual `{r}`. This code reads in the large dataset right away.


```r
data_site <- 
  "https://www.macalester.edu/~dshuman1/data/112/2014-Q4-Trips-History-Data.rds" 
Trips <- readRDS(gzcon(url(data_site)))
Stations<-read_csv("http://www.macalester.edu/~dshuman1/data/112/DC-Stations.csv")
```

```
## Rows: 347 Columns: 5
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): name
## dbl (4): lat, long, nbBikes, nbEmptyDocks
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

  9. Use the latitude and longitude variables in `Stations` to make a visualization of the total number of departures from each station in the `Trips` data. Use either color or size to show the variation in number of departures. This time, plot the points on top of a map. Use any of the mapping tools you'd like.
  

```r
departures_per_station <- Trips %>% 
  group_by(sstation) %>% 
  summarize(departures_per_sstation = n())

station_joined <- Stations %>% 
  left_join(departures_per_station,
            by = c("name" = "sstation"))

washington <- get_stamenmap(
  bbox = c(left = -77.2622, bottom= 38.8208, right= -76.7660, top= 38.9897),
  maptype = "terrain",
  zoom = 11
)
```

```
## Source : http://tile.stamen.com/terrain/11/584/782.png
```

```
## Source : http://tile.stamen.com/terrain/11/585/782.png
```

```
## Source : http://tile.stamen.com/terrain/11/586/782.png
```

```
## Source : http://tile.stamen.com/terrain/11/587/782.png
```

```
## Source : http://tile.stamen.com/terrain/11/584/783.png
```

```
## Source : http://tile.stamen.com/terrain/11/585/783.png
```

```
## Source : http://tile.stamen.com/terrain/11/586/783.png
```

```
## Source : http://tile.stamen.com/terrain/11/587/783.png
```

```
## Source : http://tile.stamen.com/terrain/11/584/784.png
```

```
## Source : http://tile.stamen.com/terrain/11/585/784.png
```

```
## Source : http://tile.stamen.com/terrain/11/586/784.png
```

```
## Source : http://tile.stamen.com/terrain/11/587/784.png
```

```r
ggmap(washington) +
  geom_point(data= station_joined,
             aes(x= long, y= lat, color= departures_per_sstation))+
  theme_map()+
  theme(legend.background = element_blank())
```

```
## Warning: Removed 45 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-15-1.png)<!-- -->
  
  10. Only 14.4% of the trips in our data are carried out by casual users. Create a plot that shows which area(s) have stations with a much higher percentage of departures by casual users. What patterns do you notice? Also plot this on top of a map. I think it will be more clear what the patterns are.
  

```r
casual_rider <- Trips %>% 
  group_by(sstation) %>% 
  summarise(casual= sum(client == "Casual"),ntotal=n()) %>% 
  mutate(portionCasual= casual/ntotal) %>% 
  left_join(Stations, by=c("sstation"="name")) 

ggmap(washington)+
  geom_point(data= casual_rider,
             aes(x=long, y=lat, color= portionCasual))+
  scale_color_viridis_c()
```

```
## Warning: Removed 55 rows containing missing values (geom_point).
```

![](04_exercises_files/figure-html/unnamed-chunk-16-1.png)<!-- -->
  
### COVID-19 data

The following exercises will use the COVID-19 data from the NYT.

  11. Create a map that colors the states by the most recent cumulative number of COVID-19 cases (remember, these data report cumulative numbers so you don't need to compute that). Describe what you see. What is the problem with this map?
  

```r
states_map <- map_data("state")

covid19 %>% 
  mutate(state = str_to_lower(state)) %>% 
  ggplot()+
  geom_map(map= states_map,
           aes(map_id = state,
               fill= fips))+
  expand_limits(x= states_map$long, y= states_map$lat)+
  theme_map()
```

![](04_exercises_files/figure-html/unnamed-chunk-17-1.png)<!-- -->
It is not really intuitive what is going on in this graph given that the legend colors has so many arguments of similar tone. Also, given that we are not accounting for population, it might give a misleading perception of cases per state. 
  
  12. Now add the population of each state to the dataset and color the states by most recent cumulative cases/10,000 people. See the code for doing this with the Starbucks data. You will need to make some modifications. 
  

```r
covid_with_2018_pop_est <-
  covid19 %>% 
  mutate(state = str_to_lower(state)) %>% 
  left_join(census_pop_est_2018,
            by = c("state" = "state")) %>% 
  mutate(covid_per_10000 = (as.numeric(fips)/est_pop_2018)*10000)

covid_with_2018_pop_est %>% 
  ggplot()+
  geom_map(map= states_map,
           aes(map_id = state,
               fill= covid_per_10000))+
  expand_limits(x= states_map$long, y= states_map$lat)+
  theme_map()
```

![](04_exercises_files/figure-html/unnamed-chunk-18-1.png)<!-- -->
  
Now we are able to differentiate the severity of the cumulative cases per state relative to their total population.
  
  13. **CHALLENGE** Choose 4 dates spread over the time period of the data and create the same map as in exercise 12 for each of the dates. Display the four graphs together using faceting. What do you notice?
  
## Minneapolis police stops

These exercises use the datasets `MplsStops` and `MplsDemo` from the `carData` library. Search for them in Help to find out more information.

  14. Use the `MplsStops` dataset to find out how many stops there were for each neighborhood and the proportion of stops that were for a suspicious vehicle or person. Sort the results from most to least number of stops. Save this as a dataset called `mpls_suspicious` and display the table.  
  

```r
mpls_suspicious <- MplsStops %>% 
  group_by(neighborhood) %>% 
  summarize(cases_per_neighborhood = n(),
            suspicious_prop = sum(problem == "suspicious")/cases_per_neighborhood)

head(mpls_suspicious)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["neighborhood"],"name":[1],"type":["fct"],"align":["left"]},{"label":["cases_per_neighborhood"],"name":[2],"type":["int"],"align":["right"]},{"label":["suspicious_prop"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"Armatage","2":"77","3":"0.8441558"},{"1":"Audubon Park","2":"554","3":"0.3718412"},{"1":"Bancroft","2":"134","3":"0.8432836"},{"1":"Beltrami","2":"211","3":"0.2511848"},{"1":"Bottineau","2":"377","3":"0.2546419"},{"1":"Bryant","2":"96","3":"0.8020833"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
head(MplsStops)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["idNum"],"name":[1],"type":["fct"],"align":["left"]},{"label":["date"],"name":[2],"type":["dttm"],"align":["right"]},{"label":["problem"],"name":[3],"type":["fct"],"align":["left"]},{"label":["MDC"],"name":[4],"type":["fct"],"align":["left"]},{"label":["citationIssued"],"name":[5],"type":["fct"],"align":["left"]},{"label":["personSearch"],"name":[6],"type":["fct"],"align":["left"]},{"label":["vehicleSearch"],"name":[7],"type":["fct"],"align":["left"]},{"label":["preRace"],"name":[8],"type":["fct"],"align":["left"]},{"label":["race"],"name":[9],"type":["fct"],"align":["left"]},{"label":["gender"],"name":[10],"type":["fct"],"align":["left"]},{"label":["lat"],"name":[11],"type":["dbl"],"align":["right"]},{"label":["long"],"name":[12],"type":["dbl"],"align":["right"]},{"label":["policePrecinct"],"name":[13],"type":["int"],"align":["right"]},{"label":["neighborhood"],"name":[14],"type":["fct"],"align":["left"]}],"data":[{"1":"17-000003","2":"2017-01-01 00:00:42","3":"suspicious","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"Unknown","10":"Unknown","11":"44.96662","12":"-93.24646","13":"1","14":"Cedar Riverside","_rn_":"6823"},{"1":"17-000007","2":"2017-01-01 00:03:07","3":"suspicious","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"Unknown","10":"Male","11":"44.98045","12":"-93.27134","13":"1","14":"Downtown West","_rn_":"6824"},{"1":"17-000073","2":"2017-01-01 00:23:15","3":"traffic","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"White","10":"Female","11":"44.94835","12":"-93.27538","13":"5","14":"Whittier","_rn_":"6825"},{"1":"17-000092","2":"2017-01-01 00:33:48","3":"suspicious","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"East African","10":"Male","11":"44.94836","12":"-93.28135","13":"5","14":"Whittier","_rn_":"6826"},{"1":"17-000098","2":"2017-01-01 00:37:58","3":"traffic","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"White","10":"Female","11":"44.97908","12":"-93.26208","13":"1","14":"Downtown West","_rn_":"6827"},{"1":"17-000111","2":"2017-01-01 00:46:48","3":"traffic","4":"MDC","5":"NA","6":"NO","7":"NO","8":"Unknown","9":"East African","10":"Male","11":"44.98054","12":"-93.26363","13":"1","14":"Downtown West","_rn_":"6828"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

  
  15. Use a `leaflet` map and the `MplsStops` dataset to display each of the stops on a map as a small point. Color the points differently depending on whether they were for suspicious vehicle/person or a traffic stop (the `problem` variable). HINTS: use `addCircleMarkers`, set `stroke = FAlSE`, use `colorFactor()` to create a palette. 
  

```r
suspicious <- colorFactor("viridis",
                          domain = MplsStops$problem)


leaflet(data= MplsStops) %>% 
  addTiles() %>% 
  addCircleMarkers(lng= ~long,
                   lat= ~lat,
                   label= ~problem,
                   color= ~suspicious(problem),
                   stroke = FALSE)
```

```{=html}
<div id="htmlwidget-874655e0c82656cf46af" style="width:672px;height:480px;" class="leaflet html-widget"></div>
```

  
  16. Save the folder from moodle called Minneapolis_Neighborhoods into your project/repository folder for this assignment. Make sure the folder is called Minneapolis_Neighborhoods. Use the code below to read in the data and make sure to **delete the `eval=FALSE`**. Although it looks like it only links to the .sph file, you need the entire folder of files to create the `mpls_nbhd` data set. These data contain information about the geometries of the Minneapolis neighborhoods. Using the `mpls_nbhd` dataset as the base file, join the `mpls_suspicious` and `MplsDemo` datasets to it by neighborhood (careful, they are named different things in the different files). Call this new dataset `mpls_all`.


```r
mpls_nbhd <- st_read("Minneapolis_Neighborhoods/Minneapolis_Neighborhoods.shp", quiet = TRUE)
```

  17. Use `leaflet` to create a map from the `mpls_all` data  that colors the neighborhoods by `prop_suspicious`. Display the neighborhood name as you scroll over it. Describe what you observe in the map.
  
  18. Use `leaflet` to create a map of your own choosing. Come up with a question you want to try to answer and use the map to help answer that question. Describe what your map shows. 
  
  
## GitHub link

  19. Below, provide a link to your GitHub page with this set of Weekly Exercises. Specifically, if the name of the file is 04_exercises.Rmd, provide a link to the 04_exercises.md file, which is the one that will be most readable on GitHub.


**DID YOU REMEMBER TO UNCOMMENT THE OPTIONS AT THE TOP?**