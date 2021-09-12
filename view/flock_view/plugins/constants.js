// const apiBaseUrl = 'https://flock-api.masashi-oba.net'
// const summaryBaseUrl = 'https://flock-text-summary.masashi-oba.net'
const apiBaseUrl = 'http://localhost:3000'
const summaryBaseUrl = 'http://localhost:9000'

export default (context, inject) => {
  // 定数を共通化  
  inject('apiBaseUrl', apiBaseUrl)
  inject('summaryBaseUrl', summaryBaseUrl)
}
