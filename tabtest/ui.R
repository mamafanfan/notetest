library(shiny)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
    
  # Application title
  headerPanel("Lecture Notes - Testing"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
    #radioButtons("dist", "Distribution type:",
    #             c("Normal" = "norm",
    #               "Uniform" = "unif",
    #               "Log-normal" = "lnorm",
    #               "Exponential" = "exp")),
    
    helpText("Note: This is a prototype with a very limited feature set. ",
             "Use Markdown for text and R for maths. ",
             "Thank you for taking part in this study."),
    
    
    br(),
    
    selectInput("variable", "Choose Course:",
                list("Operating Systems" = "ops", 
                     "Computer Architecture" = "comarch", 
                     "Obj Oriented Programming" = "objp")),
    
    
    br(),
    textInput("file_id", "T Number:", "Your Student ID Here"),
    downloadButton('downloadData', 'Save Notes'),
    
    tags$textarea(id = 'nbSrc', style = 'width: 450px; height: 750px;'),
    
    
    sliderInput("n", 
                "Number of observations:", 
                 value = 500,
                 min = 1, 
                 max = 1000)
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Lecture Slides", plotOutput("plot")), 
      # tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Notes", htmlOutput("summary")),
      tabPanel("Review", tableOutput("review")),
      tabPanel("Share", htmlOutput("blogit"))
    )
  )
))