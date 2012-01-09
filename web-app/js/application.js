var Ajax;
if (Ajax && (Ajax != null)) {
    Ajax.Responders.register({
        onCreate: function() {
            if($('spinner') && Ajax.activeRequestCount>0)
                Effect.Appear('spinner',{
                    duration:0.5,
                    queue:'end'
                });
        },
        onComplete: function() {
            if($('spinner') && Ajax.activeRequestCount==0)
                Effect.Fade('spinner',{
                    duration:0.5,
                    queue:'end'
                });
        }
    });
}

var tryToGuessCategoryWithTiersId = function (tiersId, inputToUpdate) {
 
    jQuery.ajax(
    {
        type:'GET',
        url:'/epsilon/operation/guessCategory/'+tiersId,
        success: function(data,textStatus){
            //alert (data + textStatus);
            jQuery('#'+inputToUpdate).val(data);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
        
    return false;
 
}