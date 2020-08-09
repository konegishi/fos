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
                          selected = 3),
             
             # 問題を生成するボタン
             actionButton("generatePrint", label = "問題を生成する"),
             
             textOutput("doneText")
             ),

    tabPanel("生成された問題プリント",
             withLoader(
               uiOutput("questinoTab"),
               type = "html",
               loader = "dnaspin"
             )),

    tabPanel("生成された解答付きプリント",
             withLoader(
               uiOutput("answerTab"),
               type = "html",
               loader = "dnaspin"
             ))
  )
))
