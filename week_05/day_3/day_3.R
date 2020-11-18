library(shinythemes)
library(shiny) 
library(tidyverse) 

olympics_medal_data <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage( 
  theme = shinytheme("yeti"), 
  
  titlePanel(tags$h2("Five Country Medal Comparison")), 
  
  fluidRow(
    column(4, 
      radioButtons(
        inputId = "season", 
        label = tags$i("Choose season"), 
        choices = c("Winter", "Summer")
      )
    ), 
    column(4, 
      radioButtons(
        inputId = "medal", 
        label = tags$i("Choose medal"), 
        choices = c("Gold", "Silver", "Bronze")
      )
    ), 
    column(4, 
          plotOutput(outputId = "medal_plot"))
  )
  )

server <- function(input, output){
  
  output$medal_plot <- renderPlot({
    color <- case_when(input$medal == "Gold" ~ "#ffdb4d", 
                       input$medal == "Silver" ~ "#b3b3b3", 
                       input$medal == "Bronze" ~ "#cc9900")
    olympics_medal_data %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$medal) %>%
      filter(season == input$season) %>%
      ggplot() +
      aes(x = team, y = count) +
      geom_col(fill = color)
  }) 
} 

shinyApp(ui = ui, server = server) 