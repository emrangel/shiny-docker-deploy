shinyUI(
dashboardPage(
    dashboardHeader(title="Review Data"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Input sasdata", tabName="sasdata"),
        menuItem("Select variable", uiOutput("options")), 
        menuItem("Pie Chart", tabName ="pie")
      )
    ),
    dashboardBody(
      tabItems(
        
        tabItem(tabName="sasdata",
                fluidPage(
                  headerPanel(title = "Input sasdata"),
                  sidebarLayout(
                    sidebarPanel(
                      fileInput(
                        inputId = "sasdata",
                        label = "Choose SAS datasets"
                      )
                    ),
                    mainPanel(
                      tableOutput("sasdata")
                    )
                  )
                )
        ),
        
        tabItem(tabName = "pie", 
                
                  headerPanel(title = "Pie Chart"), 
                  mainPanel(
                    plotOutput("swPlot", width = 650),
                    tableOutput("Cntpct"),
                    downloadButton("dlPlot", "Download Plot")
                )
        )
      )))


)
