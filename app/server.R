#server

# packageのロード
# pacman::p_load(shiny,
#                tidyverse,
#                shinycustomloader)
library(shiny)
library(tidyverse)
library(glue)

# 関数定義したファイルを読み込む
source("functions.R")


# サーバー側の処理 ----------------------------------------------------------------
shinyServer(function(input, output) {


# 設定ページのUI ----------------------------------------------------------------
  # output$calSettings <- renderUI({
  #   h2("計算プリントの設定")
  # })


  

# 問題の選択 -------------------------------------------------------------------
  # 選択された桁数に応じて読みこむ解答ファイルを変更
  ansTable <- eventReactive(input$generatePrint, {
    switch(input$digitNum,
           "1" = readRDS(file = "data/num1.rds"),
           "2" = readRDS(file = "data/num2.rds"),
           "3" = readRDS(file = "data/num2.rds"))
  })

  # 問題の式を生成
  questions <- reactive({
    questions <- getQuestions(ansTable = ansTable(), 
                              questionPattern = input$radioAddition)
    
    return(questions)
  })
  
  # questionTexts <- reactive({
  #   return(texts$questionTexts)
  # })
  
  # questionTexts <- reactive({
  #   texts <- getQuestions(ansTable = ansTable(), 
  #                         questionPattern = input$radioAddition)
  #   
  #   return(texts$questionTexts)
  # })
  
  # 解答付きの問題を生成
  # answerTexts <- reactive({
  #   texts <- getQuestions(ansTable = ansTable(), 
  #                         questionPattern = input$radioAddition)
  #   
  #   return(texts$answerTexts)
  # })
  
    
# 生成したプリントのUI -------------------------------------------------------------
  output$questinoTab <- renderUI({
    withTags({
      div(class = "main",
          p(class = "name", 
            "なまえ："),
          
          # 左列
          div(class = "column",
              ul(
                li(questions()$questionTexts[1]),
                li(questions()$questionTexts[2]),
                li(questions()$questionTexts[3]),
                li(questions()$questionTexts[4]),
                li(questions()$questionTexts[5]),
                li(questions()$questionTexts[6]),
                li(questions()$questionTexts[7]),
                li(questions()$questionTexts[8]),
                li(questions()$questionTexts[9]),
                li(questions()$questionTexts[10])
              )
          ),
          
          # 右列
          div(class = "column",
              ul(
                li(questions()$questionTexts[11]),
                li(questions()$questionTexts[12]),
                li(questions()$questionTexts[13]),
                li(questions()$questionTexts[14]),
                li(questions()$questionTexts[15]),
                li(questions()$questionTexts[16]),
                li(questions()$questionTexts[17]),
                li(questions()$questionTexts[18]),
                li(questions()$questionTexts[19]),
                li(questions()$questionTexts[20])
              )
          )
      )
    })
  })
  
  

# 解答付きプリントのUI -------------------------------------------------------------
  output$answerTab <- renderUI({
    withTags({
      div(class = "main",
          p(class = "name", 
            "なまえ："),
          
          # 左列
          div(class = "column",
              ul(
                li(questions()$answerTexts[1]),
                li(questions()$answerTexts[2]),
                li(questions()$answerTexts[3]),
                li(questions()$answerTexts[4]),
                li(questions()$answerTexts[5]),
                li(questions()$answerTexts[6]),
                li(questions()$answerTexts[7]),
                li(questions()$answerTexts[8]),
                li(questions()$answerTexts[9]),
                li(questions()$answerTexts[10])
              )
          ),
          
          # 右列
          div(class = "column",
              ul(
                li(questions()$answerTexts[11]),
                li(questions()$answerTexts[12]),
                li(questions()$answerTexts[13]),
                li(questions()$answerTexts[14]),
                li(questions()$answerTexts[15]),
                li(questions()$answerTexts[16]),
                li(questions()$answerTexts[17]),
                li(questions()$answerTexts[18]),
                li(questions()$answerTexts[19]),
                li(questions()$answerTexts[20])
              )
          )
      )
    })
  })
})

