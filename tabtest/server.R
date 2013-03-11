library(shiny)
library(knitr)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The output functions defined 
  # below then all use the value computed from this expression
  data <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    dist(input$n)
  })
  
  # capture textarea content as source
  
  
  
  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the data reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  
  # output$plot <- renderPlot({
  #  dist <- input$dist
  #  n <- input$n
    
  #  hist(data(), 
  #       main=paste('r', dist, '(', n, ')', sep=''))
  #})
  
  # Generate a summary of the data
  # output$summary <- renderPrint({
  #  summary(data())
  # })
  

  # this is for saving notes
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$file_id, '.html') },
    content = function(file) {
      src <- input$nbSrc
      write(knit2html(text = src, fragment.only = TRUE), file)
    }
  )
  
  # real-time conversion of notes
  
  output$summary <- reactive(function() {
    src = input$nbSrc
    if (length(src) == 0L || src == '')
    return('Nothing to show yet...')
    on.exit(unlink('figure/', recursive = TRUE)) # do not need the figure dir
    paste(try(knit2html(text = src, fragment.only = TRUE)),
          '<script>',
          '// highlight code blocks',
          "$('#nbOut pre code').each(function(i, e) {hljs.highlightBlock(e)});",
          'MathJax.Hub.Typeset(); // update MathJax expressions',
          '</script>', sep = '\n')
  })
  
  
  # Generate an HTML table view of the data
  output$review <- renderTable({
    data.frame(x=data())
  })
  
})