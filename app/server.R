#server

# packageのロード
library(shiny)
library(tidyverse)
library(glue)

# 関数定義したファイルを読み込む
source("functions.R")


# サーバー側の処理 ----------------------------------------------------------------
shinyServer(function(input, output) {


# 計算の詳細設定ページのUI ----------------------------------------------------------------
  output$advancedSettings <- renderUI({
    radioButtonSetting <- list()
    if(input$arithOperations == "1"){
      # 足し算の設定
      radioButtonSetting$id <- "radioAddition"
      radioButtonSetting$label <- "足し算の詳細設定"
      radioButtonSetting$choices <- list("繰り上がりあり" = 1,
                                         "繰り上がりなし" = 2,
                                         "ランダム" = 3)
    } else if (input$arithOperations == "2"){
      # 引き算の設定
      radioButtonSetting$id <- "radioSubtraction"
      radioButtonSetting$label <- "引き算の詳細設定"
      if(input$digitNum == "1"){
        radioButtonSetting$choices <- list("繰り下がりなし" = 2,
                                           "ランダム" = 3)
      } else {
        radioButtonSetting$choices <- list("繰り下がりあり" = 1,
                                           "繰り下がりなし" = 2,
                                           "ランダム" = 3)
      }
    } else {
      # 掛け算と割り算にはまだ未対応なのでその旨を表示する
      return(
        h3("掛け算と割り算には未対応です")
      )
    }
    
    return(
      radioButtons(radioButtonSetting$id, 
                   label = h3(radioButtonSetting$label),
                   choices = radioButtonSetting$choices,
                   selected = 3)
    )
  })


  

# 問題の選択 -------------------------------------------------------------------
  # 選択された桁数に応じて読みこむ解答ファイルを変更
  ansTable <- eventReactive(input$generatePrint, {
    oprt <- input$arithOperations
    if(oprt == "1"){
      # 足し算の場合
      ansTable <- switch(input$digitNum,
                         "1" = readRDS(file = "data/addAns1.rds"),
                         "2" = readRDS(file = "data/addAns2.rds"),
                         "3" = readRDS(file = "data/addAns3.rds"))
    } else if(oprt == "2"){
      # 引き算の場合
      ansTable <- switch(input$digitNum,
                         "1" = readRDS(file = "data/subAns1.rds"),
                         "2" = readRDS(file = "data/subAns2.rds"),
                         "3" = readRDS(file = "data/subAns3.rds"))
    }
    
    return(ansTable)
  })

  # 詳細設定
  questionPattern <- reactive({
    switch(input$arithOperations,
           "1" = input$radioAddition,
           "2" = input$radioSubtraction)
  })
  
  # 問題の式を生成
  questions <- reactive({
    questions <- getQuestions(ansTable = ansTable(), 
                              questionPattern = questionPattern(), 
                              arithOperations = input$arithOperations)
    
    return(questions)
  })
  
  
  

# 問題生成の処理が完了したことをモーダル表示 -------------------------------------------------------
  # 参考；https://shiny.rstudio.com/articles/tag-glossary.html
  # 厳密には「問題を生成する」ボタンを押した時点で表示
  observeEvent(input$generatePrint, {
    showModal(modalDialog(
      title = "問題＆解答の生成が完了しました！",
      p("「生成されたプリント」タブに移動すると生成された問題を確認することができます！"),
      p("印刷を行いたい場合には、右クリックをして印刷を行ってください。"),
      p("続けて新しい問題を生成したい時には、再度「問題を生成する」ボタンをクリックすると新しい問題が生成されます。"),
      footer = modalButton("閉じる"),
      easyClose = TRUE
    ))
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

