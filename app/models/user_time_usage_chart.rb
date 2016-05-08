class UserTimeUsageChart

  CHART_OPTIONS = {
    border_width:       2,
    point_radius:       2,
    point_hover_radius: 2,
    point_hit_radius:   20,
    dev: {
      background_color:   "rgba(127, 255, 127, 0.2)",
      border_color:       "rgba(127, 255, 127, 1)",
      point_color:        "rgba(127, 255, 127, 1)"
    },
    bugs: {
      background_color:   "rgba(255, 127, 127, 0.2)",
      border_color:       "rgba(255, 127, 127, 1)",
      point_color:        "rgba(255, 127, 127, 1)"
    }
  }

  def initialize(user)
    @user = user
  end

  def chart_data
    weeks = [
      (Date.today.beginning_of_week(:monday) - 10.week).to_s,
      (Date.today.beginning_of_week(:monday) - 9.week).to_s,
      (Date.today.beginning_of_week(:monday) - 8.week).to_s,
      (Date.today.beginning_of_week(:monday) - 7.week).to_s,
      (Date.today.beginning_of_week(:monday) - 6.week).to_s,
      (Date.today.beginning_of_week(:monday) - 5.week).to_s,
      (Date.today.beginning_of_week(:monday) - 4.week).to_s,
      (Date.today.beginning_of_week(:monday) - 3.week).to_s,
      (Date.today.beginning_of_week(:monday) - 2.week).to_s,
      (Date.today.beginning_of_week(:monday) - 1.week).to_s
    ]

    {
      labels: [weeks[0], weeks[1], weeks[2], weeks[3], weeks[4], weeks[5], weeks[6], weeks[7], weeks[8], weeks[9]],
      datasets: [
        {
          label: "Communication",
          backgroundColor: "rgba(127,127,255,0.2)",
          strokeColor: "rgba(127,127,255,1)",
          pointColor: "rgba(127,127,255,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,127,255,1)",
          data: [
            average(@user.total_communication_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_communication_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_communication_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_communication_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_communication_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_communication_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_communication_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_communication_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_communication_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_communication_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Development",
          backgroundColor: "rgba(127,255,127,0.2)",
          strokeColor: "rgba(127,255,127,1)",
          pointColor: "rgba(127,255,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,255,127,1)",
          data: [
            average(@user.total_development_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_development_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_development_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_development_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_development_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_development_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_development_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_development_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_development_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_development_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Bugs",
          backgroundColor: "rgba(255,127,127,0.2)",
          strokeColor: "rgba(255,127,127,1)",
          pointColor: "rgba(255,127,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,127,127,1)",
          data: [
            average(@user.total_bugs_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_bugs_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_bugs_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_bugs_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_bugs_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_bugs_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_bugs_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_bugs_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_bugs_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_bugs_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Code Review",
          backgroundColor: "rgba(127,127,127,0.2)",
          strokeColor: "rgba(127,127,127,1)",
          pointColor: "rgba(127,127,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,127,127,1)",
          data: [
            average(@user.total_code_review_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_code_review_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_code_review_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_code_review_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_code_review_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_code_review_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_code_review_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_code_review_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_code_review_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_code_review_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "QA",
          backgroundColor: "rgba(255,255,127,0.2)",
          strokeColor: "rgba(255,255,127,1)",
          pointColor: "rgba(255,255,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,255,127,1)",
          data: [
            average(@user.total_qa_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_qa_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_qa_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_qa_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_qa_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_qa_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_qa_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_qa_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_qa_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_qa_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Infrastructure",
          backgroundColor: "rgba(255,191,127,0.2)",
          strokeColor: "rgba(255,191,127,1)",
          pointColor: "rgba(255,191,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,191,127,1)",
          data: [
            average(@user.total_infraestructure_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_infraestructure_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_infraestructure_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_infraestructure_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_infraestructure_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_infraestructure_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_infraestructure_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_infraestructure_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_infraestructure_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_infraestructure_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "UI/UX",
          backgroundColor: "rgba(191,127,255,0.2)",
          strokeColor: "rgba(191,127,255,1)",
          pointColor: "rgba(191,127,255,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(191,127,255,1)",
          data: [
            average(@user.total_uxui_for_week(weeks[0]), @user.total_hours_for_week(weeks[0])),
            average(@user.total_uxui_for_week(weeks[1]), @user.total_hours_for_week(weeks[1])),
            average(@user.total_uxui_for_week(weeks[2]), @user.total_hours_for_week(weeks[2])),
            average(@user.total_uxui_for_week(weeks[3]), @user.total_hours_for_week(weeks[3])),
            average(@user.total_uxui_for_week(weeks[4]), @user.total_hours_for_week(weeks[4])),
            average(@user.total_uxui_for_week(weeks[5]), @user.total_hours_for_week(weeks[5])),
            average(@user.total_uxui_for_week(weeks[6]), @user.total_hours_for_week(weeks[6])),
            average(@user.total_uxui_for_week(weeks[7]), @user.total_hours_for_week(weeks[7])),
            average(@user.total_uxui_for_week(weeks[8]), @user.total_hours_for_week(weeks[8])),
            average(@user.total_uxui_for_week(weeks[9]), @user.total_hours_for_week(weeks[9]))
          ]
        }
      ]
    }
  end

  private

  def average(value, total)
    if total == 0.0
      0
    else
      (value * 100 / total).round(1)
    end
  end

end
