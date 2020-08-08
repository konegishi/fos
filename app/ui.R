#ui

# packageのロード
# pacman::p_load(shiny, shinythemes, shinycustomloader)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinycustomloader)

# UI
shinyUI(fluidPage(
  navbarPage(
    title = "算数プリントを自動生成",
    theme = shinytheme("flatly"),
    
    tabPanel("設定",
             uiOutput("calSettings")),
    
    tabPanel("生成されたプリント",
             uiOutput("calPrint"))
  )
))

# shinyUI(fluidPage(theme = shinytheme("cerulean"),
#                   titlePanel("算数プリントを自動生成"),
#                   
#                   sidebarLayout(
#                     sidebarPanel(
#                       checkboxInput('header', 'Header', TRUE),
#                       # radioButtons('sep', 'Separator',
#                       #              c(Tab='\t',
#                       #                Comma=',',
#                       #                Semicolon=';'),
#                       #              '\t'),
#                       # radioButtons('quote', 'Quote',
#                       #              c(None='',
#                       #                'Double Quote'='"',
#                       #                'Single Quote'="'"),
#                       #              '"'),
#                       # checkboxInput("Tmatrix", label="Tarnspose matrix", value=F),
#                       # actionButton("calPCC", label="Caluculate PCC values"),
#                       # 
#                       # 
#                       # 
#                       # tags$hr(),
#                       # sliderInput("th", label="Choose threshold",
#                       #             max=1, min=0, value=c(0.9, 1)),
#                       # textInput("th_network", label="PCC values used for cut-off", value=1),
#                       # actionButton("ViewNetwork", "View Network"),
#                       # 
#                       # 
#                       # 
#                       # tags$hr(),
#                       # textInput("downloadName", label="Download file name", value=Sys.Date()),
#                       # downloadButton("download", label="Download")
#                     ),
#                     
#                     mainPanel(
#                       h1("計算プリント"),
#                       uiOutput("test")
#                       # h1(),
#                       # textOutput("filename"),
#                       # hr(),
#                       # textOutput("InputTable"),
#                       
#                       # fluidRow(
#                       #   column(6,
#                       #          plotOutput("Edge")),
#                       #   column(6,
#                       #          plotOutput("Node"))
#                       # ),
#                       
#                       # tags$hr(),
#                       # fluidRow(
#                       #   column(8,
#                       #          h2("Member Network"),
#                       #          plotOutput("Network")),
#                       #   column(4,
#                       #          br(),
#                       #          br(),
#                       #          br(),
#                       #          br(),
#                       #          tableOutput("Member"))
#                       # )
#                     )
#                   )
# ))