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
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(
    sidebarPanel(
      #predict horsepower
      sliderInput("sliderMPG", "What is the MPG of thecar?",10,35,value=20), #default=20, range 10-35
      checkboxInput("showModel1", "Show/Hide Model 1", value=TRUE),  #checkbox show model output or not
      checkboxInput("showModel2", "Show/Hide Model 2", value=TRUE),
      submitButton("Submit")  # will re-run when input changes after entering the button
    ),
    
    mainPanel(
      #predict horsepower
      plotOutput("plot1"),  #plot1 = plot function
      h3("Predicted Horsepower from Model 1:"), 
      textOutput("pred1"),  #output from prediction 1 /output from server = pred1
      h3("Predicted Horsepower from Model 2:"), 
      textOutput("pred2")
    )
  )
))