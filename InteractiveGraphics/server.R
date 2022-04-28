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
  model <- reactive({
    brushed_data <- brushedPoints(trees, input$brush1,  #data set =trees  graphing data from brush 1
                                  xvar = "Girth", yvar = "Volume")
    if(nrow(brushed_data)<2){
      return(NULL)
    }
    lm(Volume ~ Girth, data = brushed_data)  # see #16 fit a linear model
  })
  output$slopeOut <- renderText({   #telling shiny to render text in UI
       if(is.null(model())){ 
       "No Model Found"
        } else { 
          model()[[1]][2]  # grab the slope term
        } 
    })

output$intOut <- renderText({ 
  if(is.null(model())){
      "No Model Found"
  } else {
    model()[[1]][1]
    } 
    })
    output$plot1 <- renderPlot({   #{ reactive curly braces}
       plot(trees$Girth, trees$Volume, xlab = "Girth",
           ylab = "Volume", main = "Tree Measurements",
           cex = 1.5, pch = 16, bty = "n")   # cex   pch     bty
        if(!is.null(model())){
             abline(model(), col = "blue", lwd = 2)  # add line
        }
      })
})
