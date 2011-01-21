var site_url = '';
var nav  = [ '#home', '#about', '#services', '#solutions', '#contact' ];

$(document).ready(function(){
    setBkgPos();
    
  $("#navigation > div").each(function(){
        $(this).bind( 'mouseover', mMouseOver );
        $(this).bind( 'mouseout', mMouseOut );
        $(this).bind( 'click', mClick );
  });
    $("#navigation > div.active").each(function(){
    $(this).animate({ backgroundPosition:'(' + _getHPos( $(this).attr("id") ) +' -30px}'},"fast",
      function(){
        $(this).children()
          .animate({backgroundPosition:'(0px -40px)'},20)
          .animate({backgroundPosition:'(0px -20px)'},"fast");
        $(this)
          .animate({backgroundPosition:'(' + _getHPos( $(this).attr("id") ) +' 50px)'},"fast")
          .animate({backgroundPosition:'(' + _getHPos( $(this).attr("id") ) +' 25px)'},"fast");
        $(this).children()
          .animate( {backgroundPosition:'(0px -45px)'},"fast",
            function(){
              $(parent).animate({backgroundPosition:'(' + _getHPos( $(this).parent().attr("id") ) +' 25px)'},"fast");
              $(parent).css({backgroundImage: 'url(images/nav.png)'});
            });
      });
    });
}); 

function _getHPos( id )
{
    if( id.indexOf("#") < 0 ){
        id = "#"+ id ;
    }
    var bgPosAry = $(id).css("background-position").split(" ");
    return bgPosAry[0];
}

function setBkgPos()
{
    for ( i = 0; i < nav.length; i++ ){
        $(nav[i]).css({backgroundPosition: i*(-98) + 'px -25px'});
        $(nav[i] + ' div').css({ backgroundPosition: '0px -60px'});
    }
}

function mMouseOver(e)
{
    if ( this.className.indexOf('active') >= 0  ){
        return;
    }
    
    $(this)
        .stop()
        .css({backgroundImage: 'url(images/nav-over.png)',cursor: 'pointer'})
        .animate({ backgroundPosition:'(' + _getHPos( this.id ) +' -30px}'},"fast",
            function(){ 
                $(this)
                    .children()
                        .animate({backgroundPosition:'(0px -40px)'},20)
                        .animate({backgroundPosition:'(0px -20px)'},"fast");
                $(this)
                    .animate({backgroundPosition:'(' + _getHPos( this.id ) +' 50px)'},"fast")
                    .animate({backgroundPosition:'(' + _getHPos( this.id ) +' 25px)'},"fast");
                var parent = this;
                $(this)
                    .children()
                        .animate( {backgroundPosition:'(0px -45px)'},"fast",
                            function(){
                                $(parent).css({backgroundImage: 'url(images/nav.png)'});
                            });
            
            });
}

function mMouseOut(e)
{           
    if ( this.className.indexOf('active') >= 0  ){
        return;
    }
    
    $(this)
        .stop()
        .animate({backgroundPosition:'(' + _getHPos( this.id ) +' 40px )'}, "fast", 
            function(){
                $(this).children().animate({backgroundPosition:'(0px 70px)'}, "fast");
                $(this).animate( {backgroundPosition:'(' + _getHPos( this.id ) +' -40px)'}, "fast", 
                    function(){
                        $(this).animate( {backgroundPosition:'(' + _getHPos( this.id ) +' -25px)'}, "fast",
                            function(){
                                $(this).children().css({ backgroundPosition:'0px -60px'});
                            })
                    })
            })
        .css({backgroundImage: 'url(images/nav.png)', cursor: ''});
}

function mClick(e)
{
    location.href = $(this).children().children().attr("href");
}
