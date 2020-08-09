#ui

# packageのロード
# pacman::p_load(shiny, shinythemes, shinycustomloader)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinycustomloader)

# UI
shinyUI(fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  navbarPage(
    title = "算数プリントを自動生成",
    theme = shinytheme("flatly"),
    
    tabPanel("問題を生成",
             h2("計算プリントの設定"),
             checkboxInput('header', 'Header', TRUE),
             
             # 四則演算の選択
             selectInput("radioCal", label = h3("四則演算"),
                          choices = list("足し算" = 1, 
                                         "引き算" = 2,
                                         "掛け算" = 3,
                                         "割り算" = 4),
                          selected = 1),

             # 桁数の選択
             selectInput("digitNum", label = h3("桁数の設定"),
                         choices = list("1桁のみ" = 1, 
                                        "2桁まで" = 2,
                                        "3桁まで" = 3),
                         selected = 1),
             
             # 足し算の設定
             radioButtons("radioAddition", label = h3("足し算の詳細設定"),
                          choices = list("繰り上がりあり" = 1, 
                                         "繰り上がりなし" = 2,
                                         "ランダム" = 3),
                          selected = 3)
             ),
    
    tabPanel("生成された問題プリント",
             uiOutput("questinoTab")),
    
    tabPanel("生成された解答プリント",
             uiOutput("answerTab"))
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