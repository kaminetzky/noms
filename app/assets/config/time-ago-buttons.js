document.addEventListener("DOMContentLoaded", function(event) { 
  function setConsumedOnWithOffset(input, value) {
    const minutes_ago =  parse_time_ago(value)
    let now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset() - minutes_ago);
    input.value = now.toISOString().slice(0,19);
  }

  function parse_time_ago(str) {
    const str_split = str.slice(1).split(':');
    return (+str_split[0] * 60) + (+str_split[1]);
  }

  const servingsButtons = document.querySelectorAll('.time-ago-button');
  const servingsInput = document.querySelector('input#meal_consumed_on')
  servingsButtons.forEach(button => button.addEventListener(
    'click', () => setConsumedOnWithOffset(servingsInput, button.textContent)
  ));
});