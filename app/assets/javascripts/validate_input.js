function findErrors(){
  var any_errors = false;
  var $button = $('#recipe_next');

  if (findNameErrors()) any_errors = true;
  if (findDescErrors()) any_errors = true;
  if (findIngredientErrors()) any_errors = true;

  if (any_errors)
    $button.attr("disabled","disabled");  
  else
    $button.removeAttr("disabled");
};


function isEmptyError(fieldName,fieldContent,errorDiv)
{
  if (!fieldContent){
    errorDiv.html(makeErrorHtml(fieldName + " cannot be left blank"))
    return true;
  }
};

function findNameErrors(){
  var $fieldContent = $('#recipe_name').val()
  var $errorDiv = $('#name_error')  

  if (isEmptyError("Name", $fieldContent, $errorDiv))
    return true;

  $errorDiv.html('<br>');
  return false;
};

function findDescErrors(){
  var $fieldContent = $('#recipe_description').val()
  var $errorDiv = $('#desc_error')  

  if (isEmptyError("Description", $fieldContent, $errorDiv))
    return true;

  $errorDiv.html('<br>');
  return false;
};    


function findIngredientErrors(){
  var $fieldContent = $('#Ingredients').val()
  var $errorDiv = $('#ingredient_error')

  if (isEmptyError("Ingredients", $fieldContent, $errorDiv))
    return true;

  if (!areValidIngredients($fieldContent))
  {
    $errorDiv.html(makeErrorHtml("Ingredients must be formated [amount] [measurement] [name of ingredient]."));

    return true;
  }

  $errorDiv.html('<br>');
  return false;
};

function areValidIngredients(text)
{
  var temp_array = text.replace(/\s*$/gim,"").replace(/^\s*$\n/gim,"").split('\n')

  var result = true;

  temp_array.map(function(ingredient){
    if (ingredient.match(/^\d+ \w+/im) == null)
      result = false;
    if (ingredient.replace(/^\d+ \w+/im,"") == "")
      result = false;
  });

  return result;
};

function makeErrorHtml(message){
  return '<span class="alert alert-error">' + message + '</span>'
};