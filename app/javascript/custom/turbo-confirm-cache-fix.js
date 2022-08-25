;(function () {
  var ua = window.navigator.userAgent
  var isIpad = ua.indexOf('(iPad') > -1
  var isIphone = ua.indexOf('(iPhone') > -1 || ua.indexOf('(iPod') > -1
  var isChrome = ua.indexOf('Chrome/') > -1 || ua.indexOf('CriOS/') > -1
  var isSafari = !isChrome && ua.indexOf('Safari/') > -1
  var isIosSafari = (isIpad || isIphone) && isSafari

  if (isIosSafari) {
    var popped
    window.addEventListener('popstate', function () { popped = true })
    
    document.addEventListener('turbo:before-render', function (event) {
      if (popped && event.detail.newBody.querySelector('[data-turbo-confirm]')) {
        window.location.reload()
      }
    })
  }
})()