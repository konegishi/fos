#server

# packageのロード
# pacman::p_load(shiny,
#                tidyverse,
#                shinycustomloader)
library(shiny)
library(tidyverse)
library(glue)



# user.base <- readRDS(file = "data/userBase.rds")

# サーバー側の処理 ----------------------------------------------------------------
shinyServer(function(input, output) {


# 設定ページのUI ----------------------------------------------------------------
  # output$calSettings <- renderUI({
  #   h2("計算プリントの設定")
  # })


  

# 問題の選択 -------------------------------------------------------------------
  # 選択された桁数に応じて読みこむファイルを変更
  ansTable <- reactive({
    switch(input$digitNum,
           "1" = readRDS(file = "data/num1.rds"),
           "2" = readRDS(file = "data/num2.rds"),
           "3" = readRDS(file = "data/num2.rds"))
  })
  
  # 問題の式を生成
  questionTexts <- reactive({
    ansTableSampled <- ansTable() %>% 
      sample_n(size = 20)  # ランダムに20行抽出
    
    questionTexts <- c()
    for(i in 1:nrow(ansTableSampled)){
      slicedTable <- ansTableSampled %>% 
        slice(i)
      questionTexts <- c(questionTexts, glue("({i}) {slicedTable$Var1} + {slicedTable$Var2} = "))
    }
    
    return(questionTexts)
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
})

