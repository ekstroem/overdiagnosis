## app.R ##
library("shiny")
library("shinydashboard")



function(input, output, session) {


    output$screened <- renderValueBox({
                                        # The downloadRate is the number of rows in pkgData since
                                        # either startTime or maxAgeSecs ago, whichever is later.
        res <- round((input$scrpat*input$pat+(100-input$pat)*input$scrnopat)/100, 2)
        
        valueBox(
            value = paste0(res, "%"),
            subtitle = "Proportion screened",
            icon = icon("search"),
            color = if (res >= 5) "yellow" else "aqua"
        )
    })
    
    output$udredt <- renderValueBox({

        res <- round((input$pat*input$scrpat*input$sens+(100-input$pat)*input$scrnopat*(100-input$spec))/(100*100), 2)
        
        valueBox(
            value = paste0(res, "%"),
            subtitle = "Proportion examined by MD",
            icon = icon("user-md"),
            color = "blue"
        )
    })


#    Proportion correctly cleared of asymptomatic abnormality
    output$homefree <- renderValueBox({

        res <- round(((input$pat*input$scrpat*(100-input$sens)*(100-input$sickpat)/(100*100*100) + (100-input$pat)*(input$scrnopat)*input$spec)/(100*100)), 2)        
        
        valueBox(
            value = paste0(res, "%"),
            "Proportion cleared of disease",
            icon = icon("thumbs-o-up"),
            color="green"
        )
    })

    
    
    output$odiag <- renderValueBox({

        res <- round((input$pat*input$scrpat*input$sens*(100-input$sickpat)/(100*100*100)), 2)
                
        valueBox(
            value = paste0(res, "%"),
            "Proportion overdiagnosed",
            icon = icon("meh-o"),
            color="red"
        )
    })


    output$truepos <- renderValueBox({

        res <- round((input$pat*input$scrpat*input$sens*(input$sickpat)/(100*100*100)), 2)

        valueBox(
            value = paste0(res, "%"),
            "Proportion identified by screening who would get clinically manifest disease",
            icon = icon("notes-medical"),
            color="blue"
        )
    })
    
    output$missed <- renderValueBox({
        ## Has path, is screened, 

#        res <- round((input$pat*input$scrpat*(100-input$sens)*(input$sickpat)/(100*100*100)), 2)
        res <- round((input$pat*input$scrpat*(100-input$sens)*(input$sickpat)/(100*100*100)), 2)

        input$pat*(input$sickpat)
        
        valueBox(
            value = paste0(res, "%"),
            "Proportion with clinically manifest disease missed by screening",
#            icon = icon("frown-o"),
            color="purple"
        )
    })


    output$stepplot <- renderPlot({
        
        res <- round((input$pat*input$scrpat*input$sens*(100-input$sickpat)/(100*100*100)), 2)
        n <- 1:30

        par(mar=c(4, 4, .1, 0)+.1, cex=1.4)
        plot(n, 100*(1-(1-res/100)^n), type="s",
             ylim=c(0, 100), col="red", lwd=2, 
             ylab="Prob. of at least one over-diagnosis", xlab="Number of features")
    })

    
}


