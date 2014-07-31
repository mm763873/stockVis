# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive({  
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  finalInput <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  
  output$text1 = renderText({ 
    paste("You have selected:", input$symb)
  })
  
  output$plot <- renderPlot({
    chartSeries(finalInput(), theme = chartTheme("black"), 
        type = "line", log.scale = input$log, TA = NULL)
  })
  
})
