library(shiny)
library(ggplot2)
library(shinythemes)

# Define UI for miles per gallon drv app
ui <- fluidPage(theme = shinytheme("flatly"),
  titlePanel("Miles Per Gallon - Drive Type Data"),
  # Sidebar panel for inputs
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(inputId = "drv", 
                         label = h3("Choose the type(s) of drive (drv)):"),
                         choices = c("4 (4 Wheel Drive)"="4", "r (Rear Wheel Drive)"="r", "f (Front Wheel Drive)"="f"), 
                         selected = c("4"),
                         inline = FALSE)
    ),
    mainPanel(
      #Scatterplot
      plotOutput("mpgdrvPlot")
    )
  )
)

# Define server logic to plot variables against mpg drv data
server <- function(input, output) {
  
  output$mpgdrvPlot <- renderPlot({
    #mpg drv input
    #plot mpg data frame, x is displ, y is hwy, color drv, add smoother
    ggplot(mpg[mpg$drv %in% input$drv,], aes(x = displ, y = hwy, color = drv)) + 
      geom_point() +
      geom_smooth(se = FALSE)
  })
}

shinyApp(ui = ui, server = server)