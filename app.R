#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#the number to find
number <- floor(runif(1,1,101))
numberGuessed <- function(guess, number) {
    returnValue <- "Nothing entered yet."
    if (guess > 100) {
        returnValue <- 'Above 100.\nPlease make a selection between 1 and 100.'
    }
    else if (guess < 1) {
        returnValue <- 'Below 1.\nPlease make a selection between 1 and 100.'
    }
    else if (guess > number) {
        returnValue <- 'Lower!'
    }
    else if (guess < number) {
        returnValue <- 'Higher!'
    }
    else if (guess == number) {
        returnValue <- 'You found the number!'
    }
    returnValue
}

ui <- fluidPage(

    # Application title
    titlePanel("Guess the number game"),
    br(),

    sidebarPanel(
        #numericInput('guess', 'Your guess', 1, min = 1, max = 100, step = 1),
        #submitButton('Submit')
        textInput('guess', 'Number', value = ""),
        h5('Please press \'Go!\' only on your first attempt'),
        actionButton("goButton", "Go!")
    ), 
    mainPanel(
        h2('Guess an integer between 1 and 100'),
        h5('The objective of this game is to guess the hidden integer between 1 and 100'),
        br(),
        h4('Your number'),
        verbatimTextOutput("inputValue"),
        verbatimTextOutput("outputValue")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$inputValue <- renderPrint({as.numeric(input$guess)})

    text <- eventReactive(input$goButton, {
        numberGuessed(as.numeric(input$guess), number)
    })
    
    output$outputValue <- renderText({ 
        text()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
