library(shiny)
shinyUI(pageWithSidebar(
    # Application title
    headerPanel("Exercise with Iris dataset"),
    # Sidebar Panel
    sidebarPanel(
        # Radio buttons to select plot variables
        radioButtons("magn",h4("What to plot?"),
            c("Petal Lenght versus Petal Width"=3,
              "Sepal Length versus Sepal Width"=1)),
        # Slider to select number of records
        sliderInput("samp",h4("Number of items to plot:"), value=75,
                    min=15, max=150, step=15,),
        # Check boxes for extra summary data
        checkboxGroupInput("chkb", h4("Show me the following summary data:"),
            c("Correlation"=1,"Intercept"=2,"Beta coefficient"=3,
              "Residual standard error"=4,"Multiple R-squared"=5),),
        # Numeric input and button for surprise
        h4('Numeric input for surprise (0-100):'),
        numericInput('tks','',100,min=0,max=100), 
        actionButton("goButton","Click if you liked it!")
        ),   
    # Main Panel
    mainPanel(
        # Plot of selected variables and number of records
        plotOutput('PetalPlot'),
        # Summary data selectable as text output
        h4('You requested the following summary data:'),
        textOutput ("checkb"),
        # Text output of final surprise
        h3(textOutput("gracias"))
    )
))