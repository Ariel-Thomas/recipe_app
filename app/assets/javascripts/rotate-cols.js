function rotate(){
  var $col = $('.directions-col');
  var prevHeight = 0;

  $col.each(function(col_index){
    //Handle column margins
    var $cur_col =  $(this);
    var $text = $cur_col.children('.directions-text');

    if ($text.length === 0) { return true; }      
    var norotate = $text.hasClass('no-rotate');

    var curHeight = $text.height() / 2 - $cur_col.width() / 2 - 10;
    curHeight = Math.round(curHeight);

    if (norotate) { curHeight = $text.width() / 2 - $cur_col.width() / 2; }
    
    $cur_col.css({'margin-left': curHeight + prevHeight});

    var prevWidth = 0;
            
    $text.each(function(text_index){
      var $cur_text =  $(this);

      var border_width = parseInt($cur_text.children('.directions-present').css("border-left-width"),10);

      if(isNaN(border_width))
        border_width = 0;

      var curWidth = $cur_text.width() / 2 - $cur_text.height() / 2;         
      curWidth = Math.round(curWidth);
      
      if (norotate) { curWidth = 0; }
      $cur_text.css({'margin-top': curWidth + prevWidth });

      prevWidth = curWidth - border_width;
      
      //Rotate
      if (!norotate){
        $cur_text.addClass('rotate-right');
      }
    });
    
    prevHeight = curHeight + 10;
  });        
}

//Run rotate when page is loaded
$(function () { rotate(); });

function clearText(){
  index = 0;
  $cur_col = $('.text-col' + index);
  while ($cur_col.length != 0){
    $cur_col.html('');

    index += 1;
    $cur_col = $('.text-col' + index);
  }
}

function toggleActive(element){
  $element = $(element);

  if ($element.hasClass('active-tab')){
    $element.removeClass('active-tab');
  }
  else{
    $('.active-tab').removeClass('active-tab');
    $element.addClass('active-tab'); 
  }
 
  $element.stop();
}

function showText(index, text, element){
  $textcol = $('.text-col' + index);

  //if(/\S/.test($textcol.html()))
  if (~$textcol.html().indexOf(text))
    { clearText(); rotate(); return;}

  clearText();

  $textcol = $('.text-col' + index);
  
  $textcol.html('<div class="directions-text no-rotate">' + '<div class="center-text">' + text + '</div>' + '</div>');

  height = $(".ingredients-col").height();
  $('.no-rotate').css({ 'height': height });
  $('.no-rotate').click(function() { toggleActive(element); clearText(); rotate(); });

  $('.center-text').css({'margin-top':  - $('.center-text').height() / 2 - 20})
  rotate();
}

