#Initialization
library(shiny)
data(iris)
nomb <- names(iris)
#spv <- sample(c(1:150),size=75)
#col <- 1
char = character(5)
shinyServer(
    function(input, output) {
        #Reactive operations to speed up: subset, columns and linear regression
        spv <- reactive({sample(c(1:150),size=input$samp)})
        col <- reactive({as.numeric(input$magn)})
        fit <- reactive({lm(iris[spv(),col()] ~ iris[spv(),col()+1],data=iris)})
        #Render plot
        output$PetalPlot <- renderPlot({
            plot(iris[spv(),col()+1],iris[spv(),col()],col=iris$Species[spv()],
                 xlab=nomb[col()+1],ylab=nomb[col()],
                main=paste(substr(nomb[col()],1,5),
                "plot with a random sample of",input$samp,"records"))
            abline(fit(), col="blue")
            })  
        #Render summary data
        output$checkb <- renderPrint({
            #Correlation
            char[1]<-paste("Correlation=",round(cor(iris[spv(),col()+1],
                iris[spv(),col()]),2))
            #Intercept
            char[2]<-paste("Intercept=",round(fit()$coef[1],2))
            #Beta coefficient
            char[3]<-paste("Beta=",round(fit()$coef[2],2))
            #Residual standard error
            char[4]<-paste("Sigma=",round(summary(fit())$sigma,2))
            #R-squared
            char[5]<-paste("R-squared=",round(summary(fit())$r.squared,2)) 
            char[as.numeric(input$chkb)]
            })
        #Process Go Button
        output$gracias <- renderText({
            if (input$goButton != 0) {
                paste(input$tks,"times Thank You!!")}
            })
    }
)