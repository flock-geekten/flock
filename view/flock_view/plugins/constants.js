const apiBaseUrl = 'https://flock-api.masashi-oba.net'
const summaryBaseUrl = 'https://flock.masashi-oba.net:9000'

export default (context, inject) => {
  // 定数を共通化  
  inject('apiBaseUrl', apiBaseUrl)
  inject('summaryBaseUrl', summaryBaseUrl)
}
