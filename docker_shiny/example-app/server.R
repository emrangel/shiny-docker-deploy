shinyServer(
function(input, output, session) {
  
  allChar <- reactive({
    
    if (!is.null(input$sasdata)) {
      
      inputSasData <- read_sas(input$sasdata$datapath)
      inputSasData <- data.frame(inputSasData)
      
      choices = c()
      for (i in 1:length(names(inputSasData))) {
        if (typeof(inputSasData[1, i]) == "character") {
          choices <- append(choices, names(inputSasData)[i])
        }
      }
      choices <- sort(choices)
      return(choices)
      
    } else {
      return()
    }
  })
  
  output$options <- renderUI ({
    selectInput(inputId = "charVar", label = " ",
                choices = allChar())
  })
  
   
    plotFunction <- reactive({
      inputSasData <- read_sas(input$sasdata$datapath)
      inputSasData <- data.frame(inputSasData)
      inputSasData <- inputSasData[c(input$charVar) ]
      
      counts <- table(inputSasData, useNA = "ifany")
      counts <- data.frame(counts)
      names(counts) <- c("Categories", "Counts")
      
      g <- ggplot(data = counts, aes(x = "", y = Counts, fill = Categories)) +
        geom_bar(stat = "identity") + coord_polar("y", start = 0) + labs(x=" ") + labs(y=" ")
      g <- g + theme(text = element_text(size = 10)) + labs(title = "Pie Chart")
        
      plot(g)
      
    })
    
    output$swPlot <- renderPlot({plotFunction()})
    
    returnTable <- reactive({
      
      inputSasData <- read_sas(input$sasdata$datapath)
      inputSasData <- data.frame(inputSasData)
      inputSasData <- inputSasData[c(input$charVar)]
      
          counts <- table(inputSasData, useNA = "ifany")
          counts <- data.frame(counts)
          
          names(counts) <- c("Categories", "Count")
          denom <- sum(counts$Count)
          counts$percentage <- 100*counts$Count/denom
  
      return (counts)
    })
    
    output$Cntpct <- renderTable({
      return(returnTable())
    })
    
    output$dlPlot <- downloadHandler (
      filename <- function(){
        paste(input$charVar, '.pdf', sep = '')
      },
      content <- function(file) {
        ggsave(file, plot = plotFunction())
      }
    )
  
}

)
