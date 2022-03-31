#Libraries

library(tidyverse)     # for data cleaning and plotting    
library(lubridate)     # for date manipulation
library(shiny)       

covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

census_pop_est_2018 <- read_csv("https://www.dropbox.com/s/6txwv3b4ng7pepe/us_census_2018_state_pop_est.csv?dl=1") %>%
  separate(state, into = c("dot","state"), extra = "merge") %>% 
  select(-dot) %>% 
  mutate(state = str_to_lower(state))

covid_with_2018_pop_est <-
  covid19 %>% 
  mutate(state = str_to_lower(state)) %>% 
  left_join(census_pop_est_2018,
            by = c("state" = "state")) %>% 
  mutate(covid_per_100000 = (as.numeric(cases)/est_pop_2018)*100000)

ui <- fluidPage(
  sliderInput(inputId = "date",
              label= "Date Range",
              min= min(covid_with_2018_pop_est$date),
              max= max(covid_with_2018_pop_est$date),
              value= c(min(covid_with_2018_pop_est$date),max(covid_with_2018_pop_est$date))),
  selectInput(inputId = "states",
              label= "States",
              choices= covid_with_2018_pop_est %>% 
                arrange(state) %>% 
                distinct(state) %>% 
                pull(state),
              multiple=TRUE),
  submitButton(text="Done!"),
  plotOutput(outputId = "statePlot")
)


server<-function(input,output){
  output$statePlot <- renderPlot({
    covid_with_2018_pop_est %>% 
      filter(state== input$states)%>%
      ggplot() +
      geom_line(aes(x= date, y=covid_per_100000, color=state))+
      labs(title="Cases per 10,000 citizens",
           y="Cases",
           x="Date")+
      scale_x_continuous(limits=input$date)
  })
}

shinyApp(ui=ui, server=server)
