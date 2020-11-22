library(shiny) 
library(tidyverse) 
library(CodeClanData) 
library(DT) 
library(shinyWidgets) 
library(shinythemes)

game_data <- game_sales 

ui <- fluidPage(theme = shinytheme("slate"), 
  
  titlePanel("Game Data"), 
  
  fluidRow(
    column(3, 
           radioButtons("developer", 
                        "Developer", 
                        choices = unique(game_data$developer), 
                        inline = TRUE)) 
  ), 
  
  fluidRow(
    column(6, 
           plotOutput("developerhistogram")), 
    
    pickerInput("game", 
                "What game?", 
                choices = unique(game_data$name), 
                multiple = TRUE, 
                options = list(`action-box` = TRUE)), 
    DT::dataTableOutput("table_output") 
    
  )
) 

server <- function(input, output) {
  
  filtered_data <- reactive ({
    game_data %>% 
      select(developer, critic_score) %>% 
      filter(developer == input$developer) 
    
  }) 
  
  output$developerhistogram <- renderPlot({ 
    ggplot(filtered_data()) + 
      aes(developer, critic_score) + 
      geom_col() + 
      labs(y = "Total Critic Score", x = "Game Developer")
  }) 
  
  output$table_output <- DT::renderDataTable({  
    game_data %>% 
      filter(name == input$game)
  }) 

} 

shinyApp(ui, server)   