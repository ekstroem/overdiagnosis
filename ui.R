## ui.R ##
library("shiny")
library("shinydashboard")
library("shinyWidgets")

dashboardPage(
    dashboardHeader(title = "Evaluating overdiagnosis", titleWidth = "25%"),
    dashboardSidebar(collapsed=TRUE,
                     HTML(paste0(h3("Estimation of over-diagnosis"),
                                 "The app estimates the risk of over-diagnosis for a random individual in a population.", br(),
                                 "Note the following assumptions: if a screening result is positive (indicative of the pathology) then ",
                                 "a person will have a thorough medical examination in order to get the clinical diagnosis. EVERYONE with a positive ",
                                 "screening result will get that.", br(),
                                 br(),br(),br(),br(),br(),br(),br(),
                                 "App created by Claus Thorn Ekstrøm for the paper 'Much more medicine: Why big data screening means more overdiagnosis' by Henrik Vogt, Sara Green, Claus Thorn Ekstrøm and John Brodersen."))),
    dashboardBody(
        
        fluidRow(
            column(width = 3,
                   tags$div(title=paste0("The probability that a single random individual will be screened based on a single feature. ",
                                         "This is also the proportion of the population that is screened if screening is only based on ",
                                         "that one feature."),
                            valueBoxOutput("screened", width=NULL)
                            ),
                   tags$div(title=paste0("The probability that a single random individual will be screened for a single feature, and that the ",
                                         "screening result will be positive (indicative of pathology). All patients with positive screening ",
                                         "results will be udredt."),
                            valueBoxOutput("udredt", width=NULL)
                            ),
                   tags$div(title=paste0("The probability that a single random individual will be screened for a single feature, and that the ",
                                         "screening result will be correctly negative (indicative of no pathology, or a missed pathology that ",
                                         "would not result in a clinical diagnosis anyway"),
                            valueBoxOutput("homefree", width=NULL)
                            )
                   ),
            column(width = 3,
                   tags$div(title=paste0("The probability that a single random individual has the pathology, ends up being screened, ",
                                         "the screening test is positive, but the person never gets the clinical diagnosis."),
                            valueBoxOutput("odiag", width=NULL)
                            ),
                   tags$div(title=paste0("The probability that a single random individual will be screened, the screening will be ",
                                         "positive (indicative of pathology) and the person will end up with a clinical dianosis."),
                            valueBoxOutput("truepos", width=NULL)
                            ),
                   tags$div(title=paste0("The probability that a single random individual has the pathology and is screened, but the screening ",
                                         "is negative and the person ends up with the clinical diagnosis anyway."),
                            valueBoxOutput("missed", width=NULL)
                            )
                   ),
            column(width = 6,
                   tags$div(title=paste0("The proportion of being overdiagnosed for at least one feature as the number of features ",
                                         "that we screen for increases (each feature is independent and has the same risk of over-diagnosis."),
                            plotOutput("stepplot", height=350 )
                            )                   
                   )
        ),
        
        fluidRow(
            tags$div(title="The probability that the pathology is present in a random individual.",
            box(
                width = 2, status = "info", solidHeader = TRUE,
                title = "Proportion of population with asymptomatic abnormality",
                knobInput(
                    inputId = "pat", 
                    label = "", 
                    value = 20, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            )),
            tags$div(title="The probability that the individual will get a clinical diagnosis IF the pathology is present and the person is examined.",
            box(
                width = 2, status = "info", solidHeader = TRUE,
                title = "Clinical diag if pathology",
                knobInput(
                    inputId = "sickpat", 
                    label = "", 
                    value = 80, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            )),
            tags$div(title="The probability that a person will be screened if he/she has the pathology.",
            box(
                width = 2, status = "warning", solidHeader = TRUE,
                title = "Screened if pathology",
                knobInput(
                    inputId = "scrpat", 
                    label = "", 
                    value = 100, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            )),
            tags$div(title="The probability that a person will be screened if he/she does NOT have the pathology.",
            box(
                width = 2, status = "warning", solidHeader = TRUE,
                title = "Screened if no pathology",
                knobInput(
                    inputId = "scrnopat", 
                    label = "", 
                    value = 100, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            )),
            tags$div(title="The probability that the screening will return positive if the person has the pathology and is screened.",
            box(
                width = 2, status = "primary", solidHeader = TRUE,
                title = "Sensitivity of screening with regard to asymptomatic abnormalities",
                knobInput(
                    inputId = "sens", 
                    label = "", 
                    value = 90, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            )),
            tags$div(title="The probability that the screening will return negative if the person does NOT have the pathology and is screened.",
            box(
                width = 2, status = "primary", solidHeader = TRUE,
                title = "Specificity with regard to asymptomatic abnormalities",
                knobInput(
                    inputId = "spec", 
                    label = "", 
                    value = 95, 
                    min=0,
                    max=100,
                    step=0.1,
                    angleOffset=-90,
                    angleArc = 180,
                    thickness = 0.3, 
                    cursor = FALSE, 
                                        #               width = 150,
                                        #               height = 150,
                    fgColor="Blue",
                    bgColor="Darkgrey",
                    width="100%"
                )
            ))
            
        )
        
    )
)



