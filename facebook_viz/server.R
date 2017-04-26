library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(GGally)
library(scales)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  facebook <- read.csv('dataset_Facebook.csv',sep=';')
  facebook$Post.Month <- as.factor(facebook$Post.Month)
  facebook$Post.Weekday <- as.factor(facebook$Post.Weekday)
  facebook$Post.Hour <- as.factor(facebook$Post.Hour)
  
  output$parcoordplot <- renderPlotly({
        
    ggplotly(
      ggparcoord(facebook, c(16:19), groupColumn = 'Type', scale='globalminmax', title = 'Social Media Interactions by Post Type')+
        scale_y_continuous(labels=comma)+
        scale_x_discrete(labels=c('Comment','Like','Share','Total Interactions'))+
        ylab("Count")+
        scale_color_manual(values=c("#00a3b2", "#b2b2ff", "#708fae","#3b62ce"))+
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_text(),
          panel.background = element_blank(),
          panel.grid.major = element_line(colour='grey'),
          panel.border = element_rect(color = 'grey', fill=NA)
        )
    )
    
  })
  # ADD MORE COLUMNS
  output$scattermatrix <- renderPlot(
  ggpairs(facebook, 16:19, 
            upper=list(combo = 'facethist'),
            diag=list(continuous = 'density'),
          columnLabels = c('Comment Count','Like Count','Share Count','Total Interactions'))+
      theme_bw()+
    ggtitle('Scatterplot Matrix and Distributions of Interaction Types')+
    theme(
      plot.title = element_text(hjust=0.5, size=24)
    )

    )
    
  output$bubbleplot <- renderPlotly({
    ggplotly(ggplot(facebook, aes(x=log(Lifetime.Post.Total.Impressions),
                                  y=log(Lifetime.Post.Total.Reach),
                                  label=Type))+
               xlab('Log(Lifetime Post Total Impressions)')+
               ylab('Log(Lifetime Post Total Reach)')+
               ggtitle('Reach and Impressions by Media Type and Interaction Count')+
               geom_point(aes(size=Total.Interactions, colour=Type, alpha=0.02))+
               scale_color_manual(values=c("#00a3b2", "#b2b2ff", "#708fae","#3b62ce"))+
               theme(panel.background = element_blank(),
                           panel.grid.major = element_line(colour='grey'),
                           panel.border = element_rect(color = 'grey', fill=NA)))
  })
  
})




