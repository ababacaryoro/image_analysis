library(shinydashboard)
library(leaflet)

ui = bootstrapPage(
  tagList(
    #shinythemes::themeSelector(),
    navbarPage(
      theme = shinytheme("flatly"),  # <--- To use a theme, uncomment this
      "Image content analysis",
      tabPanel("Load image",
               sidebarPanel(width = 3,
                 radioButtons("img_source", label = h3("Image source"),
                              choices = list('Url' = 'url', 'Upload' = 'upload'), 
                              selected = 'url'),
                 conditionalPanel("input.img_source == 'url' ",
                                  textInput("url_input", "Give image Url", value = "./www/img/temp/test.jpg")
                                  ),
                 conditionalPanel("input.img_source == 'upload' ",
                                  fileInput("file_input", "Select file", accept = c(".png", ".jpeg", ".jpg", ".tiff", ".tif"))
                 ),
                 actionButton("load_img", "Process image", class = "btn-primary")
               ),
               mainPanel(width = 9,
                         fluidRow(
                           column(width = 7,
                                  h4("Selected image"),
                                  box(width = NULL, solidHeader = TRUE,
                                      # TODO : possibility to load the image
                                      imageOutput("input_img")
                                  )
                           ),
                           column(width = 3,
                                  h4("General information"),
                                  box(width = NULL, solidHeader = T, status = "warning", #collapsible = TRUE,
                                      uiOutput("general_information")
                                  )
                           )
                         )
                         
               )
      ),
      tabPanel("Face detection",
               sidebarPanel(width = 3,
                            sliderInput("wavelength", "Wavelength : ",
                                        min=360, max=740, step = 10, value=360, 
                                        animate = animationOptions(interval=700, loop=F))
                            
               ),
               mainPanel(width = 12,
                         plotOutput("ks_conc_plot")
               )
               
      ),
      tabPanel("Text detection",
               sidebarPanel(width = 3,
                            
                            actionButton("showPred", "Load graph", class = "btn-primary")
                            
               ),
               mainPanel(width = 9,
                         tags$div(highchartOutput('predCol', height = "100%", width = "700px"), align="center"),
                         tags$head(tags$script(src="src/draggable-3d.js")),
                         br(),
                         br(),
                         br(),
                         uiOutput("comparePredActual")
               )
               
      ),
      tabPanel("Output Gamut",
               sidebarPanel(width = 3,
                            
                            actionButton("showGamut", "Show", class = "btn-primary")
                            
               ),
               mainPanel(width = 9,
                         tags$div(highchartOutput('gamut', height = "100%", width = "700px"), align="center") #,
                         #tags$head(tags$script(src="src/draggable-3d.js"))
                         
               )
               
               
      ),
      tabPanel("Color catalog",
               sidebarPanel(
                 
                 
                 actionButton("showCatalog", "Load colors", class = "btn-primary"),
                 br(),
                 br(),
                 
                 uiOutput('myPanel')
                 
               ),
               
               mainPanel(
                 fixedPanel(draggable = T,
                            h2('Related Composition(s)'),
                            DT::dataTableOutput('compoData')
                            
                 ),
                 br(), br(), br(), br(), br(),
                 conditionalPanel(
                   condition="($('html').hasClass('shiny-busy'))",
                   img(src="img/loading_icon.gif")
                 )
               )
               
      )
      
      
      
    )
  )
)


