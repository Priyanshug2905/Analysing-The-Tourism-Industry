library(shiny)
library(dplyr)
library(ggplot2)
dat1 <- read.csv("origin_country.csv")
dat2 <- read.csv("gender.csv")
dat3 <- read.csv("states_pref.csv")
dat4 <- read.csv("places_to_visit.csv")

ui <- fluidPage(
  # Application title
  titlePanel("THE TOURISM INDUSTRY"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "years",
                  label = "Number of years:",
                  choices = c(2014, 2015, 2016, 2017, 2018, 2019, 2020)),
      
      selectInput(inputId = "gender",
                  label = "Choose your gender:",
                  choices = c("male", "female")),
      
      selectInput(inputId = "region",
                  label = "Choose your region:",
                  choices = c("North India", "South India", "Central India",
                              "West India", "East India", "NorthEast India")),
    ),
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tab", 
                  tabPanel("origin country", plotOutput("histogram1")),
                  tabPanel("gender classification", plotOutput("histogram2")),
                  tabPanel("preferred states", plotOutput("histogram3")),
                  tabPanel("Tourist Destinations", textOutput("region"))
                  
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  selected_year <- reactive({input$years})
  
  
  output$histogram1 <- renderPlot({
    # generate bins based on input$bins from ui.R
    filtered_data1 <- dat1 %>%
      filter(YEAR == selected_year())
    
    ggplot(filtered_data1, aes(x = COUNTRY, y = `No..of.Visitors`)) +
      geom_bar(stat = "identity", fill = "blue") +
      xlab("Country") +
      ylab("Number of Visitors") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      ggtitle(paste("Number of Visitors in year" , selected_year()))
    
    
  })
  
  output$histogram2 <- renderPlot({
    
    filtered_data2 <- dat2 %>%
      filter(Year == selected_year())
    
    if (input$gender == "male"){
      gender <- "male"
      selected_gender <- filtered_data2$Male 
    }
    else if (input$gender == "female"){
      gender <- "female"
      selected_gender <- filtered_data2$Female
    }
    
    ggplot(filtered_data2, aes(x = Country.of.Nationality, y = selected_gender)) +
      geom_bar(stat = "identity", fill = "red") +
      xlab("Country") +
      ylab(paste("Number of", gender)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      ggtitle(paste("Number of", gender, "tourist by Country in year", selected_year()))
  })
  
  output$histogram3 <- renderPlot({
    
    filtered_data3 <- dat3 %>%
      filter(YEAR == selected_year())
    
    ggplot(filtered_data3, aes(x = STATES, y = VISITORS)) +
      geom_bar(stat = "identity", fill = "purple") +
      xlab("States") +
      ylab("Number of Visitors") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      ggtitle(paste("States preferred by foreign Visitors in year" , selected_year()))
  })
  
  output$region <- renderPrint({
    
    selected_region <- reactive({input$region})
    filtered_data3 <- which(dat4$part_of_india == selected_region())
    
    print(dat4$tourism_1[filtered_data3])
    
  })    
}

shinyApp(ui=ui , server=server)
