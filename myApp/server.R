#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {  #defining a function
  
  
#Random plot
output$plot1 <- renderPlot({ set.seed(2016-05-25)   #plot -> render plot  
  # curly braces /reactive experssions interacting with server calcs
  #assign to variable names
  number_of_points <- input$numeric 
  minX <- input$sliderX[1]  # first element of the vector
  maxX <- input$sliderX[2]  #second element of the vector
  minY <- input$sliderY[1]
  maxY <- input$sliderY[2]
  dataX <- runif(number_of_points, minX, maxX) 
  dataY <- runif(number_of_points, minY, maxY)
  xlab <- ifelse(input$show_xlab, "X Axis", "")  # show checkbox is checked show text else show nada
  ylab <- ifelse(input$show_ylab, "Y Axis", "") 
  main <- ifelse(input$show_title, "Title", "") 
  plot(dataX, dataY, xlab = xlab, ylab = ylab, main=main,
       xlim = c(-100, 100), ylim = c(-100, 100))
})
  
  
  output$text1 = renderText(input$slider2) # take in slider 2 and render it and anem it text 1
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
