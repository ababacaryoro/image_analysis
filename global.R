library(RoogleVision)
library(jsonlite)
library(shiny)
library(shinyjs)
library(data.table)
library(DT)
library(magrittr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(highcharter)
library(shinythemes)
library(tools)

# Google Authentication - Use Your Credentials
# options("googleAuthR.client_id" = "xxx.apps.googleusercontent.com")
# options("googleAuthR.client_secret" = "")
creds <- fromJSON('client_secret.json')

options("googleAuthR.client_id" = creds$web$client_id)
options("googleAuthR.client_secret" = creds$web$client_secret)
options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/cloud-platform"))
googleAuthR::gar_auth(new_user = T)

# Defautl image 
default_img <- "./www/img/dog_mountain.png"

# dog_mountain_label = getGoogleVisionResponse('www/img/dog_mountain.png',
#                                              feature = 'LABEL_DETECTION')
