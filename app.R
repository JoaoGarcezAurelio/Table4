source("data_cleaning.R")

thematic_shiny()

ui <- page_fluid(
  theme = bs_theme(preset = "minty"),
  headerPanel("Table 4 - Outcome of the quality appraisal across individual studies"),
  reactableOutput("Table4"),
  textInput("footnote", "Note. Studies with an asterisk(*) assessed dosage only; the maximum score they can receive across Section 2, and the checklist, is 12 and 29 respectively. All other studies can score 19 and 36 across Section 2 and the checklist respectively.",
            width = "100%")
)

server <- function(input, output) {
output$Table4 <- renderReactable({
  reactable(Table4,
            theme = default(centered = TRUE),
            filterable = TRUE,
            bordered = FALSE,
            striped = FALSE,
            highlight = TRUE,
            searchable = TRUE,
            defaultPageSize = 16,
            columnGroups = list(
              colGroup(name = "Section Scores - Total Score",
                       columns = c("Section 1 - Study Design Score",
                                   "Section 2 - Implementation - Data Collection Score",
                                   "Section 3 - Implementation - Data Analysis Score")
              )
            ),
            columns = list(
              Study_ID = colDef(
                align = "center",
                maxWidth = 130,
                name = "Study ID",
                cell = function(value, index) {
                  label1 <- DOITable[index, "Study_ID"] # had to create a separate file for the DOIs to be read because I kept failing to get them using Table 4
                  DOI <- DOITable[index, "DOI"]
                  htmltools::div(
                    htmltools::p(
                      htmltools::tags$a(href = DOI, target = "_blank", label1)
                    ),
                  )
                }
              ),
              "First Author" = colDef(
                align = "left",
                maxWidth = 130
              ),
              Year = colDef(
                align = "center",
                maxWidth = 130
              ),
              Country = colDef(
                header = with_tooltip("Country", 
                                      "Country where data was collected"),
                maxWidth = 130
              ),
              CountryFlag = colDef(
                name = "",
                maxWidth = 70,
                align = "center",
                cell = embed_img("Country",
                                 height = "25",
                                 width = "40")),
              "Total Score" = colDef(
                align = "center",
                header = with_tooltip("Total Score", 
                                      "Sum score of Sections 1, 2, and 3"),
                cell = data_bars(Table4,
                                 text_position = "center",
                                 round_edges = TRUE,
                                 box_shadow = TRUE,
                                 bar_height = 15)
              ),
              "Percentage_Score" = colDef(
                align = "center",
                header = with_tooltip("Percentage Score", 
                                      "0-100%, with 100% being maximum possible score"),
                cell = data_bars(Table4,
                                 text_position = "center",
                                 round_edges = TRUE,
                                 box_shadow = TRUE,
                                 bar_height = 15)
              ),
              "Section 1 - Study Design Score" = colDef(
                align = "center",
                header = with_tooltip(
                  "Section 1 Score", 
                  "Score assigned to Study Design"),
                cell = data_bars(Table4,
                                 text_position = "center",
                                 round_edges = TRUE,
                                 box_shadow = TRUE,
                                 bar_height = 15)),
              "Section 2 - Implementation - Data Collection Score" = colDef(
                align = "center",
                header = with_tooltip(
                  "Section 2 Score", 
                  "Score assigned to Data Collection process"),
                cell = data_bars(Table4,
                                 text_position = "center",
                                 round_edges = TRUE,
                                 box_shadow = TRUE,
                                 bar_height = 15)),
              "Section 3 - Implementation - Data Analysis Score" = colDef(
                align = "center",
                header = with_tooltip(
                  "Section 3 Score", 
                  "Score assigned to Data Analysis process"),
                cell = data_bars(Table4,
                                 text_position = "center",
                                 round_edges = TRUE,
                                 box_shadow = TRUE,
                                 bar_height = 15)),
              "Classification" = colDef(
                header = with_tooltip("Classification", "Overall classification"),
                align = "center",
                minWidth = 90,
                cell = pill_buttons(Table4,
                                    color_ref = "Classification_colours", 
                                    opacity = 0.7),
              ),
              "Classification_colours" = colDef(
                show = FALSE)
            )
  )
})

}

# Run the application 
shinyApp(ui = ui, server = server)
