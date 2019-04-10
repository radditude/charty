import Chart from 'chart.js'

let ExampleChart = {
  buildChart(socket) {
    let ctx = document.getElementById('exampleChart')
    let examples = JSON.parse(
      document.getElementById('exampleData').dataset.examples,
    )
    let counts = JSON.parse(
      document.getElementById('exampleData').dataset.counts,
    )
    let chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: examples,
        datasets: [
          {
            label: '# of Examples',
            data: counts,
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
            ],
          },
        ],
      },
      options: {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
            },
          ],
        },
      },
    })

    this.listenForUpdates(socket, chart)
  },

  listenForUpdates(socket, chart) {
    let channel = socket.channel('chart:example', {})
    channel
      .join()
      .receive('ok', (resp) => {
        console.log('Joined successfully', resp)
      })
      .receive('error', (resp) => {
        console.log('Unable to join', resp)
      })

    channel.on('new_example', (payload) => {
      chart.data.datasets.forEach((dataset) => {
        dataset.data = JSON.parse(payload.body)
      })

      chart.update()
    })
  },
}

export default ExampleChart
