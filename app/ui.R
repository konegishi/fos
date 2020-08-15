#ui

# packageのロード
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinycustomloader)

# UI
shinyUI(fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  navbarPage(
    title = "計算プリントを自動生成",
    theme = shinytheme("flatly"),
    
    tabPanel("問題を生成",
             h2("計算プリントの基本設定"),

             # 四則演算の選択
             selectInput("arithOperations", label = h4("作りたい問題を選択してください"),
                          choices = list("足し算" = 1, 
                                         "引き算" = 2,
                                         "掛け算（未対応）" = 3,
                                         "割り算" = 4),
                          selected = 1),

             hr(),
             
             h2("詳細設定"),
             fluidRow(column(6,
                             # 桁数の選択
                             radioButtons("digitNum", 
                                          label = h4("桁数の設定"),
                                          choices = list("1桁のみ" = 1,
                                                         "2桁まで" = 2,
                                                         "3桁まで" = 3),
                                          selected = 1),
                             ),
                      column(6,
                             # 計算の詳細設定
                             uiOutput("advancedSettings"),
                             )),
             
             hr(),
             
             # 問題を生成するボタン
             actionButton("generatePrint", label = "問題を生成する")
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
