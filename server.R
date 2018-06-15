## Server Logic To Define
source("svm.R")

library(shiny)
library(sqldf)
library(e1071)
require(gsubfn)
require(proto)
require(RSQLite)
#require(reshape2)
#install.packages("sqldf")

# Define server logic required
shinyServer(function(input, output) {


  observeEvent(input$pred,{

    output$Heartresult <- renderTable({

    age <- as.numeric(as.character(input$ageinpt))

    sex <- as.factor(input$gender)

    chestpaintype <- as.factor(input$cp)

    restingbp <- as.numeric(as.character(input$restingbp))

    cholestrol <- as.numeric(as.character(input$cholestrol))

    fastingbloodsugar <- as.factor(input$fastingbp)

    electrocardiographic <- as.factor(input$restcg)

    maximumheartrate <- as.numeric(as.character(input$maxheartrate))

    exerciseangina<- as.factor(input$exang)

    oldpeak <- as.numeric(as.character(input$oldpeak))

    slopeofpeakexercise <- as.factor(input$slope)

    ca <- as.factor(input$ca)

    thal <- as.factor(input$thal)
    #num <- as.factor(0)

    HeartTestData <- data.frame("Age" = age, "Sex" = sex, "chesp pain type" = chestpaintype,
                                "resting.bp" = restingbp, "cholestrol" = cholestrol,
                                "fasting.blood.sugar" = fastingbloodsugar, "electrocardiographic" = electrocardiographic,
                                "max.heart.rate" = maximumheartrate, "exercise.induced.angina" = exerciseangina,
                                "oldpeak" = oldpeak, "slope.of.peak.exercise" = slopeofpeakexercise, "ca" = ca, "thal" = thal, stringsAsFactors = FALSE)

    write.csv(HeartTestData, file="hearttestData.csv", row.names = FALSE)

    csvTestData <- read.csv("hearttestData.csv")

    db<-dbConnect(SQLite(), dbname="diseasedb")

    sqldf("attach 'diseasedb' as new")


    dbWriteTable(conn = db, name = "Heart", value = csvTestData , row.names= FALSE, header = FALSE, append = TRUE)

    HeartDiseaseData <- dbReadTable(db,"Heart")

    namesFactor <- c(2:3,6:7,9,11:13)

    namesNumeric <- c(1,4:5,8,10)

    HeartDiseaseData[,namesNumeric] <- lapply(HeartDiseaseData[,namesNumeric], as.numeric)

    HeartTestData <- tail(HeartDiseaseData,1)
    Heartmodel <- svm(formula = num ~ .,
                      data = training_set,
                      type = 'C-classification',
                      kernel = 'linear')
  #  Heartresult <- predict(Heartmodel,HeartTestData)
  })


  })






  # ds <- c(output$Age)
  # df <- data.frame(ds)

  observeEvent(input$pred,{output$Heartresult <- renderText(svm1())})
  observeEvent(input$accc,{output$accuracy1 <- renderText(accuracy())})

  }

  )


