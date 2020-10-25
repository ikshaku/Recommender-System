#ui.R
library(shiny)
library(shinythemes)
genre_list <- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film.Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci.Fi", "Thriller", "War", "Western")
Movie_find<-read.csv('movie_finder_data.csv',stringsAsFactors = F)
Movie_find$title<- gsub(', The','',Movie_find$title)
Movie_find$title<- gsub(', A','',Movie_find$title)
movie_list<-as.character(Movie_find$title)

shinyUI(

navbarPage(theme = shinytheme("slate"),
title = div(img(src = "https://media.giphy.com/media/FQkGpU34nbXrO/giphy.gif", width = "250px", height = "48px", style="margin-top: -14px; margin-right:-14px;margin-left:-14px", height = 50)),
  tabPanel(tags$b('Recommend Movie'),
           
           fluidRow(h3("Select the movies you like") ,
             wellPanel(
                        fluidRow(column(6,selectInput("input_genre", "Genre #1",genre_list)),
                        column(6,uiOutput("ui"))),
                        fluidRow(column(6,selectInput("input_genre2", "Genre #2",genre_list)),
                        column(6,uiOutput("ui2") )),
                        fluidRow(column(6,selectInput("input_genre3", "Genre #3",genre_list)),
                        column(6,uiOutput("ui3")))
               #submitButton("Update List of Movies")
                      )
           ),
           wellPanel(
                      fluidRow(
                                column(3,sliderInput("year", label = "Select Year Range", min = 1902,max = 2015, value = c(1902, 2015))),
                                column(2,checkboxGroupInput("genre1", "Select Genres",
                                                           c("Action" = "Action",
                                                             "Adventure" = "Adventure",
                                                            "Animation" = "Animation",
                                                            "Children"="Children" ))),
                                              column(2,checkboxGroupInput("genre2", "",
                                                          c("Comedy" = "Comedy",
                                                            "Crime" = "Crime",
                                                            "Documentary" = "Documentary",
                                                            "Drama"="Drama" ))),
                                            column(2,checkboxGroupInput("genre3", "",
                                                          c("Fantasy" = "Fantasy",
                                                            "Film Noir" = "Film.Noir",
                                                            "Horror" = "Horror",
                                                            "Musical"="Musical" ))),
                                            column(2,checkboxGroupInput("genre4", "",
                                                          c("Mystery" = "Mystery",
                                                            "Romance" = "Romance",
                                                            "Sci Fi" = "Sci.Fi",
                                                            "Thriller"="Thriller" ))),
                      column(4,h3("You Might Like The Following Movies as well"),tableOutput("table"))   
                          )
                  )   
          )
  ,
   tabPanel(tags$b('Search Movie'),
    fluidRow(column(1),column(8,selectInput("Movie_chosen", "Select your movie",movie_list))),
    wellPanel(
              fluidRow(column(1),
              column(8,
              fluidRow(column(4,uiOutput("Movie_chosen"))),
              fluidRow(column(4,uiOutput("movie_desc"))),
              br(),
              br(),
              fluidRow(column(3,uiOutput("Imdb_Link")))
              ),column(2,uiOutput('Image'))
            )
    )
    
  ),
)
)
