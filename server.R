#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  img_data <- reactiveValues(path = default_img, 
                             description = NULL#,
                             )
  
  output$input_img <- renderImage({
    
    img_details <<- paste0('<img src="', img_data$path, '" width = "100%" height="100%">')
    img_details2 <<- list(src = img_data$path)
    
    list(src = img_data$path, width = '100%', height = '100%')
    
  })
  
  
  observeEvent(input$load_img, {
    
    if (input$img_source == 'url') {
      if (is.null(input$url_input) || "" %in% input$url_input) return(NULL)
      if ( !(tools::file_ext(input$url_input)  %in% c(".png", ".jpeg", ".jpg", ".tiff", ".tif")) ) return(NULL)
      
      img_data$path <- input$file_input$datapath
      img_data$description <- getGoogleVisionResponse(img_data$path, 
                                                      feature = 'LABEL_DETECTION') %>%
        data.table %>%
        .[, .(description, score)]
      
    } else if (input$img_source == 'upload') {
      if (!is.data.frame(input$file_input) ) return(NULL)
      
      img_data$path <- input$file_input$datapath
      img_data$description <- getGoogleVisionResponse(img_data$path, 
                                                      feature = 'LABEL_DETECTION') %>%
                              data.table %>%
                              .[, .(description, score)]
    } 
    
    
    
    
  })
  
  output$description_dt <- renderTable({
    if(is.null(img_data$description)) return(NULL)
    
    img_data$description
  })
  
  output$general_information <- renderUI({
    
    
    tagList(
      
      h5('Image description (with scores)'),
      tableOutput('description_dt')
      
      
    )
    
  })
  
})


