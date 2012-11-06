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
      var curWidth = $cur_text.width() / 2 - $cur_text.height() / 2;         
      curWidth = Math.round(curWidth);
      
      if (norotate) { curWidth = 0; }
      $cur_text.css({'margin-top': curWidth + prevWidth });
              
      prevWidth = curWidth;
      
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

function showText(index, text){
  $textcol = $('.text-col' + index);

  //if(/\S/.test($textcol.html()))
  if (~$textcol.html().indexOf(text))
    { clearText(); rotate(); return;}

  clearText();

  $textcol = $('.text-col' + index);
  
  $textcol.html("<div class='directions-text no-rotate '>" +
    text + "</div>");

  $('.no-rotate').css({ 'height': $(".ingredients-col").height() });

  rotate();
}