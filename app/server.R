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
  questionTexts <- reactive({
    texts <- getQuestions(ansTable = ansTable(), 
                          questionPattern = input$radioAddition)
    
    return(texts$questionTexts)
  })
  
  # 解答付きの問題を生成
  answerTexts <- reactive({
    texts <- getQuestions(ansTable = ansTable(), 
                          questionPattern = input$radioAddition)
    
    return(texts$answerTexts)
  })
  
    
# 生成したプリントのUI -------------------------------------------------------------
  output$questinoTab <- renderUI({
    withTags({
      div(class = "main",
          p(class = "name", 
            "なまえ："),
          
          # 左列
          div(class = "column",
              ul(
                li(questionTexts()[1]),
                li(questionTexts()[2]),
                li(questionTexts()[3]),
                li(questionTexts()[4]),
                li(questionTexts()[5]),
                li(questionTexts()[6]),
                li(questionTexts()[7]),
                li(questionTexts()[8]),
                li(questionTexts()[9]),
                li(questionTexts()[10])
              )
          ),
          
          # 右列
          div(class = "column",
              ul(
                li(questionTexts()[11]),
                li(questionTexts()[12]),
                li(questionTexts()[13]),
                li(questionTexts()[14]),
                li(questionTexts()[15]),
                li(questionTexts()[16]),
                li(questionTexts()[17]),
                li(questionTexts()[18]),
                li(questionTexts()[19]),
                li(questionTexts()[20])
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
                li(answerTexts()[1]),
                li(answerTexts()[2]),
                li(answerTexts()[3]),
                li(answerTexts()[4]),
                li(answerTexts()[5]),
                li(answerTexts()[6]),
                li(answerTexts()[7]),
                li(answerTexts()[8]),
                li(answerTexts()[9]),
                li(answerTexts()[10])
              )
          ),
          
          # 右列
          div(class = "column",
              ul(
                li(answerTexts()[11]),
                li(answerTexts()[12]),
                li(answerTexts()[13]),
                li(answerTexts()[14]),
                li(answerTexts()[15]),
                li(answerTexts()[16]),
                li(answerTexts()[17]),
                li(answerTexts()[18]),
                li(answerTexts()[19]),
                li(answerTexts()[20])
              )
          )
      )
    })
  })
})

