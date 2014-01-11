Chart = require '../models/chart'

exports.actions = (req, res, ss) ->

  req.use('session')

  findOne: (details) ->
    Chart.findOne details, (err, chart) ->
      if err
        res success: false, message: err
      else
        res success: true, {chart}

  # find: (details) ->
  #   Chart.find details, (err, chart) ->
  #     if err
  #       res success: false, message: err
  #     else
  #       res success: true, {chart}

  add: (details) ->
    chart = new Chart details
    chart.save (err) ->
      throw err if err
      res success: true, chart: chart
