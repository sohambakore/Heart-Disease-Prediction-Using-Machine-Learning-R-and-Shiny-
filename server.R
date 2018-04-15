## Server Logic To Define 
source("svm.R")

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  

  output$Age <- renderText(as.numeric(input$age))
  output$gender <- renderText(input$gender)
  output$cp <- renderText(input$cp)
  output$restingbp <- renderText(input$restingbp)
  output$cholestrol <- renderText(input$cholestrol)
  output$fastingbp <- renderText(input$fastingbp)
  output$restcg <- renderText(input$restcg)
  output$thalach <- renderText(input$thalach)
  output$exang <- renderText(input$exang)
  output$oldpeak <- renderText(input$oldpeak)
  output$slope <- renderText(input$slope)
  output$ca <- renderText(input$ca)
  output$thal <- renderText(input$thal)
   
  # ds <- c(output$Age)
  # df <- data.frame(ds)
  
  observeEvent(input$pred,{output$result <- renderText(svm1())})
  #observeEvent(input$pred,{output$table1 <- renderDataTable(svm1())})
  observeEvent(input$accc,{output$accuracy1 <- renderText(accuracy())})
 
})
