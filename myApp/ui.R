#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data & Predict Horsepower from MPG"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
     
     
       #random number plot
      numericInput("numeric", "How Many Random Numbers Should be Plotted?",
                   value =1000,min=1,max=1000,step=1),
      sliderInput("sliderX", "Pick Minimmum and Maximum X Vlues",
                  -100,100,value = c(-50,50)),
      sliderInput("sliderY", "Pick Minimmum and Maximum Y Vlues",
                  -100,100,value = c(-50,50)),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title"),

       h1("Move the Slider!"),
       sliderInput("slider2", "Slide Me!",0,100,0), #slider2 - name of slider
       h2("H1 Text"),
       h3("H1 Text"),
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(

      
      h3("Graph of Random Points"),
      plotOutput("plot1"),
      h3("Slider Value:"),
      textOutput("text1"),
      h4("Main Panel Text"),  #size of text = h3
      code ("Main Panel Text"),
       plotOutput("distPlot")
    )
  )
))
