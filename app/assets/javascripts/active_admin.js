//= require active_admin/base
//= require chosen-jquery
//= require select2





var ready;
ready = function() {
   var tagLists = $.ajax({url : "/tag_list.json", async: false});
  $(".chosen-select").chosen({no_results_text: "Oops, nothing found!"}); 
   $(".chosen-input").chosen({no_results_text: "Oops, nothing found!"}); 
   $(".e12").select2({tags:tagLists.responseJSON});
   if($('.post').length >0)
   {
      var select, chosen;
    // cache the select element as we'll be using it a few times
    // select = $(".chosen-input");
    select = $(".chosen-input");
    // init the chosen plugin
    select.chosen();
        // get the chosen object
    chosen = select.data('chosen');
    // Bind the keyup event to the search box input
    chosen.dropdown.find('input').on('keyup', function(e)
    {
        // if we hit Enter and the results list is empty (no matches) add the option
        if (e.which == 13 && chosen.dropdown.find('li.no-results').length > 0)
        {
            var option = $("<option>").val(this.value).text(this.value);
           
            // add the new option
            select.prepend(option);
            // automatically select it
             select.find(option).prop('selected', true);
            // trigger the update
            select.trigger("chosen:updated");
        }
    });

   }
  
};

$(document).ready(ready);
$(document).on('page:load', ready);