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
shinyServer(function(input, output) {
  
  #predict horsepower
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20,0)  # if mpg >20, them mpg else 0
  model1 <- lm(hp ~ mpg, data = mtcars)
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)  # using new variable mpgsp==a spline term @ 20 mpg
  
  #input of values from user interface needs a reactive statement
  #1
  model1pred <- reactive({
  mpgInput <- input$sliderMPG  # move input into var
  # use model 1
  predict(model1, newdata = data.frame(mpg = mpgInput))  # use value from slider
})
#2
model2pred <- reactive({ 
  mpgInput <- input$sliderMPG   
  predict(model2, newdata =
            data.frame(mpg = mpgInput,
                       mpgsp = ifelse(mpgInput - 20 >0,
                                      mpgInput - 20,0)))             # add column with spline term
})
  
  output$plot1 <- renderPlot({  #ui looking for plot1
    mpgInput <- input$sliderMPG
    #plot base plot
    plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon",  
         ylab = "Horsepower", bty = "n", pch = 16, 
         xlim = c(10, 35), ylim = c(50, 350))
  if(input$showModel1){   #whether lines are going to be in there
      abline(model1, col = "red", lwd = 2) #add fit line 
    }
  if(input$showModel2){
    model2lines <- predict(model2, newdata = data.frame(
      mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35-20,0)
    ))
    lines(10:35, model2lines, col = "blue", lwd = 2)  # add line
    }
  
  legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"),pch=16, 
         col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16,cex=2)  #add points result accessed as a 
  # function - add () to return the number
    points(mpgInput, model2pred(), col = "blue", pch = 16,cex=2)  #add points
    })
  
  
    output$pred1 <- renderText({ 
      model1pred()  #show text/renderText
    })
  
  output$pred2 <- renderText({ 
    model2pred()
  })

})
