library(shiny)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  navbarPage("Facebook Social Media Interaction Visualization",
            
  
  # Sidebar with a slider input for number of bins 

    
    # Show a plot of the generated distribution
  tabPanel("Media Type Parallel Coordinates Plot",
           plotlyOutput("parcoordplot", height='450%', width='100%')
  ),
  tabPanel("Scatterplot Matrix of Media Interactions",
           plotOutput("scattermatrix")
  ),
  tabPanel("Impressions versus Reach Bubble Plot",
           plotlyOutput("bubbleplot", height='450%', width='100%')
  )
    
  )
)

)
