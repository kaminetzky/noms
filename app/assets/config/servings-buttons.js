document.addEventListener("DOMContentLoaded", function(event) { 
  function setServings(input, value) {
    input.value = value;
  }

  const servingsButtons = document.querySelectorAll('.servings-button');
  const servingsInput = document.querySelector('input#meal_servings')
  servingsButtons.forEach(button => button.addEventListener(
    'click', () => setServings(servingsInput, button.textContent)
  ));
});