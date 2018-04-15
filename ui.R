
library(shiny)
library(shinydashboard)

source("svm.R")



shinyUI(dashboardPage(
  dashboardHeader(title = "Predictions",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Admin Login",
                                 message = "You Are Logged In As Admin"
                               ),
                               messageItem(
                                 from = "New User",
                                 message = "How do I register?",
                                 icon = icon("question"),
                                 time = "13:45"
                               )
                             
                  )
                  ),
  dashboardSidebar(
    sidebarSearchForm(textId = "searchText", 
                      buttonId = "searchButton",
                      label = "Search..."),
    sidebarMenu(
    menuItem("Dashboard", 
             tabName = "dashboard", 
             icon = icon("dashboard")),
    
    menuItem("Instructions",
             tabName = "instructions",
             icon = icon("th")),
    menuItem("See Details",
             tabName = "see details",
             icon = icon("th"))
    )
    
  ),
  
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem( tabName = "dashboard",
              h1("Enter The Details for prediction "),
               fluidRow(
                column(width = 6,
                  box( title = h4("Enter Personal Details"), 
                       width = 12 ,solidHeader = T,
                       status = "primary",
                  
                     numericInput("age","Enter Your Age",35),
              
                     selectInput("gender", label="Enter Your Gender", selectize = TRUE, choices = c("0", "1"), selected = "1"),
              
                     textInput("cholestrol", label =("Cholestrol"), value = ""),
              
                     textInput("fastingbp", label =("Fasting Blood Sugar"), value = ""), helpText("1 = true; 0 = false"),
              
                     textInput("restcg", label =("Resting ECG result"), value = ""),
              
                     textInput("thalach", label =("Max. Heart Rate Achieved"),  value = ""),
              
                     textInput("exang", label =("Exercise induced angina"),  value = ""), helpText("0- no,1-yes"),
              
                     textInput("oldpeak", label =("ST depression induced due to exercise"),  value = ""),
              
                     textInput("slope", label =("Slope of peak ST segment"),  value = ""),
              
                     textInput("ca", label =("Number of major vessels coloured by fluroscopy"), value = ""), helpText("0 - 3"),
              
                     textInput("thal", label =("Thal value"),value = ""), helpText("3-normal,6-fixed defect,7-reversible defect")

                   )
              ),
                    
              box(offset=1,height = 370 ,status = "primary",
                  
                  img(src = "hto_futuristic_doctor.jpg",align = "right",width= 350,height=350)
                  #img(src = "atypical-angina-300x200.jpg",align = "right",width= 450,height=450)               
                  
              ),
             
                column(3,offset=3,
                       
                       actionButton("pred","Predict"), 
                       actionButton("accc","Accuracy!"),

                       #submitButton(text= "Submit"),
                       textOutput("result"),
                       textOutput("accuracy1")
                       
                      )
              

              
           
                        )
              ),
      
     
      
      # Second tab content
tabItem( tabName = "instructions",
      fluidRow(
                column(width = 10,
                box(title = "Instructions For Filling Details:", solidHeader = T,
                  h4("1.Typical Angina:"),
                  p("The presence of  chest pain or discomfort that was provoked by exertion or emotional stress" ),
                  
                  h4("2.Atypical Angina:"),
                  p("often doesn’t cause pain, but you may feel a vague discomfort in your chest, experience
                    shortness of breath, feel tired or nauseous, have indigestion, or pain in your back or neck"),
                  
                  h4("3.Non anginal pain:"),
                  p("Non cardiac pain"),
                  
                  h4("4.Asymptomatic:"),
                  p(" Non frequent pain "),
                  
                  h4("5.Fasting Blood Sugar:"),
                  p("fasting blood sugar > 120 mg/dl (1 = true; 0 = false) "),
                  
                  h4("6.Resting Blood Pressure"),
                  p("in mm Hg on admission to the 
                    hospital"),
                  
                  h4("7.Cholestrol"),
                  p("serum cholestoral in mg/dl"),
                  
                  h4("8.Fasting Blood Sugar"),
                  p("fasting blood sugar > 120 mg/dl"),
                  
                  h4("9.Resting ECG"),
                  p("0: normal,
                    1:having ST-T wave abnormality (T wave inversions and/or ST 
                    elevation or depression of > 0.05 mV),
                    2: showing probable or definite left ventricular hypertrophy
                    by Estes' criteria"),
                  
                  h4("10.Exercise Induced Angina"),
                  p("1-yes,0-no"),
                  
                  h4("11.ST Depression"),
                  p("ST depression induced by exercise relative to rest"),
                  
                 strong( "12.Slope of peak ST segment"),
                  p("the slope of the peak exercise ST segment
                    1: upsloping
                    2: flat
                    3: downsloping")
                  )
                
               
                      )
             )
       )
                           )
                            )
                              )

                                  )










